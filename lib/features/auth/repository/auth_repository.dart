import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRepository {
  // ─── Stream：ログイン状態の監視 ──────────────────────────
  Stream<User?> authStateChanges();

  // ─── 現在のユーザー ─────────────────────────────────────
  User? get currentUser;

  // ─── 操作系メソッド ──────────────────────────────────────
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> sendPasswordResetEmail({required String email});

  Future<void> signOut();

  Future<void> deleteAccount();
}
