// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_gate_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthGateNotifier)
final authGateProvider = AuthGateNotifierProvider._();

final class AuthGateNotifierProvider
    extends $NotifierProvider<AuthGateNotifier, User?> {
  AuthGateNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authGateProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authGateNotifierHash();

  @$internal
  @override
  AuthGateNotifier create() => AuthGateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(User? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<User?>(value),
    );
  }
}

String _$authGateNotifierHash() => r'7c236b27b6275e6301c5c6998bd1634361b20ed9';

abstract class _$AuthGateNotifier extends $Notifier<User?> {
  User? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<User?, User?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<User?, User?>, User?, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
