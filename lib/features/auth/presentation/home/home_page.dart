import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_providers.dart';
import 'home_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);

    // authStateChangesProvider から直接 User を取得
    // AuthNotifier を watch しない
    final user = ref.watch(
      authStateChangesProvider.select((a) => a.value),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: homeState.isSigningOut
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.logout),
            tooltip: 'ログアウト',
            onPressed: homeState.isBusy ? null : notifier.signOut,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFFE8EAF6),
                child: Icon(Icons.person, size: 48, color: Colors.indigo),
              ),
              const SizedBox(height: 16),
              Text(
                user?.email ?? '',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Chip(
                avatar: Icon(
                  user?.emailVerified ?? false
                      ? Icons.verified_outlined
                      : Icons.warning_amber_outlined,
                  size: 16,
                  color: user?.emailVerified ?? false
                      ? Colors.green
                      : Colors.orange,
                ),
                label: Text(
                  user?.emailVerified ?? false ? 'メール確認済み' : 'メール未確認',
                ),
              ),
              const SizedBox(height: 24),
              if (homeState.errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline,
                          color: Colors.red.shade700, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          homeState.errorMessage!,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 16),
                        onPressed: notifier.clearError,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
              const Divider(),
              ListTile(
                leading: homeState.isDeletingAccount
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(Icons.delete_forever, color: Colors.red.shade400),
                title: Text(
                  '退会する',
                  style: TextStyle(color: Colors.red.shade400),
                ),
                subtitle: const Text('アカウントを完全に削除します'),
                onTap: homeState.isBusy
                    ? null
                    : () => _showDeleteConfirmDialog(context, notifier),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmDialog(
    BuildContext context,
    HomeNotifier notifier,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('退会確認'),
        content: const Text('アカウントを削除しますか？\nこの操作は取り消せません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('退会する'),
          ),
        ],
      ),
    );
    if (confirmed == true) notifier.deleteAccount();
  }
}
