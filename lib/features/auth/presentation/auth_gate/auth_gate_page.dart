import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_providers.dart';
import '../sign_in/sign_in_page.dart';
import '../home/home_page.dart';

/// ログイン状態に応じて表示画面を切り替えるゲート
///
/// authStateChangesProvider（StreamProvider）を watch することで
/// Firebase の認証状態変化を即座に検知して画面を切り替える。
///
/// サインイン成功後の流れ：
///   SignInNotifier → AuthService.signIn()
///     → Firebase が authStateChanges() に User を流す
///     → authStateChangesProvider が更新される
///     → AuthGate が再ビルドされ HomePage に切り替わる
///   ※ SignInNotifier でナビゲートする必要がない
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authStateChangesProvider);

    return authAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('初期化エラー: $e')),
      ),
      data: (user) => user != null
          ? const HomePage() // ログイン済み
          : const SignInPage(), // 未ログイン
    );
  }
}
