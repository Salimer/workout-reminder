/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class ServerpodException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  ServerpodException._({
    required this.message,
    int? errorCode,
  }) : errorCode = errorCode ?? 1001;

  factory ServerpodException({
    required String message,
    int? errorCode,
  }) = _ServerpodExceptionImpl;

  factory ServerpodException.fromJson(Map<String, dynamic> jsonSerialization) {
    return ServerpodException(
      message: jsonSerialization['message'] as String,
      errorCode: jsonSerialization['errorCode'] as int?,
    );
  }

  String message;

  int errorCode;

  /// Returns a shallow copy of this [ServerpodException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ServerpodException copyWith({
    String? message,
    int? errorCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ServerpodException',
      'message': message,
      'errorCode': errorCode,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ServerpodException',
      'message': message,
      'errorCode': errorCode,
    };
  }

  @override
  String toString() {
    return 'ServerpodException(message: $message, errorCode: $errorCode)';
  }
}

class _ServerpodExceptionImpl extends ServerpodException {
  _ServerpodExceptionImpl({
    required String message,
    int? errorCode,
  }) : super._(
         message: message,
         errorCode: errorCode,
       );

  /// Returns a shallow copy of this [ServerpodException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ServerpodException copyWith({
    String? message,
    int? errorCode,
  }) {
    return ServerpodException(
      message: message ?? this.message,
      errorCode: errorCode ?? this.errorCode,
    );
  }
}
