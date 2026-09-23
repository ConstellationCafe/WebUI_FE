import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/point_strings.dart';
import '../constants/point_tokens.dart';
import '../notifier/admin_point_notifier.dart';
import '../widgets/member_list_panel.dart';
import '../widgets/member_point_detail.dart';
import '../widgets/point_transaction_dialog.dart';

class AdminPointPage extends ConsumerStatefulWidget {
  const AdminPointPage({super.key});

  @override
  ConsumerState<AdminPointPage> createState() => _AdminPointPageState();
}

class _AdminPointPageState extends ConsumerState<AdminPointPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminPointProvider);
    ref.listen(adminPointProvider, (previous, next) {
      if (next.error != null && previous?.error != next.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(PointStrings.title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final list = MemberListPanel(
                  members: state.members,
                  selectedDiscordId: state.selected?.member.discordId,
                  searchController: _searchController,
                  isLoading: state.isLoadingMembers,
                  page: state.memberPage,
                  totalPages: state.memberTotalPages,
                  onSearch: () => ref
                      .read(adminPointProvider.notifier)
                      .loadMembers(search: _searchController.text.trim()),
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
                  onDeposit: () => _showTransactionDialog(true),
                  onWithdraw: () => _showTransactionDialog(false),
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
                  return Column(
                    children: [
                      SizedBox(height: 320, child: list),
                      const SizedBox(height: PointTokens.panelGap),
                      Expanded(child: detail),
                    ],
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

  Future<void> _showTransactionDialog(bool isDeposit) async {
    await showDialog<void>(
      context: context,
      builder: (context) => PointTransactionDialog(
        isDeposit: isDeposit,
        onSubmit: (amount, description) => ref
            .read(adminPointProvider.notifier)
            .transact(
              isDeposit: isDeposit,
              amount: amount,
              description: description,
            ),
      ),
    );
  }
}
