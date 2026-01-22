import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

class AiNotificationService {
  static const int _maxTitleLength = 40;
  static const int _maxBodyLength = 120;
  static const String _model = 'gemini-2.5-flash';

  const AiNotificationService();

  Future<void> generateForWeekSchedule(
    Session session,
    int weekScheduleId,
  ) async {
    session.log(
      'AI notifications: start generation for weekScheduleId=$weekScheduleId.',
    );
    final apiKey = _readApiKey(session);
    if (apiKey.isEmpty) {
      session.log('Gemini API key missing; skipping AI notification copy.');
      return;
    }
    session.log('AI notifications: Gemini API key found.');

    final userId = _requireUserId(session);
    session.log('AI notifications: resolved userId=${userId.uuid}.');
    final profile = await _loadProfile(session, userId);
    if (profile == null) {
      session.log('Profile missing; skipping AI notification copy.');
      return;
    }
    session.log(
      'AI notifications: loaded profileId=${profile.id}, goals=${profile.goals?.length ?? 0}.',
    );

    final weekSchedule = await _loadWeekSchedule(session, weekScheduleId);
    if (weekSchedule == null) {
      session.log('Week schedule missing; skipping AI notification copy.');
      return;
    }
    session.log(
      'AI notifications: loaded weekScheduleId=${weekSchedule.id}, days=${weekSchedule.days?.length ?? 0}.',
    );

    final goals = _extractGoals(profile);
    final updateContext = _buildNotificationUpdateContext(
      weekSchedule.days ?? <DaySchedule>[],
    );
    if (updateContext.isEmpty) {
      session.log('AI notifications: no notifications found to update.');
      return;
    }

    final prompt = _buildBatchPrompt(
      profile: profile,
      goals: goals,
      weekSchedule: weekSchedule,
      notificationContext: updateContext.map((entry) => entry.prompt).toList(),
    );
    session.log(
      'AI notifications: prompt built (${prompt.length} chars), calling Gemini.',
    );
    session.log('AI notifications: prompt=$prompt');

    Map<int, NotificationCopy> copies;
    try {
      copies = await _generateBatchCopy(
        session: session,
        apiKey: apiKey,
        prompt: prompt,
      );
    } catch (error) {
      session.log('AI notifications: generation failed: $error');
      return;
    }

    if (copies.isEmpty) {
      session.log('AI notifications: Gemini returned no usable copies.');
      return;
    }
    session.log(
      'AI notifications: received ${copies.length} copies, updating notifications.',
    );

    var updatedCount = 0;
    for (final entry in updateContext) {
      final notification = entry.notification;
      final copy = copies[entry.prompt.id];
      if (copy == null) {
        session.log(
          'AI notifications: no copy returned for notificationId=${entry.prompt.id}.',
        );
        continue;
      }

      final updated = notification.copyWith(
        title: copy.title,
        body: copy.body,
        updatedAt: DateTime.now(),
      );

      await Notification.db.updateRow(
        session,
        updated,
        columns: (t) => [
          t.title,
          t.body,
          t.updatedAt,
        ],
      );
      updatedCount++;
    }
    session.log(
      'AI notifications: updated $updatedCount notifications successfully.',
    );
  }

  Future<List<NotificationCopy>> generatePlannedCopies(
    Session session,
    WeekSchedule weekSchedule,
  ) async {
    session.log('AI notifications: start planned generation.');
    final apiKey = _readApiKey(session);
    if (apiKey.isEmpty) {
      throw ServerpodException(
        message: 'AI service is not configured. Please try again later.',
        errorCode: 503,
      );
    }

    final userId = _requireUserId(session);
    final profile = await _loadProfile(session, userId);
    if (profile == null) {
      throw ServerpodException(
        message: 'Profile missing. Please try again later.',
        errorCode: 404,
      );
    }

    final promptContext = _buildPlannedPromptContext(
      weekSchedule.days ?? <DaySchedule>[],
    );
    if (promptContext.isEmpty) {
      session.log('AI notifications: no planned notifications found.');
      return <NotificationCopy>[];
    }

    final prompt = _buildBatchPrompt(
      profile: profile,
      goals: _extractGoals(profile),
      weekSchedule: weekSchedule,
      notificationContext: promptContext,
    );
    session.log(
      'AI notifications: planned prompt built (${prompt.length} chars), calling Gemini.',
    );

    final copies = await _generateBatchCopy(
      session: session,
      apiKey: apiKey,
      prompt: prompt,
    );

    final orderedCopies = <NotificationCopy>[];
    for (var i = 0; i < promptContext.length; i++) {
      final copy = copies[i];
      if (copy == null) {
        throw ServerpodException(
          message: 'AI response incomplete. Please try again later.',
          errorCode: 503,
        );
      }
      orderedCopies.add(copy);
    }

    return orderedCopies;
  }

  String _readApiKey(Session session) =>
      session.passwords['geminiKey']?.trim() ?? '';

  UuidValue _requireUserId(Session session) {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw ServerpodException(
        message: 'User is not authenticated.',
        errorCode: 401,
      );
    }

    return UuidValue.withValidation(authInfo.userIdentifier);
  }

  Future<Profile?> _loadProfile(
    Session session,
    UuidValue userId,
  ) {
    return Profile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
      include: Profile.include(
        goals: Goal.includeList(),
      ),
    );
  }

  Future<WeekSchedule?> _loadWeekSchedule(
    Session session,
    int weekScheduleId,
  ) {
    return WeekSchedule.db.findById(
      session,
      weekScheduleId,
      include: WeekSchedule.include(
        days: DaySchedule.includeList(
          include: DaySchedule.include(
            notifications: Notification.includeList(),
          ),
        ),
      ),
    );
  }

  List<String> _extractGoals(Profile profile) {
    return (profile.goals ?? <Goal>[])
        .map((goal) => goal.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();
  }

  String _buildBatchPrompt({
    required Profile profile,
    required List<String> goals,
    required WeekSchedule weekSchedule,
    required List<_PromptNotificationContext> notificationContext,
  }) {
    final goalText = goals.isEmpty
        ? 'No specific goals listed.'
        : goals.join(', ');
    final tone = profile.notificationTone.trim();
    final character = profile.characterName.trim();
    final motivation = profile.motivation.trim();
    final fitnessLevel = profile.fitnessLevel.trim();
    final buffer = StringBuffer()
      ..writeln('You write short, motivating workout notifications.')
      ..writeln('Constraints:')
      ..writeln(
        '- Return JSON only: {"items":[{"id":123,"title":"...","body":"..."}]}',
      )
      ..writeln(
        '- Title max $_maxTitleLength chars, body max $_maxBodyLength chars.',
      )
      ..writeln('- Do not use code fences or markdown.')
      ..writeln('- Tone: $tone (supportive but slightly pushy).')
      ..writeln(
        '- Make each message feel personal and anchored to the user profile.',
      )
      ..writeln(
        '- Reference motivation, goals, fitness level, and tone directly.',
      )
      ..writeln('- Avoid generic slogans; be specific to the user.')
      ..writeln('- Keep wording consistent and not random.')
      ..writeln('- Mention the character "$character" if it feels natural.')
      ..writeln('')
      ..writeln('User context:')
      ..writeln('- Motivation: $motivation')
      ..writeln('- Goals: $goalText')
      ..writeln('- Fitness level: $fitnessLevel');

    buffer.writeln('');
    buffer.writeln('Notifications to write:');
    for (final entry in notificationContext) {
      buffer
        ..writeln('- id: ${entry.id}')
        ..writeln('  day: ${entry.dayLabel}')
        ..writeln('  scheduled: ${entry.scheduledDate}');
    }

    return buffer.toString();
  }

  Future<Map<int, NotificationCopy>> _generateBatchCopy({
    required Session session,
    required String apiKey,
    required String prompt,
  }) async {
    const maxAttempts = 5;
    const delays = [
      Duration(milliseconds: 500),
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 3),
      Duration(seconds: 5),
    ];

    String? lastErrorMessage;
    int? lastErrorCode;

    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        session.log(
          'AI notifications: sending Gemini request (attempt $attempt).',
        );
        final uri = Uri.https(
          'generativelanguage.googleapis.com',
          '/v1beta/models/$_model:generateContent',
          {'key': apiKey},
        );

        final payload = jsonEncode({
          'contents': [
            {
              'role': 'user',
              'parts': [
                {'text': prompt},
              ],
            },
          ],
          'generationConfig': {
            'temperature': 0.4,
            'topP': 0.9,
            'maxOutputTokens': 8192,
            'responseMimeType': 'application/json',
            'candidateCount': 1,
          },
        });

        final response = await http
            .post(
              uri,
              headers: {'Content-Type': 'application/json'},
              body: payload,
            )
            .timeout(const Duration(seconds: 90));

        session.log('AI notifications: Gemini raw response=${response.body}');

        if (response.statusCode < 200 || response.statusCode >= 300) {
          session.log(
            'AI notifications: Gemini error status=${response.statusCode}, body=${response.body}',
          );
          lastErrorCode = response.statusCode;
          if (response.statusCode == 429) {
            lastErrorMessage = 'AI rate limit reached. Please try again later.';
          } else if (response.statusCode == 503) {
            lastErrorMessage = 'AI service is busy. Please try again later.';
          } else {
            lastErrorMessage = 'AI service error. Please try again later.';
          }

          if ((response.statusCode == 429 || response.statusCode == 503) &&
              attempt < maxAttempts) {
            await Future.delayed(delays[attempt - 1]);
            continue;
          }

          throw ServerpodException(
            message: lastErrorMessage,
            errorCode: lastErrorCode,
          );
        }

        final decoded = jsonDecode(response.body) as Map<String, dynamic>;
        final text = _extractText(decoded);
        if (text == null) {
          session.log(
            'AI notifications: Gemini response missing text. Raw=${response.body}',
          );
          lastErrorMessage = 'AI response invalid. Please try again later.';
          lastErrorCode = 503;
          if (attempt < maxAttempts) {
            await Future.delayed(delays[attempt - 1]);
            continue;
          }
          throw ServerpodException(
            message: lastErrorMessage,
            errorCode: lastErrorCode,
          );
        }

        final jsonText = _extractJson(text);
        if (jsonText == null) {
          session.log(
            'AI notifications: Gemini response missing JSON. Raw=$text',
          );
          lastErrorMessage = 'AI response invalid. Please try again later.';
          lastErrorCode = 503;
          if (attempt < maxAttempts) {
            await Future.delayed(delays[attempt - 1]);
            continue;
          }
          throw ServerpodException(
            message: lastErrorMessage,
            errorCode: lastErrorCode,
          );
        }

        final data = jsonDecode(jsonText) as Map<String, dynamic>;
        final items = data['items'] as List<dynamic>?;
        if (items == null || items.isEmpty) {
          session.log('AI notifications: Gemini JSON items empty.');
          lastErrorMessage = 'AI response invalid. Please try again later.';
          lastErrorCode = 503;
          if (attempt < maxAttempts) {
            await Future.delayed(delays[attempt - 1]);
            continue;
          }
          throw ServerpodException(
            message: lastErrorMessage,
            errorCode: lastErrorCode,
          );
        }

        session.log('AI notifications: Gemini returned ${items.length} items.');
        final result = <int, NotificationCopy>{};
        for (final item in items) {
          final map = item as Map<String, dynamic>;
          final id = map['id'] as int?;
          if (id == null) {
            session.log('AI notifications: skipping item with missing id.');
            continue;
          }

          final rawTitle = (map['title'] as String?)?.trim() ?? '';
          final rawBody = (map['body'] as String?)?.trim() ?? '';
          if (rawTitle.isEmpty || rawBody.isEmpty) {
            session.log(
              'AI notifications: skipping item $id with empty title/body.',
            );
            continue;
          }

          result[id] = NotificationCopy(
            title: _truncate(rawTitle, _maxTitleLength),
            body: _truncate(rawBody, _maxBodyLength),
          );
        }

        return result;
      } catch (error) {
        if (error is ServerpodException) {
          rethrow;
        }
        session.log('AI notifications: Gemini request failed: $error');
        lastErrorMessage ??= 'AI request failed. Please try again later.';
        lastErrorCode ??= 503;
        if (attempt < maxAttempts) {
          await Future.delayed(delays[attempt - 1]);
          continue;
        }
        throw ServerpodException(
          message: lastErrorMessage,
          errorCode: lastErrorCode,
        );
      }
    }

    throw ServerpodException(
      message: lastErrorMessage ?? 'AI request failed. Please try again later.',
      errorCode: lastErrorCode ?? 503,
    );
  }

  String? _extractText(Map<String, dynamic> response) {
    final candidates = response['candidates'] as List<dynamic>?;
    if (candidates == null || candidates.isEmpty) {
      return null;
    }

    final content = candidates.first['content'] as Map<String, dynamic>?;
    final parts = content?['parts'] as List<dynamic>?;
    if (parts == null || parts.isEmpty) {
      return null;
    }

    final text = parts.first['text'] as String?;
    return text?.trim();
  }

  String? _extractJson(String text) {
    final trimmed = text.trim();
    if (trimmed.startsWith('{') && trimmed.endsWith('}')) {
      return trimmed;
    }

    final fenced = RegExp(r'```(?:json)?\s*([\s\S]*?)\s*```');
    final match = fenced.firstMatch(trimmed);
    if (match != null) {
      return match.group(1)?.trim();
    }

    final start = trimmed.indexOf('{');
    final end = trimmed.lastIndexOf('}');
    if (start == -1 || end == -1 || end <= start) {
      return null;
    }

    return trimmed.substring(start, end + 1);
  }

  String _truncate(String value, int maxLength) {
    if (value.length <= maxLength) {
      return value;
    }
    return value.substring(0, maxLength);
  }
}

List<_NotificationUpdateContext> _buildNotificationUpdateContext(
  List<DaySchedule> days,
) {
  final result = <_NotificationUpdateContext>[];
  for (final day in days) {
    for (final notification in day.notifications ?? <Notification>[]) {
      final notificationId = notification.id;
      if (notificationId == null) {
        continue;
      }

      result.add(
        _NotificationUpdateContext(
          notification: notification,
          prompt: _PromptNotificationContext(
            id: notificationId,
            dayLabel: day.day.name,
            scheduledDate: notification.scheduledDate.toIso8601String(),
          ),
        ),
      );
    }
  }

  return result;
}

List<_PromptNotificationContext> _buildPlannedPromptContext(
  List<DaySchedule> days,
) {
  final result = <_PromptNotificationContext>[];
  var index = 0;
  for (final day in days) {
    for (final notification in day.notifications ?? <Notification>[]) {
      result.add(
        _PromptNotificationContext(
          id: index,
          dayLabel: day.day.name,
          scheduledDate: notification.scheduledDate.toIso8601String(),
        ),
      );
      index++;
    }
  }

  return result;
}

class NotificationCopy {
  final String title;
  final String body;

  const NotificationCopy({
    required this.title,
    required this.body,
  });
}

class _PromptNotificationContext {
  final int id;
  final String dayLabel;
  final String scheduledDate;

  const _PromptNotificationContext({
    required this.id,
    required this.dayLabel,
    required this.scheduledDate,
  });
}

class _NotificationUpdateContext {
  final Notification notification;
  final _PromptNotificationContext prompt;

  const _NotificationUpdateContext({
    required this.notification,
    required this.prompt,
  });
}
