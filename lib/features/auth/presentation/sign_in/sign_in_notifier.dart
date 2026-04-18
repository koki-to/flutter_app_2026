import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../../core/logger/talker_provider.dart';
import '../../service/auth_service.dart';
import 'sign_in_state.dart';

part 'sign_in_notifier.g.dart';

@riverpod
class SignInNotifier extends _$SignInNotifier {
  // Notifier は Service だけを知る（Repository を直接知らない）
  AuthService get _service => ref.read(authServiceProvider);
  // Talker を Notifier 内で使う
  Talker get _talker => ref.read(talkerProvider);

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
      _talker.info('サインイン成功: ${state.email.trim()}');
    } on FirebaseAuthException catch (e, stack) {
      // handle() でエラーとスタックトレースを一緒に記録できる
      _talker.handle(e, stack, 'SignIn FirebaseAuthException: ${e.code}');
      state = state.copyWith(
        isLoading: false,
        errorMessage: _toMessage(e.code),
      );
    } catch (e, stack) {
      _talker.critical('SignIn 予期しないエラー', e, stack);
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
