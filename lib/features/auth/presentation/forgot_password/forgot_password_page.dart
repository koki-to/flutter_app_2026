import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'forgot_password_notifier.dart';

class ForgotPasswordPage extends ConsumerWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(forgotPasswordProvider);
    final notifier = ref.read(forgotPasswordProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('パスワードをリセット')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: state.isEmailSent
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.mark_email_read_outlined,
                        size: 64, color: Colors.green),
                    const SizedBox(height: 16),
                    Text(
                      'パスワードリセットのメールを送信しました',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${state.email} に届いたメールのリンクから再設定してください',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('ログイン画面に戻る'),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      '登録済みのメールアドレスを入力してください。\nパスワードリセット用のリンクをお送りします。',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    if (state.errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Text(state.errorMessage!,
                            style: TextStyle(color: Colors.red.shade700)),
                      ),
                      const SizedBox(height: 16),
                    ],
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'メールアドレス',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      onChanged: notifier.updateEmail,
                      onSubmitted: (_) => notifier.sendResetEmail(),
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed:
                          state.canSubmit ? notifier.sendResetEmail : null,
                      style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16)),
                      child: state.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2))
                          : const Text('送信する', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
