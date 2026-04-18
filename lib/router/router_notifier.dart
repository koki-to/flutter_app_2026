import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/auth/providers/auth_providers.dart';

part 'router_notifier.g.dart';

// ─── ルートパスの定数定義 ────────────────────────────────────────
// 文字列の直打ちをなくしてタイポを防ぐ
abstract final class AppRoutes {
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const forgotPassword = '/forgot-password';
  static const home = '/home';
}

// ─── 認証が必要なルート一覧 ─────────────────────────────────────
const _protectedRoutes = [
  AppRoutes.home,
];

// ─── 認証済みユーザーがアクセスすべきでないルート一覧 ──────────────
const _authRoutes = [
  AppRoutes.signIn,
  AppRoutes.signUp,
  AppRoutes.forgotPassword,
];

// ─── RouterNotifier ───────────────────────────────────────────────
//
// go_router に Riverpod の状態変化を通知するための橋渡し役。
//
// Listenable を実装することで、go_router の refreshListenable に渡せる。
// → 認証状態が変わるたびに go_router が redirect() を再評価する。
//
// keepAlive: true にしてアプリ全体で1つだけ存在させる。

@Riverpod(keepAlive: true)
class RouterNotifier extends _$RouterNotifier implements Listenable {
  // go_router が登録するコールバック
  VoidCallback? _routerListener;

  @override
  Future<void> build() async {
    // 認証状態が変化するたびに build() が再実行される
    // そのたびに authStateChangesProvider を監視する
    ref.listen(authStateChangesProvider, (_, __) {
      _routerListener?.call();
    });
    // authStateChangesProvider を watch して認証状態を監視する
    // User? が変化するたびにこの build() が再実行される
    await ref.watch(
      authStateChangesProvider.future,
    );
  }

  // ─── redirect のルール定義 ────────────────────────────────────
  //
  // 戻り値：
  //   null   → リダイレクトしない（そのまま表示）
  //   String → そのパスにリダイレクトする
  //
  // 呼ばれるタイミング：
  //   ・アプリ起動時
  //   ・go_router で画面遷移するたびに
  //   ・refreshListenable（= RouterNotifier）が通知するたびに

  String? redirect(BuildContext context, GoRouterState state) {
    // ローディング中・エラー時はリダイレクトしない
    if (this.state.isLoading || this.state.hasError) return null;

    // 現在ログインしているか
    final isLoggedIn =
        ref.read(authStateChangesProvider.select((a) => a.value != null));

    final currentLocation = state.matchedLocation;
    final isOnAuthRoute = _authRoutes.any((r) => currentLocation.startsWith(r));
    final isOnProtectedRoute =
        _protectedRoutes.any((r) => currentLocation.startsWith(r));

    // ─── リダイレクトルール ─────────────────────────────────
    //
    // ① ログイン済みで認証画面にいる → ホームへ
    if (isLoggedIn && isOnAuthRoute) return AppRoutes.home;

    // ② 未ログインで保護画面にいる → サインイン画面へ
    if (!isLoggedIn && isOnProtectedRoute) return AppRoutes.signIn;

    // ③ それ以外 → リダイレクトなし
    return null;
  }

  // ─── Listenable の実装 ───────────────────────────────────────
  // go_router が登録・解除するコールバックを管理する

  @override
  void addListener(VoidCallback listener) {
    _routerListener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    _routerListener = null;
  }
}
