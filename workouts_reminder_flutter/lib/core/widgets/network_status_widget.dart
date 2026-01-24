import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/connectivity_service.dart';

class NetworkStatusWidget extends ConsumerStatefulWidget {
  final Widget child;

  const NetworkStatusWidget({super.key, required this.child});

  @override
  ConsumerState<NetworkStatusWidget> createState() =>
      _NetworkStatusWidgetState();
}

class _NetworkStatusWidgetState extends ConsumerState<NetworkStatusWidget> {
  bool _isOffline = false;

  @override
  Widget build(BuildContext context) {
    ref.listen(connectivityStatusProvider, (_, next) {
      next.whenData((results) {
        final isOffline = results.contains(ConnectivityResult.none);
        if (isOffline != _isOffline) {
          setState(() {
            _isOffline = isOffline;
          });

          if (isOffline) {
            _showOfflineBanner();
          } else {
            _hideOfflineBanner();
          }
        }
      });
    });

    return widget.child;
  }

  void _showOfflineBanner() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.wifi_off, color: Colors.white),
            SizedBox(width: 12),
            Text('No Internet Connection'),
          ],
        ),
        backgroundColor: Colors.red.shade800,
        duration: const Duration(days: 365), // Persistent until dismissed
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }

  void _hideOfflineBanner() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
