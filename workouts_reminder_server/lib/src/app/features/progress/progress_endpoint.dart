import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import 'get_progress_service.dart';

class ProgressEndpoint extends Endpoint {
  final GetProgressService _getProgressService = const GetProgressService();

  @override
  bool get requireLogin => true;

  Future<Progress?> getProgress(Session session) async {
    return _getProgressService.call(session);
  }

  
}
