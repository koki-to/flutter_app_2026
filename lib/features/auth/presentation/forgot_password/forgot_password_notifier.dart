import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../service/auth_service.dart';
import 'forgot_password_state.dart';

part 'forgot_password_notifier.g.dart';

@riverpod
class ForgotPasswordNotifier extends _$ForgotPasswordNotifier {
  AuthService get _service => ref.read(authServiceProvider);

  @override
  ForgotPasswordState build() => const ForgotPasswordState();

  void updateEmail(String v) =>
      state = state.copyWith(email: v, errorMessage: null);

  Future<void> sendResetEmail() async {
    if (!state.canSubmit) return;
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _service.sendPasswordResetEmail(email: state.email.trim());
      state = state.copyWith(isLoading: false, isEmailSent: true);
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

  String _toMessage(String code) => switch (code) {
        'user-not-found' => 'このメールアドレスは登録されていません',
        'invalid-email' => 'メールアドレスの形式が正しくありません',
        _ => 'メールの送信に失敗しました（$code）',
      };
}
