import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:workouts_reminder_client/workouts_reminder_client.dart';

part 'client.g.dart';

@Riverpod(keepAlive: true)
Client client(Ref ref) {
  const serverUrlFromEnv = String.fromEnvironment('SERVER_URL');
  final serverUrl = serverUrlFromEnv.isEmpty
      ? 'http://$localhost:8080/'
      : serverUrlFromEnv;

  final sessionManager = FlutterAuthSessionManager();

  return Client(
    serverUrl,
    connectionTimeout: const Duration(seconds: 90),
    streamingConnectionTimeout: const Duration(seconds: 90),
  )
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = sessionManager;
  // ..authKeyProvider = sessionManager;
}
