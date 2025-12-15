// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationsController)
const notificationsControllerProvider = NotificationsControllerProvider._();

final class NotificationsControllerProvider
    extends
        $FunctionalProvider<
          NotificationsController,
          NotificationsController,
          NotificationsController
        >
    with $Provider<NotificationsController> {
  const NotificationsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsControllerHash();

  @$internal
  @override
  $ProviderElement<NotificationsController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationsController create(Ref ref) {
    return notificationsController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationsController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationsController>(value),
    );
  }
}

String _$notificationsControllerHash() =>
    r'72a07db556f203b122611b2b55ec99f38dc8a070';
