import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:mailer/mailer.dart' as mail;
import 'package:mailer/smtp_server.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/app/features/profile/create_profile_service.dart';
import 'src/app/features/progress/create_progress_service.dart';
import 'src/web/routes/root.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(args, Protocol(), Endpoints());

  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      // Configure the email identity provider for email/password authentication.
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: _sendRegistrationCode,
        sendPasswordResetVerificationCode: _sendPasswordResetCode,
        onAfterAccountCreated:
            (
              Session session, {
              required String email,
              required UuidValue authUserId,
              required UuidValue emailAccountId,
              required Transaction? transaction,
            }) async {
              print(
                "EmailIdp: Account created for $email with authUserId $authUserId",
              );
              const service = CreateProfileService();
              await service.callForUserId(
                session,
                authUserId,
                transaction: transaction,
              );
              const progressService = CreateProgressService();
              await progressService.callForUserId(
                session,
                authUserId,
                transaction: transaction,
              );
            },
      ),
    ],
  );

  // Setup a default page at the web root.
  pod.webServer.addRoute(RootRoute(), '/');
  pod.webServer.addRoute(RootRoute(), '/index.html');

  // Serve all files in the web/static relative directory under /.
  final root = Directory(Uri(path: 'web/static').toFilePath());
  pod.webServer.addRoute(StaticRoute.directory(root));

  // Start the server.
  await pod.start();
}

void _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) async {
  session.log('[EmailIdp] Registration code ($email): $verificationCode');
  await _sendEmail(
    session,
    email,
    'Verify your email',
    'Your verification code is: $verificationCode',
  );
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) async {
  session.log('[EmailIdp] Password reset code ($email): $verificationCode');
  await _sendEmail(
    session,
    email,
    'Reset your password',
    'Your password reset code is: $verificationCode',
  );
}

Future<void> _sendEmail(
  Session session,
  String recipient,
  String subject,
  String text,
) async {
  final gmailEmail = session.passwords['gmailEmail'];
  final gmailPassword = session.passwords['gmailPassword'];

  if (gmailEmail == null || gmailPassword == null) {
    session.log(
      'Gmail credentials not found in passwords.yaml',
      level: LogLevel.error,
    );
    return;
  }

  final smtpServer = gmail(gmailEmail, gmailPassword);
  final message = mail.Message()
    ..from = mail.Address(gmailEmail, 'Nudge Fit')
    ..recipients.add(recipient)
    ..subject = subject
    ..text = text;

  try {
    final sendReport = await mail.send(message, smtpServer);
    session.log('Message sent: $sendReport');
  } on mail.MailerException catch (e) {
    session.log('Message not sent. \n${e.toString()}', level: LogLevel.error);
    for (var p in e.problems) {
      session.log('Problem: ${p.code}: ${p.msg}', level: LogLevel.error);
    }
  }
}
