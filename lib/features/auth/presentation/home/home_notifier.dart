import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../service/auth_service.dart';
import 'home_state.dart';

part 'home_notifier.g.dart';

@riverpod
class HomeNotifier extends _$HomeNotifier {
  AuthService get _service => ref.read(authServiceProvider);

  @override
  HomeState build() => const HomeState();

  Future<void> signOut() async {
    if (state.isBusy) return;
    state = state.copyWith(isSigningOut: true, errorMessage: null);
    try {
      await _service.signOut();
      // 成功 → authStateChanges() が null を流す
      // → RouterNotifier が検知 → redirect() が /sign-in にリダイレクト
    } catch (e) {
      state = state.copyWith(isSigningOut: false, errorMessage: 'ログアウトに失敗しました');
    }
  }

  Future<void> deleteAccount() async {
    if (state.isBusy) return;
    state = state.copyWith(isDeletingAccount: true, errorMessage: null);
    try {
      await _service.deleteAccount();
      // 成功 → authStateChanges() が null を流す
      // → RouterNotifier が検知 → redirect() が /sign-in にリダイレクト
    } on FirebaseAuthException catch (e) {
      final message = e.code == 'requires-recent-login'
          ? '退会にはログインし直す必要があります。\n一度ログアウトして再度ログインしてください'
          : '退会処理に失敗しました（${e.code}）';
      state = state.copyWith(isDeletingAccount: false, errorMessage: message);
    } catch (e) {
      state =
          state.copyWith(isDeletingAccount: false, errorMessage: '退会処理に失敗しました');
    }
  }

  void clearError() => state = state.copyWith(errorMessage: null);
}
