import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import 'core/observers/provider_logger_observer.dart';
import 'core/providers/client.dart';
import 'core/providers/theme.dart';
import 'core/services/notifications_service.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer(
    observers: [
      // ProviderLoggerObserver(),
    ],
  );
  await container.read(clientProvider).auth.initialize();
  await container.read(notificationsSvcProvider).initialize();
  await container.read(themeProvider.future);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}
