import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../service/auth_service.dart';
import 'home_state.dart';

part 'home_notifier.g.dart';

// ─── HomeNotifier ─────────────────────────────────────────────
//
// サインアウト・退会は AuthService を直接呼ぶ。
// AuthNotifier を経由しない理由：
//   ・Notifier が別の Notifier を呼ぶのは避けるべき
//   ・AuthService を呼べば authStateChanges() が自動で null を流す
//   → AuthGate が自動で SignInPage に切り替えるため
//      ここでナビゲートする必要がない

@riverpod
class HomeNotifier extends _$HomeNotifier {
  AuthService get _service => ref.read(authServiceProvider);

  @override
  HomeState build() => const HomeState();

  // ─── サインアウト ──────────────────────────────────────────
  Future<void> signOut() async {
    if (state.isBusy) return;
    state = state.copyWith(isSigningOut: true, errorMessage: null);
    try {
      await _service.signOut();
      // 成功 → authStateChanges() が null を流す
      //      → AuthGate が SignInPage に切り替える
    } catch (e) {
      state = state.copyWith(
        isSigningOut: false,
        errorMessage: 'ログアウトに失敗しました',
      );
    }
  }

  // ─── 退会（アカウント削除）────────────────────────────────
  Future<void> deleteAccount() async {
    if (state.isBusy) return;
    state = state.copyWith(isDeletingAccount: true, errorMessage: null);
    try {
      await _service.deleteAccount();
      // 成功 → authStateChanges() が null を流す
      //      → AuthGate が SignInPage に切り替える
    } on FirebaseAuthException catch (e) {
      final message = e.code == 'requires-recent-login'
          ? '退会にはログインし直す必要があります。\n一度ログアウトして再度ログインしてください'
          : '退会処理に失敗しました（${e.code}）';
      state = state.copyWith(isDeletingAccount: false, errorMessage: message);
    } catch (e) {
      state = state.copyWith(
        isDeletingAccount: false,
        errorMessage: '退会処理に失敗しました',
      );
    }
  }

  void clearError() => state = state.copyWith(errorMessage: null);
}
