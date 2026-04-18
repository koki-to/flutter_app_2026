import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_2026/app.dart';
import 'package:flutter_app_2026/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'core/logger/talker_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ─── Talker インスタンスを先に作る ──────────────────────
  // Provider に入れる前に main() で使うため直接インスタンス化
  final talker = Talker(
    settings: TalkerSettings(enabled: kDebugMode),
  );

  // ─── グローバルエラーハンドリング ────────────────────────

  // ① Flutter フレームワーク内のエラー
  FlutterError.onError = (details) {
    // Talker でログを記録
    talker.handle(details.exception, details.stack, 'Flutter Framework Error');
    // 本番では Crashlytics に送る
    // if (!kDebugMode) {
    //   FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    // }
  };

  // ② Flutter フレームワーク外（非同期）のエラー
  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack, 'PlatformDispatcher Error');
    // 本番では Crashlytics に送る
    // if (!kDebugMode) {
    //   FirebaseCrashlytics.instance.recordError(error, stackTrace);
    // }
    return true;
  };

  talker.info('アプリ起動');

  runApp(
    ProviderScope(
      overrides: [
        talkerProvider.overrideWithValue(talker),
      ],
      observers: [
        TalkerRiverpodObserver(
          talker: talker,
          settings: const TalkerRiverpodLoggerSettings(
            enabled: true,
            printProviderAdded: true,
            printProviderUpdated: true,
            printProviderDisposed: true,
            printProviderFailed: true,
            printStateFullData: false,
          ),
        ),
      ],
      child: App(),
    ),
  );
}
