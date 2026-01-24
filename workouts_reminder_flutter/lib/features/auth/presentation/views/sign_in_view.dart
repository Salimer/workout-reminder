import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:workouts_reminder_client/workouts_reminder_client.dart';

import '../../../../core/providers/client.dart';

class SignInView extends ConsumerStatefulWidget {
  final bool startInRegistration;

  const SignInView({
    super.key,
    required this.startInRegistration,
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
      startScreen: widget.startInRegistration
          ? EmailFlowScreen.startRegistration
          : EmailFlowScreen.login,
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
    final primaryAccent = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryAccent.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icon Container matching Onboarding style
                          Container(
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryAccent.withOpacity(0.2),
                            ),
                            child: Icon(
                              Icons.fitness_center_rounded,
                              size: 60,
                              color: primaryAccent,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            widget.startInRegistration
                                ? 'Create Account'
                                : 'Welcome back',
                            style: GoogleFonts.outfit(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.startInRegistration
                                ? 'Sign up to start your journey'
                                : 'Sign in to continue your plan',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.color?.withValues(
                                    alpha: 0.7,
                                  ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 40),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: SignInWidget(
                              client: client,
                              onError: _showAuthError,
                              emailSignInWidget: EmailSignInWidget(
                                controller: _emailAuthController,
                              ),
                              onAuthenticated: () {
                                debugPrint("user authenticated");
                              },
                            ),
                          ),
                        ],
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
