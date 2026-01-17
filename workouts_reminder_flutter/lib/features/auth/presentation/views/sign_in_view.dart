import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:workouts_reminder_client/workouts_reminder_client.dart';

import '../../../../core/providers/client.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({
    super.key,
  });

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  late final EmailAuthController _emailAuthController;
  late final Client client;

  @override
  void initState() {
    super.initState();
    client = ref.read(clientProvider);
    _emailAuthController = EmailAuthController(
      client: client,
      onAuthenticated: () {},
      onError: _handleEmailAuthError,
    );
  }

  @override
  void dispose() {
    _emailAuthController.dispose();
    super.dispose();
  }

  void _showAuthError(Object error) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sign-in error: $error'),
      ),
    );
  }

  void _handleEmailAuthError(Object error) {
    _showAuthError(error);
    if (_emailAuthController.currentScreen == EmailFlowScreen.login) {
      _emailAuthController.navigateTo(EmailFlowScreen.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: SignInWidget(
        client: client,
        onError: _showAuthError,
        emailSignInWidget: EmailSignInWidget(
          controller: _emailAuthController,
        ),
        
      ),
    );
  }
}
