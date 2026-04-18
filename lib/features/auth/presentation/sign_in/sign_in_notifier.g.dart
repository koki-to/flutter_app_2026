// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SignInNotifier)
final signInProvider = SignInNotifierProvider._();

final class SignInNotifierProvider
    extends $NotifierProvider<SignInNotifier, SignInState> {
  SignInNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'signInProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$signInNotifierHash();

  @$internal
  @override
  SignInNotifier create() => SignInNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignInState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignInState>(value),
    );
  }
}

String _$signInNotifierHash() => r'e582f692a0a0d888369ebbeff72320b20151759a';

abstract class _$SignInNotifier extends $Notifier<SignInState> {
  SignInState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SignInState, SignInState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<SignInState, SignInState>, SignInState, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
