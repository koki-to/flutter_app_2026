import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repository/auth_repository.dart';
import '../repository/auth_repository_impl.dart';

part 'auth_providers.g.dart';

// ─── Firebase Auth インスタンス ──────────────────────────────
@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) => FirebaseAuth.instance;

// ─── AuthRepository ─────────────────────────────────────────
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.watch(firebaseAuthProvider));
}

// ─── 認証状態 Stream ─────────────────────────────────────────
//
// Firebase が自動で状態変化を通知してくれる Stream。
// keepAlive: true で常時監視する。
// AuthGate がここを watch して画面を自動切り替えする。
@Riverpod(keepAlive: true)
Stream<User?> authStateChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}

// ─── 現在のユーザー UID ──────────────────────────────────────
//
// uid だけを select で抽出。
// uid 以外の変化では再ビルドしない。
// 各 Notifier が UID を必要とするときに使う。
@Riverpod(keepAlive: true)
String? currentUid(Ref ref) {
  final user = ref.watch(authStateChangesProvider);
  return user.value?.uid;
}
