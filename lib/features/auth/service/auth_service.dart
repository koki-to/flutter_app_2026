import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../providers/auth_providers.dart';
import '../repository/auth_repository.dart';

part 'auth_service.g.dart';

// ─── AuthService を @riverpod Provider として定義 ──────────────
//
// keepAlive: true を付けない理由：
//  ・state を持たない（メモリを保持し続ける必要がない）
//  ・接続を保持しない（DB・HTTP クライアントではない）
//  ・ただのメソッド集 → auto-dispose で十分
//
// Notifier からは ref.read(authServiceProvider) で使う。

@riverpod
AuthService authService(Ref ref) {
  return AuthService(
    authRepository: ref.watch(authRepositoryProvider),
  );
}

/// 認証に関するビジネスロジックをまとめたサービスクラス
///
/// 現在は AuthRepository 1つのみだが、
/// 将来 Analytics 送信・ログ記録・複数 Repository をまたぐ処理が
/// 増えたときにここに集約する。
class AuthService {
  final AuthRepository _authRepository;

  AuthService({required AuthRepository authRepository})
      : _authRepository = authRepository;

  // ─── サインイン ─────────────────────────────────────────
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // ─── 新規登録 ────────────────────────────────────────────
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    await _authRepository.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // ─── パスワードリセット ──────────────────────────────────
  Future<void> sendPasswordResetEmail({required String email}) async {
    await _authRepository.sendPasswordResetEmail(email: email);
  }

  // ─── サインアウト ────────────────────────────────────────
  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  // ─── 退会（アカウント削除）──────────────────────────────
  Future<void> deleteAccount() async {
    await _authRepository.deleteAccount();
  }
}
