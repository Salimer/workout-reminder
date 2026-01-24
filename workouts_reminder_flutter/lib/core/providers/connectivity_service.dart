import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_service.g.dart';

@Riverpod(keepAlive: true)
Stream<List<ConnectivityResult>> connectivityStatus(Ref ref) {
  return Connectivity().onConnectivityChanged;
}
