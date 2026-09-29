import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/penalty_strings.dart';
import '../constants/penalty_tokens.dart';
import '../notifier/admin_penalty_notifier.dart';
import '../state/admin_penalty_state.dart';
import 'penalty_id_input_formatters.dart';
import 'penalty_load_error.dart';
import 'penalty_pager.dart';
import 'penalty_ranking_tile.dart';

/// 30일 누적 순위 목록. 대상 Discord ID 검색과 페이지 이동을 포함한다.
class PenaltyRankingList extends ConsumerWidget {
  final AdminPenaltyState state;
  final TextEditingController searchController;

  const PenaltyRankingList({
    super.key,
    required this.state,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(adminPenaltyProvider.notifier);
    final members = state.members;
    void search() => notifier.loadMembers(discordId: searchController.text);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(PenaltyTokens.gap),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              keyboardType: TextInputType.number,
              inputFormatters: penaltyIdInputFormatters(),
              decoration: InputDecoration(
                labelText: PenaltyStrings.targetId,
                suffixIcon: IconButton(
                  tooltip: PenaltyStrings.search,
                  onPressed: search,
                  icon: const Icon(Icons.search),
                ),
              ),
              onSubmitted: (_) => search(),
            ),
            const SizedBox(height: PenaltyTokens.gap),
            Expanded(
              child: state.isMembersLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.hasMembersError
                  ? PenaltyLoadError(
                      onRetry: () =>
                          notifier.loadMembers(page: members?.page ?? 1),
                    )
                  : members == null || members.items.isEmpty
                  ? const Center(child: Text(PenaltyStrings.noRanking))
                  : ListView.builder(
                      itemCount: members.items.length,
                      itemBuilder: (context, index) {
                        final member = members.items[index];
                        return PenaltyRankingTile(
                          member: member,
                          selected: state.selectedId == member.discordId,
                          onTap: state.isSubmitting
                              ? null
                              : () => notifier.selectMember(member.discordId),
                        );
                      },
                    ),
            ),
            PenaltyPager(
              page: members?.page ?? 1,
              totalPages: members?.totalPages ?? 0,
              disabled: state.isMembersLoading || state.isSubmitting,
              onChanged: (page) => notifier.loadMembers(page: page),
            ),
          ],
        ),
      ),
    );
  }
}
