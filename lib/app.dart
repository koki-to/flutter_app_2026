import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ★ appRouterProvider を watch する
    // → RouterNotifier が更新されても GoRouter インスタンスは
    //   再生成されない（keepAlive: true のため）
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Flutter Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
