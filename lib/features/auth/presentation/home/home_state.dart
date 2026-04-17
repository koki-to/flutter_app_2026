import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isSigningOut,
    @Default(false) bool isDeletingAccount,
    @Default(null) String? errorMessage,
  }) = _HomeState;

  const HomeState._();

  bool get isBusy => isSigningOut || isDeletingAccount;
}
