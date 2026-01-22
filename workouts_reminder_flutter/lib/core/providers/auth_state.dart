import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:workouts_reminder_client/workouts_reminder_client.dart';

import 'client.dart';

part 'auth_state.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  Client get client => ref.read(clientProvider);

  @override
  bool build() {
    client.auth.authInfoListenable.addListener(_onAuthChanged);

    ref.onDispose(() {
      client.auth.authInfoListenable.removeListener(_onAuthChanged);
    });

    debugPrint(
      'AuthState initialized. isAuthenticated: ${client.auth.isAuthenticated}',
    );

    return client.auth.isAuthenticated;
  }

  void _onAuthChanged() {
    state = client.auth.isAuthenticated;
  }
}
