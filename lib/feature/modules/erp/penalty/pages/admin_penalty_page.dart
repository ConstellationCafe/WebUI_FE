import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/shared/domain/user/user_role.dart';
import 'package:constellation_cafe/shared/widgets/breadcrumb/app_breadcrumb.dart';

import '../constants/penalty_strings.dart';
import '../constants/penalty_tokens.dart';
import '../domain/calculate_penalty_cumulative.dart';
import '../domain/model/penalty_log.dart';
import '../notifier/admin_penalty_notifier.dart';
import '../state/admin_penalty_state.dart';
import '../widgets/penalty_award_dialog.dart';
import '../widgets/penalty_cancel_dialog.dart';
import '../widgets/penalty_context_menu_scope.dart';
import '../widgets/penalty_detail_panel.dart';
import '../widgets/penalty_identity.dart';
import '../widgets/penalty_log_tile.dart';
import '../widgets/penalty_pager.dart';
import '../widgets/penalty_score_badge.dart';

class AdminPenaltyPage extends ConsumerStatefulWidget {
  const AdminPenaltyPage({super.key});

  @override
  ConsumerState<AdminPenaltyPage> createState() => _AdminPenaltyPageState();
}

class _AdminPenaltyPageState extends ConsumerState<AdminPenaltyPage> {
  final _channel = TextEditingController();
  final _discord = TextEditingController();
  final _ranking = TextEditingController();

  @override
  void dispose() {
    _channel.dispose();
    _discord.dispose();
    _ranking.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!ref.watch(currentUserStateProvider).roles.contains(UserRole.ADMIN)) {
      return const Center(child: Text('관리자만 접근할 수 있습니다.'));
    }
    final state = ref.watch(adminPenaltyProvider);
    return PenaltyContextMenuScope(
      child: Padding(
        padding: const EdgeInsets.all(PenaltyTokens.gap),
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppBreadcrumb(items: ['ERP 메뉴', PenaltyStrings.title]),
              const SizedBox(height: PenaltyTokens.cardGap),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: PenaltyTokens.gap,
                runSpacing: PenaltyTokens.gap,
                children: [
                  Text(
                    PenaltyStrings.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  ElevatedButton.icon(
                    onPressed: state.isSubmitting ? null : _showAward,
                    icon: const Icon(Icons.add),
                    label: const Text(PenaltyStrings.award),
                  ),
                ],
              ),
              const SizedBox(height: PenaltyTokens.headerToTabsGap),
              Container(
                padding: const EdgeInsets.all(PenaltyTokens.tabBarInset),
                decoration: const BoxDecoration(
                  color: PenaltyTokens.tabBarBackground,
                  borderRadius: BorderRadius.all(
                    Radius.circular(PenaltyTokens.tabBarRadius),
                  ),
                ),
                child: const TabBar(
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: PenaltyTokens.tabBarActiveBackground,
                    borderRadius: BorderRadius.all(
                      Radius.circular(PenaltyTokens.tabBarRadius),
                    ),
                  ),
                  labelColor: PenaltyTokens.tabBarActiveForeground,
                  unselectedLabelColor: PenaltyTokens.tabBarInactiveForeground,
                  labelStyle: TextStyle(fontWeight: FontWeight.w700),
                  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
                  tabs: [
                    Tab(
                      text: PenaltyStrings.history,
                      height: PenaltyTokens.tabHeight,
                    ),
                    Tab(
                      text: PenaltyStrings.ranking,
                      height: PenaltyTokens.tabHeight,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [_historyPanel(state), _rankingPanel(state)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _historyPanel(AdminPenaltyState state) {
    final history = state.history;
    final cumulativeScores = history == null
        ? const <int>[]
        : cumulativeScoresForLogs(
            logs: history.items,
            newestFirst: state.sort == 'OCCURRED_AT_DESC',
          );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: PenaltyTokens.gap),
        Wrap(
          spacing: PenaltyTokens.gap,
          runSpacing: PenaltyTokens.gap,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                controller: _channel,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(20),
                ],
                decoration: const InputDecoration(
                  labelText: PenaltyStrings.channelId,
                ),
                onSubmitted: (_) => _searchHistory(),
              ),
            ),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _discord,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(20),
                ],
                decoration: const InputDecoration(
                  labelText: PenaltyStrings.targetId,
                ),
                onSubmitted: (_) => _searchHistory(),
              ),
            ),
            SizedBox(
              width: 160,
              child: DropdownButtonFormField<String>(
                value: state.sort,
                decoration: const InputDecoration(
                  labelText: PenaltyStrings.sort,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'OCCURRED_AT_DESC',
                    child: Text('최신순'),
                  ),
                  DropdownMenuItem(
                    value: 'OCCURRED_AT_ASC',
                    child: Text('오래된순'),
                  ),
                ],
                onChanged: (value) => value == null
                    ? null
                    : ref
                          .read(adminPenaltyProvider.notifier)
                          .loadHistory(page: 1, sort: value),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _searchHistory,
              icon: const Icon(Icons.search),
              label: const Text(PenaltyStrings.search),
            ),
          ],
        ),
        const SizedBox(height: PenaltyTokens.gap),
        Expanded(
          child: state.isHistoryLoading
              ? const Center(child: CircularProgressIndicator())
              : state.hasHistoryError
              ? _error(
                  () => ref
                      .read(adminPenaltyProvider.notifier)
                      .loadHistory(page: history?.page ?? 1),
                )
              : history == null || history.items.isEmpty
              ? const Center(child: Text(PenaltyStrings.noHistory))
              : ListView.separated(
                  itemCount: history.items.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: PenaltyTokens.cardGap),
                  itemBuilder: (context, index) {
                    final log = history.items[index];
                    return PenaltyLogTile(
                      log: log,
                      cumulativeScore: cumulativeScores[index],
                      onCancel: log.isCanceled || state.isSubmitting
                          ? null
                          : () => _showCancel(log),
                    );
                  },
                ),
        ),
        PenaltyPager(
          page: history?.page ?? 1,
          totalPages: history?.totalPages ?? 0,
          disabled: state.isHistoryLoading,
          onChanged: (page) =>
              ref.read(adminPenaltyProvider.notifier).loadHistory(page: page),
        ),
      ],
    );
  }

  Widget _rankingPanel(AdminPenaltyState state) {
    final members = state.members;
    final notifier = ref.read(adminPenaltyProvider.notifier);
    final list = Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(PenaltyTokens.gap),
        child: Column(
          children: [
            TextField(
              controller: _ranking,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(20),
              ],
              decoration: InputDecoration(
                labelText: PenaltyStrings.targetId,
                suffixIcon: IconButton(
                  tooltip: PenaltyStrings.search,
                  onPressed: () =>
                      notifier.loadMembers(discordId: _ranking.text),
                  icon: const Icon(Icons.search),
                ),
              ),
              onSubmitted: (_) =>
                  notifier.loadMembers(discordId: _ranking.text),
            ),
            const SizedBox(height: PenaltyTokens.gap),
            Expanded(
              child: state.isMembersLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.hasMembersError
                  ? _error(() => notifier.loadMembers(page: members?.page ?? 1))
                  : members == null || members.items.isEmpty
                  ? const Center(child: Text(PenaltyStrings.noRanking))
                  : ListView.builder(
                      itemCount: members.items.length,
                      itemBuilder: (context, index) {
                        final member = members.items[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: PenaltyTokens.cardPadding,
                          ),
                          selected: state.selectedId == member.discordId,
                          selectedTileColor:
                              PenaltyTokens.selectedListBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              PenaltyTokens.rankingListTileRadius,
                            ),
                          ),
                          title: PenaltyIdentity(
                            username: member.username,
                            discordId: member.discordId,
                            child: Text(
                              member.username,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          subtitle: PenaltyIdentity(
                            username: member.username,
                            discordId: member.discordId,
                            child: Text(
                              '${member.discordId} · ${member.penaltyCount30d}건 · ${DateFormat('yyyy.MM.dd HH:mm').format(member.lastOccurredAt.toLocal())}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: PenaltyTokens.metadataColor,
                                    fontSize: PenaltyTokens.metadataTextSize,
                                  ),
                            ),
                          ),
                          trailing: PenaltyScoreBadge(
                            score: member.cumulativeScore30d,
                            compact: true,
                          ),
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
    final detail = state.isDetailLoading
        ? const Center(child: CircularProgressIndicator())
        : state.hasDetailError
        ? _error(() => notifier.selectMember(state.selectedId!))
        : state.selected == null
        ? const Center(child: Text(PenaltyStrings.selectMember))
        : PenaltyDetailPanel(
            detail: state.selected!,
            showSummaryScore: false,
            isSubmitting: state.isSubmitting,
            onPageChanged: (page) =>
                notifier.selectMember(state.selectedId!, page: page),
            onCancel: _showCancel,
          );
    return Padding(
      padding: const EdgeInsets.only(top: PenaltyTokens.gap),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < PenaltyTokens.breakpoint) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 350, child: list),
                  const SizedBox(height: PenaltyTokens.gap),
                  SizedBox(height: 520, child: detail),
                ],
              ),
            );
          }
          return Row(
            children: [
              SizedBox(width: PenaltyTokens.listWidth, child: list),
              const SizedBox(width: PenaltyTokens.gap),
              Expanded(child: detail),
            ],
          );
        },
      ),
    );
  }

  Widget _error(VoidCallback retry) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(PenaltyStrings.loadFailed),
        ElevatedButton(
          onPressed: retry,
          child: const Text(PenaltyStrings.retry),
        ),
      ],
    ),
  );

  void _searchHistory() => ref
      .read(adminPenaltyProvider.notifier)
      .loadHistory(channelId: _channel.text, discordId: _discord.text);

  Future<void> _showAward() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => PenaltyAwardDialog(
        initialDiscordId: ref.read(adminPenaltyProvider).selectedId,
        onSubmit: ref.read(adminPenaltyProvider.notifier).award,
      ),
    );
    if (!mounted) return;
    if (result == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('벌점이 부여되었습니다.')));
    } else {
      ref.read(adminPenaltyProvider.notifier).loadHistory();
    }
  }

  Future<void> _showCancel(PenaltyLog log) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => PenaltyCancelDialog(
        log: log,
        onSubmit: (reason) =>
            ref.read(adminPenaltyProvider.notifier).cancel(log.id, reason),
      ),
    );
    if (!mounted) return;
    if (result == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('벌점이 취소되었습니다.')));
    } else {
      ref.read(adminPenaltyProvider.notifier).loadHistory();
      final selected = ref.read(adminPenaltyProvider).selectedId;
      if (selected != null)
        ref.read(adminPenaltyProvider.notifier).selectMember(selected);
    }
  }
}
