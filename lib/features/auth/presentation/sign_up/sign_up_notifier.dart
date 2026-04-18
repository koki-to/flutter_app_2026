import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../service/auth_service.dart';
import 'sign_up_state.dart';

part 'sign_up_notifier.g.dart';

@riverpod
class SignUpNotifier extends _$SignUpNotifier {
  AuthService get _service => ref.read(authServiceProvider);

  @override
  SignUpState build() => const SignUpState();

  void updateEmail(String v) =>
      state = state.copyWith(email: v, errorMessage: null);
  void updatePassword(String v) =>
      state = state.copyWith(password: v, errorMessage: null);
  void updateConfirmPassword(String v) =>
      state = state.copyWith(confirmPassword: v, errorMessage: null);
  void togglePasswordVisibility() =>
      state = state.copyWith(obscurePassword: !state.obscurePassword);
  void toggleConfirmPasswordVisibility() => state = state.copyWith(
        obscureConfirmPassword: !state.obscureConfirmPassword,
      );

  Future<void> signUp() async {
    if (!state.canSubmit) return;
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _service.signUp(
        email: state.email.trim(),
        password: state.password,
      );
      // 成功 → authStateChanges() が更新 → AuthGate が HomePage に切り替える
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _toMessage(e.code),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '登録に失敗しました: $e',
      );
    }
  }

  String _toMessage(String code) => switch (code) {
        'email-already-in-use' => 'このメールアドレスはすでに登録されています',
        'invalid-email' => 'メールアドレスの形式が正しくありません',
        'weak-password' => 'パスワードは6文字以上にしてください',
        'operation-not-allowed' => 'メール認証が無効化されています',
        _ => '登録に失敗しました（$code）',
      };
}
