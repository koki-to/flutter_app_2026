import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../service/auth_service.dart';
import 'sign_in_state.dart';

part 'sign_in_notifier.g.dart';

@riverpod
class SignInNotifier extends _$SignInNotifier {
  // Notifier は Service だけを知る（Repository を直接知らない）
  AuthService get _service => ref.read(authServiceProvider);

  @override
  SignInState build() => const SignInState();

  void updateEmail(String v) =>
      state = state.copyWith(email: v, errorMessage: null);

  void updatePassword(String v) =>
      state = state.copyWith(password: v, errorMessage: null);

  void togglePasswordVisibility() =>
      state = state.copyWith(obscurePassword: !state.obscurePassword);

  Future<void> signIn() async {
    if (!state.canSubmit) return;

    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // Service のメソッドを直接呼ぶ
      await _service.signIn(
        email: state.email.trim(),
        password: state.password,
      );
      // 成功 → authStateChanges() が通知 → AuthGate が切り替え
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _toMessage(e.code),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '予期しないエラーが発生しました',
      );
    }
  }

  // エラーコード → 日本語変換（Notifier の責務）
  String _toMessage(String code) => switch (code) {
        'user-not-found' => 'このメールアドレスは登録されていません',
        'wrong-password' => 'パスワードが正しくありません',
        'invalid-email' => 'メールアドレスの形式が正しくありません',
        'user-disabled' => 'このアカウントは無効化されています',
        'too-many-requests' => 'ログイン試行回数が上限に達しました',
        'invalid-credential' => 'メールアドレスまたはパスワードが正しくありません',
        _ => 'ログインに失敗しました（$code）',
      };
}
