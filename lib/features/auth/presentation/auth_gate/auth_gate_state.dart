import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_2026/features/auth/model/user_profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_gate_state.freezed.dart';

@freezed
sealed class AuthGateState with _$AuthGateState {
  // 起動直後、Firebase の認証確認が完了する前
  const factory AuthGateState.unknown() = AuthGateStateUnKnown;

  // ログイン済み（Firebase User + アプリのプロフィール）
  const factory AuthGateState.authenticated({
    required User firebaseUser,
    UserProfile? profile,
  }) = AuthGateStateAuthenticated;

  // 未ログイン
  const factory AuthGateState.unauthenticated() = AuthGateStateUnAuthenticated;
}
