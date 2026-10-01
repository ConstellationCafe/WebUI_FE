import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/penalty_strings.dart';
import '../constants/penalty_tokens.dart';
import '../notifier/my_penalty_provider.dart';
import '../widgets/penalty_context_menu_scope.dart';
import '../widgets/penalty_detail_panel.dart';
import '../widgets/penalty_load_error.dart';

class MyPenaltyPage extends ConsumerStatefulWidget {
  const MyPenaltyPage({super.key});

  @override
  ConsumerState<MyPenaltyPage> createState() => _MyPenaltyPageState();
}

class _MyPenaltyPageState extends ConsumerState<MyPenaltyPage> {
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(myPenaltyProvider(_page));
    return PenaltyContextMenuScope(
      child: Padding(
        padding: const EdgeInsets.all(PenaltyTokens.gap),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              PenaltyStrings.myPenalties,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: PenaltyTokens.gap),
            Expanded(
              child: detail.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, _) => PenaltyLoadError(
                  onRetry: () => ref.invalidate(myPenaltyProvider(_page)),
                ),
                data: (value) => PenaltyDetailPanel(
                  detail: value,
                  onPageChanged: (page) => setState(() => _page = page),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
