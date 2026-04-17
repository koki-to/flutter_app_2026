import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default(false) bool isLoading,
    @Default(false) bool obscurePassword,
    @Default(false) bool obscureConfirmPassword,
    @Default(null) String? errorMessage,
  }) = _SignUpState;

  const SignUpState._();

  bool get passwordsMatch => password == confirmPassword;

  bool get canSubmit =>
      email.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      passwordsMatch &&
      password.length >= 6 &&
      !isLoading;

  bool get showPasswordMismatch =>
      confirmPassword.isNotEmpty && !passwordsMatch;
}
