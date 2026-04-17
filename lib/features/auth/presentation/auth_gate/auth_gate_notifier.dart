import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../providers/auth_providers.dart';

part 'auth_gate_notifier.g.dart';

// ─── AuthNotifier：keepAlive: true ────────────────────────────
//
// 役割はシンプル：authStateChanges() を購読して state を更新するのみ。
// サインアウト・退会などの操作は各 Notifier が Service を直接呼ぶ。
// → AuthNotifier に操作系を集約しない（責務を明確に分離する）

@Riverpod(keepAlive: true)
class AuthGateNotifier extends _$AuthGateNotifier {
  @override
  User? build() {
    // authStateChanges() Stream を購読
    // User? が変化するたびに state が自動更新される
    final subscription = ref
        .watch(authRepositoryProvider)
        .authStateChanges()
        .listen((user) => state = user);

    ref.onDispose(subscription.cancel);

    // 初期値：Firebase 確認前は currentUser（null の場合あり）
    return ref.read(authRepositoryProvider).currentUser;
  }
}
