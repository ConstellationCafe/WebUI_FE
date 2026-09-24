import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/point_strings.dart';
import '../constants/point_tokens.dart';
import '../notifier/admin_point_notifier.dart';
import '../widgets/member_list_panel.dart';
import '../widgets/member_point_detail.dart';
import '../widgets/point_transaction_dialog.dart';

class AdminPointPage extends ConsumerWidget {
  const AdminPointPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adminPointProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            PointStrings.title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final list = MemberListPanel(
                  members: state.members,
                  selectedDiscordId: state.selectedDiscordId,
                  onSearchChanged: ref
                      .read(adminPointProvider.notifier)
                      .updateSearchInput,
                  isLoading: state.isLoadingMembers,
                  isSubmitting: state.isSubmitting,
                  hasError: state.hasMembersError,
                  onRetry: () => ref
                      .read(adminPointProvider.notifier)
                      .loadMembers(page: state.memberPage),
                  page: state.memberPage,
                  totalPages: state.memberTotalPages,
                  onSearch: () =>
                      ref.read(adminPointProvider.notifier).searchMembers(),
                  onSelected: (member) => ref
                      .read(adminPointProvider.notifier)
                      .selectMember(member.discordId),
                  onPageChanged: (page) => ref
                      .read(adminPointProvider.notifier)
                      .loadMembers(page: page),
                );
                final detail = MemberPointDetail(
                  detail: state.selected,
                  isLoading: state.isLoadingDetail,
                  isSubmitting: state.isSubmitting,
                  hasError: state.hasDetailError,
                  onRetry: () {
                    final discordId = state.selectedDiscordId;
                    if (discordId != null) {
                      ref
                          .read(adminPointProvider.notifier)
                          .selectMember(discordId);
                    }
                  },
                  onDeposit: () => _showTransactionDialog(context, ref, true),
                  onWithdraw: () => _showTransactionDialog(context, ref, false),
                  onPageChanged: (page) {
                    final discordId = state.selected?.member.discordId;
                    if (discordId != null) {
                      ref
                          .read(adminPointProvider.notifier)
                          .selectMember(discordId, page: page);
                    }
                  },
                );

                if (constraints.maxWidth < PointTokens.compactBreakpoint) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height:
                              320 + MediaQuery.textScalerOf(context).scale(60),
                          child: list,
                        ),
                        const SizedBox(height: PointTokens.panelGap),
                        SizedBox(height: 600, child: detail),
                      ],
                    ),
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(width: PointTokens.listWidth, child: list),
                    const SizedBox(width: PointTokens.panelGap),
                    Expanded(child: detail),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showTransactionDialog(
    BuildContext context,
    WidgetRef ref,
    bool isDeposit,
  ) async {
    final selected = ref.read(adminPointProvider).selected;
    if (selected == null) return;
    final success = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PointTransactionDialog(
        isDeposit: isDeposit,
        member: selected.member,
        onSubmit: (amount, description) => ref
            .read(adminPointProvider.notifier)
            .transact(
              discordId: selected.member.discordId,
              isDeposit: isDeposit,
              amount: amount,
              description: description,
            ),
      ),
    );
    if (!context.mounted) return;
    if (success == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(PointStrings.transactionComplete)),
      );
    } else {
      await ref
          .read(adminPointProvider.notifier)
          .selectMember(selected.member.discordId);
    }
  }
}
