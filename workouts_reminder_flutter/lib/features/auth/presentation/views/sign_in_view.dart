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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primaryContainer.withValues(alpha: 0.18),
              colorScheme.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 48,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: colorScheme.outlineVariant.withValues(
                              alpha: 0.35,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 22,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.fitness_center_outlined,
                              color: colorScheme.primary,
                              size: 36,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Welcome back',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Sign in to continue your plan',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.65,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SignInWidget(
                              client: client,
                              onError: _showAuthError,
                              emailSignInWidget: EmailSignInWidget(
                                controller: _emailAuthController,
                              ),
                              onAuthenticated: () {
                                debugPrint("user authenticated");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
