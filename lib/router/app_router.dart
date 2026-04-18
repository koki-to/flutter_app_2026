import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../core/logger/talker_provider.dart';
import '../features/auth/presentation/forgot_password/forgot_password_page.dart';
import '../features/auth/presentation/home/home_page.dart';
import '../features/auth/presentation/sign_in/sign_in_page.dart';
import '../features/auth/presentation/sign_up/sign_up_page.dart';
import 'router_notifier.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  // RouterNotifier のインスタンスを取得
  final notifier = ref.watch(routerProvider.notifier);

  final talker = ref.watch(talkerProvider);

  return GoRouter(
    observers: [
      TalkerRouteObserver(talker),
    ],
    // デバッグ時にルート遷移をコンソール出力する
    debugLogDiagnostics: kDebugMode,

    // 起動時の初期ルート
    // → redirect が走って認証状態に応じて書き換えられる
    initialLocation: AppRoutes.signIn,

    // ★ Riverpod の状態変化を go_router に伝える橋渡し
    // RouterNotifier が notifyListeners 相当を呼ぶたびに
    // redirect() が再評価される
    refreshListenable: notifier,

    // ★ 認証状態に応じてリダイレクトするルール
    redirect: notifier.redirect,

    routes: [
      // ─── 認証画面（ログイン不要）──────────────────────────
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),

      // ─── 保護画面（ログイン必須）────────────────────────
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
