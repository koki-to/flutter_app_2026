// lib/core/logger/talker_provider.dart

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'talker_provider.g.dart';

// ─── Talker をアプリ全体で使い回す ──────────────────────────
// keepAlive: true でアプリ全体に1つだけ存在させる

@Riverpod(keepAlive: true)
Talker talker(Ref ref) {
  return Talker(
    settings: TalkerSettings(
      // デバッグビルドのみ有効（本番では出力しない）
      enabled: kDebugMode,
      // ログレベルの設定
      // verbose / debug は本番では出さない
      useConsoleLogs: kDebugMode,
    ),
    logger: TalkerLogger(
      settings: TalkerLoggerSettings(
        // ログに色をつける
        enableColors: true,
        // ログの最大長（長すぎるログを切り詰める）
        maxLineWidth: 200,
      ),
    ),
  );
}
