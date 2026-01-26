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
    'Welcome to Nudge Fit - Verify Your Email',
    'Your verification code is: $verificationCode',
    _buildRegistrationEmailHtml(verificationCode),
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
    'Reset Your Nudge Fit Password',
    'Your password reset code is: $verificationCode',
    _buildPasswordResetEmailHtml(verificationCode),
  );
}

Future<void> _sendEmail(
  Session session,
  String recipient,
  String subject,
  String text,
  String html,
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
    ..text = text
    ..html = html;

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

String _buildRegistrationEmailHtml(String verificationCode) {
  return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Welcome to Nudge Fit</title>
</head>
<body style="margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif; background-color: #f7f9f7;">
  <table role="presentation" style="width: 100%; border-collapse: collapse;">
    <tr>
      <td align="center" style="padding: 40px 0;">
        <table role="presentation" style="width: 100%; max-width: 600px; border-collapse: collapse; background-color: #ffffff; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
          <!-- Header -->
          <tr>
            <td style="background: linear-gradient(135deg, #0C1F17 0%, #1DBA74 100%); padding: 40px 30px; text-align: center;">
              <h1 style="margin: 0; color: #ffffff; font-size: 32px; font-weight: 700;">Nudge Fit</h1>
              <p style="margin: 12px 0 0 0; color: #6EE7B7; font-size: 16px;">Your Personal Fitness Butler</p>
            </td>
          </tr>
          
          <!-- Content -->
          <tr>
            <td style="padding: 40px 30px;">
              <h2 style="margin: 0 0 16px 0; color: #0C1F17; font-size: 24px; font-weight: 700;">Welcome Aboard! 🎉</h2>
              <p style="margin: 0 0 24px 0; color: #374151; font-size: 16px; line-height: 1.6;">
                We're excited to have you join Nudge Fit! To get started with your personalized fitness journey, please verify your email address using the code below.
              </p>
              
              <!-- Verification Code Box -->
              <table role="presentation" style="width: 100%; border-collapse: collapse; margin: 32px 0;">
                <tr>
                  <td align="center">
                    <div style="background: linear-gradient(135deg, #1DBA74 0%, #6EE7B7 100%); padding: 24px; border-radius: 12px; display: inline-block;">
                      <p style="margin: 0 0 8px 0; color: #ffffff; font-size: 14px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px;">Verification Code</p>
                      <p style="margin: 0; color: #ffffff; font-size: 36px; font-weight: 700; letter-spacing: 4px; font-family: 'Courier New', monospace;">$verificationCode</p>
                    </div>
                  </td>
                </tr>
              </table>
              
              <p style="margin: 0 0 16px 0; color: #374151; font-size: 16px; line-height: 1.6;">
                Enter this code in the app to verify your account and start building your fitness routine.
              </p>
              
              <p style="margin: 0; color: #6B7280; font-size: 14px; line-height: 1.6;">
                This code will expire in 15 minutes for your security.
              </p>
            </td>
          </tr>
          
          <!-- Footer -->
          <tr>
            <td style="background-color: #F7F9F7; padding: 24px 30px; border-top: 1px solid #E5E7EB;">
              <p style="margin: 0 0 8px 0; color: #6B7280; font-size: 14px; text-align: center;">
                If you didn't create this account, you can safely ignore this email.
              </p>
              <p style="margin: 0; color: #9CA3AF; font-size: 12px; text-align: center;">
                © 2026 Nudge Fit. Your personal fitness butler.
              </p>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>
''';
}

String _buildPasswordResetEmailHtml(String verificationCode) {
  return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reset Your Nudge Fit Password</title>
</head>
<body style="margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif; background-color: #f7f9f7;">
  <table role="presentation" style="width: 100%; border-collapse: collapse;">
    <tr>
      <td align="center" style="padding: 40px 0;">
        <table role="presentation" style="width: 100%; max-width: 600px; border-collapse: collapse; background-color: #ffffff; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
          <!-- Header -->
          <tr>
            <td style="background: linear-gradient(135deg, #0C1F17 0%, #1DBA74 100%); padding: 40px 30px; text-align: center;">
              <h1 style="margin: 0; color: #ffffff; font-size: 32px; font-weight: 700;">Nudge Fit</h1>
              <p style="margin: 12px 0 0 0; color: #6EE7B7; font-size: 16px;">Your Personal Fitness Butler</p>
            </td>
          </tr>
          
          <!-- Content -->
          <tr>
            <td style="padding: 40px 30px;">
              <h2 style="margin: 0 0 16px 0; color: #0C1F17; font-size: 24px; font-weight: 700;">Password Reset Request 🔐</h2>
              <p style="margin: 0 0 24px 0; color: #374151; font-size: 16px; line-height: 1.6;">
                We received a request to reset your Nudge Fit password. Use the code below to create a new password and get back to your fitness journey.
              </p>
              
              <!-- Reset Code Box -->
              <table role="presentation" style="width: 100%; border-collapse: collapse; margin: 32px 0;">
                <tr>
                  <td align="center">
                    <div style="background: linear-gradient(135deg, #1DBA74 0%, #6EE7B7 100%); padding: 24px; border-radius: 12px; display: inline-block;">
                      <p style="margin: 0 0 8px 0; color: #ffffff; font-size: 14px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px;">Reset Code</p>
                      <p style="margin: 0; color: #ffffff; font-size: 36px; font-weight: 700; letter-spacing: 4px; font-family: 'Courier New', monospace;">$verificationCode</p>
                    </div>
                  </td>
                </tr>
              </table>
              
              <p style="margin: 0 0 16px 0; color: #374151; font-size: 16px; line-height: 1.6;">
                Enter this code in the app to reset your password.
              </p>
              
              <p style="margin: 0; color: #6B7280; font-size: 14px; line-height: 1.6;">
                This code will expire in 15 minutes for your security.
              </p>
            </td>
          </tr>
          
          <!-- Security Notice -->
          <tr>
            <td style="padding: 0 30px 40px 30px;">
              <div style="background-color: #FEF3C7; border-left: 4px solid #F59E0B; padding: 16px; border-radius: 8px;">
                <p style="margin: 0; color: #92400E; font-size: 14px; line-height: 1.6;">
                  <strong>Security Notice:</strong> If you didn't request a password reset, please ignore this email or contact support if you have concerns about your account security.
                </p>
              </div>
            </td>
          </tr>
          
          <!-- Footer -->
          <tr>
            <td style="background-color: #F7F9F7; padding: 24px 30px; border-top: 1px solid #E5E7EB;">
              <p style="margin: 0 0 8px 0; color: #6B7280; font-size: 14px; text-align: center;">
                Need help? We're here to support your fitness journey.
              </p>
              <p style="margin: 0; color: #9CA3AF; font-size: 12px; text-align: center;">
                © 2026 Nudge Fit. Your personal fitness butler.
              </p>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>
''';
}
