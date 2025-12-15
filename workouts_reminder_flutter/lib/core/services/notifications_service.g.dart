// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationsSvc)
const notificationsSvcProvider = NotificationsSvcProvider._();

final class NotificationsSvcProvider
    extends
        $FunctionalProvider<
          NotificationsService,
          NotificationsService,
          NotificationsService
        >
    with $Provider<NotificationsService> {
  const NotificationsSvcProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsSvcProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsSvcHash();

  @$internal
  @override
  $ProviderElement<NotificationsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationsService create(Ref ref) {
    return notificationsSvc(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationsService>(value),
    );
  }
}

String _$notificationsSvcHash() => r'258c3adba0842642e78ba81fd4c7d2d937e2d2e6';
