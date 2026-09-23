import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/const_size.dart';

import '../domain/point_log.dart';
import '../domain/point_member.dart';
import '../domain/point_member_detail.dart';
import '../domain/point_page.dart';
import '../state/point_management_notifier.dart';
import '../state/point_management_state.dart';

class PointManagementPage extends ConsumerWidget {
  const PointManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pointManagementProvider);
    final notifier = ref.read(pointManagementProvider.notifier);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 1000;
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1500),
            child: Padding(
              padding: ConstPadding.smallPaddingAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: ConstSize.mediumSpacing),
                  Expanded(
                    child: isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                width: 340,
                                child: _buildMembers(context, state, notifier),
                              ),
                              const SizedBox(width: ConstSize.mediumSpacing),
                              Expanded(
                                child: _buildDetail(
                                  context,
                                  ref,
                                  state,
                                  notifier,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 250,
                                child: _buildMembers(context, state, notifier),
                              ),
                              const SizedBox(height: ConstSize.smallSpacing),
                              Expanded(
                                child: _buildDetail(
                                  context,
                                  ref,
                                  state,
                                  notifier,
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) => Row(
    children: [
      const Icon(Icons.account_balance_wallet_outlined, size: 28),
      const SizedBox(width: ConstSize.smallSpacing),
      Expanded(
        child: Text(
          '포인트 관리',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      Text('ERP · 인사', style: Theme.of(context).textTheme.labelLarge),
    ],
  );

  Widget _buildMembers(
    BuildContext context,
    PointManagementState state,
    PointManagementNotifier notifier,
  ) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: ConstPadding.mediumPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('재적 회원', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: ConstSize.smallSpacing),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('point-discord-id-search'),
                    onChanged: notifier.updateDiscordIdSearch,
                    onSubmitted: (_) => notifier.loadMembers(),
                    decoration: const InputDecoration(
                      labelText: 'Discord ID',
                      hintText: 'ID를 정확히 입력해 검색',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: ConstSize.smallSpacing),
                IconButton.filledTonal(
                  tooltip: '회원 검색',
                  onPressed: () => notifier.loadMembers(),
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: ConstSize.smallSpacing),
            Expanded(
              child: state.members.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (_, __) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('회원 목록을 불러오지 못했습니다.'),
                      TextButton(
                        onPressed: () => notifier.loadMembers(),
                        child: const Text('다시 시도'),
                      ),
                    ],
                  ),
                ),
                data: (page) {
                  if (page.items.isEmpty) {
                    final message = state.discordIdSearch.isEmpty
                        ? '재적 회원이 없습니다.'
                        : '일치하는 Discord ID가 없습니다.';
                    return Center(child: Text(message));
                  }
                  return ListView.separated(
                    key: const Key('point-member-list'),
                    itemCount: page.items.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: ConstSize.tinySpacing),
                    itemBuilder: (context, index) {
                      final member = page.items[index];
                      return _buildMemberTile(
                        context,
                        member,
                        selected: state.selectedDiscordId == member.discordId,
                        onTap: () => notifier.selectMember(member),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: ConstSize.smallSpacing),
            _buildPagination(
              context,
              pageValue: state.members.valueOrNull,
              onPrevious: state.memberPage > 1
                  ? () => notifier.loadMembers(page: state.memberPage - 1)
                  : null,
              onNext: state.members.valueOrNull?.hasNext == true
                  ? () => notifier.loadMembers(page: state.memberPage + 1)
                  : null,
              label: '회원',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberTile(
    BuildContext context,
    PointMember member, {
    required bool selected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Material(
      color: selected
          ? theme.colorScheme.secondaryContainer
          : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: ConstPadding.smallPaddingAll,
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                child: Text(
                  member.username.isEmpty
                      ? '?'
                      : member.username.characters.first,
                ),
              ),
              const SizedBox(width: ConstSize.smallSpacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.username,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall,
                    ),
                    Text(
                      member.discordId,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: ConstSize.smallSpacing),
              Text(NumberFormat.decimalPattern().format(member.coin) + ' P'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetail(
    BuildContext context,
    WidgetRef ref,
    PointManagementState state,
    PointManagementNotifier notifier,
  ) {
    final discordId = state.selectedDiscordId;
    final detailAsync = state.detail;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: ConstPadding.mediumPaddingAll,
        child: discordId == null || detailAsync == null
            ? const Center(
                child: Text('회원 목록에서 포인트를 조회할 회원을 선택하세요.'),
              )
            : detailAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (_, __) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('포인트 정보를 불러오지 못했습니다.'),
                      TextButton(
                        onPressed: () => notifier.selectMember(
                          PointMember(
                            discordId: discordId,
                            username: discordId,
                            coin: 0,
                          ),
                        ),
                        child: const Text('다시 시도'),
                      ),
                    ],
                  ),
                ),
                data: (detail) => _buildMemberDetail(
                  context,
                  ref,
                  state,
                  notifier,
                  detail,
                ),
              ),
      ),
    );
  }

  Widget _buildMemberDetail(
    BuildContext context,
    WidgetRef ref,
    PointManagementState state,
    PointManagementNotifier notifier,
    PointMemberDetail detail,
  ) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detail.member.username,
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    detail.member.discordId,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('현재 잔액', style: theme.textTheme.labelMedium),
                Text(
                  NumberFormat.decimalPattern().format(detail.member.coin) +
                      ' P',
                  key: const Key('point-current-balance'),
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: ConstSize.mediumSpacing),
        Wrap(
          spacing: ConstSize.smallSpacing,
          runSpacing: ConstSize.smallSpacing,
          children: [
            FilledButton.icon(
              key: const Key('point-deposit-button'),
              onPressed: state.isSubmitting
                  ? null
                  : () => _openAdjustmentDialog(
                      context,
                      notifier,
                      detail.member,
                      type: 'DEPOSIT',
                    ),
              icon: const Icon(Icons.add),
              label: const Text('입금'),
            ),
            OutlinedButton.icon(
              key: const Key('point-withdraw-button'),
              onPressed: state.isSubmitting
                  ? null
                  : () => _openAdjustmentDialog(
                      context,
                      notifier,
                      detail.member,
                      type: 'WITHDRAW',
                    ),
              icon: const Icon(Icons.remove),
              label: const Text('출금'),
            ),
          ],
        ),
        const SizedBox(height: ConstSize.mediumSpacing),
        Text('포인트 내역', style: theme.textTheme.titleMedium),
        const SizedBox(height: ConstSize.smallSpacing),
        Expanded(
          child: detail.logs.items.isEmpty
              ? const Center(child: Text('포인트 내역이 없습니다.'))
              : ListView.separated(
                  key: const Key('point-log-list'),
                  itemCount: detail.logs.items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) =>
                      _buildLogTile(context, detail.logs.items[index]),
                ),
        ),
        const SizedBox(height: ConstSize.smallSpacing),
        _buildPagination(
          context,
          pageValue: detail.logs,
          onPrevious: detail.logs.page > 1
              ? () => notifier.changeLogPage(detail.logs.page - 1)
              : null,
          onNext: detail.logs.hasNext
              ? () => notifier.changeLogPage(detail.logs.page + 1)
              : null,
          label: '내역',
        ),
      ],
    );
  }

  Widget _buildLogTile(BuildContext context, PointLog log) {
    final isDeposit = log.amount >= 0;
    final color = isDeposit
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.error;
    final parsedAt = DateTime.tryParse(log.at);
    final formattedAt = parsedAt == null
        ? log.at
        : DateFormat('yyyy.MM.dd HH:mm').format(parsedAt);
    final signedAmount =
        (log.amount > 0 ? '+' : '') +
        NumberFormat.decimalPattern().format(log.amount) +
        ' P';
    return Padding(
      padding: ConstPadding.smallPaddingVertical,
      child: Row(
        children: [
          Icon(
            isDeposit ? Icons.south_west : Icons.north_east,
            color: color,
            size: 18,
          ),
          const SizedBox(width: ConstSize.smallSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(log.description.isEmpty ? '내용 없음' : log.description),
                Text(formattedAt, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Text(
            signedAmount,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(
    BuildContext context, {
    required PointPage<dynamic>? pageValue,
    required VoidCallback? onPrevious,
    required VoidCallback? onNext,
    required String label,
  }) {
    final page = pageValue?.page ?? 1;
    final totalPages = pageValue?.totalPages ?? 0;
    final totalElements = pageValue?.totalElements ?? 0;
    final displayedTotalPages = totalPages == 0 ? 1 : totalPages;
    return Row(
      children: [
        Expanded(
          child: Text(
            '$label · $totalElements건',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        IconButton(
          tooltip: '이전 페이지',
          onPressed: onPrevious,
          icon: const Icon(Icons.chevron_left),
        ),
        Text('$page / $displayedTotalPages'),
        IconButton(
          tooltip: '다음 페이지',
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }

  Future<void> _openAdjustmentDialog(
    BuildContext context,
    PointManagementNotifier notifier,
    PointMember member, {
    required String type,
  }) async {
    final amountController = TextEditingController();
    final descriptionController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final actionName = type == 'DEPOSIT' ? '입금' : '출금';
    try {
      final result = await showDialog<({int amount, String description})>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text('$actionName 처리 · ' + member.username),
          content: SizedBox(
            width: 420,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const Key('point-adjustment-amount'),
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: '포인트',
                      suffixText: 'P',
                    ),
                    validator: (value) {
                      final amount = int.tryParse(value ?? '');
                      return amount == null || amount <= 0
                          ? '1 이상의 포인트를 입력하세요.'
                          : null;
                    },
                  ),
                  const SizedBox(height: ConstSize.smallSpacing),
                  TextFormField(
                    key: const Key('point-adjustment-description'),
                    controller: descriptionController,
                    maxLength: 1000,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: '내역 설명',
                      alignLabelWithHint: true,
                    ),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? '내역 설명을 입력하세요.'
                        : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('취소'),
            ),
            FilledButton(
              key: const Key('point-adjustment-submit'),
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                Navigator.pop(
                  dialogContext,
                  (
                    amount: int.parse(amountController.text),
                    description: descriptionController.text.trim(),
                  ),
                );
              },
              child: Text('$actionName 확정'),
            ),
          ],
        ),
      );
      if (result == null) {
        return;
      }
      try {
        await notifier.adjustPoint(
          type: type,
          amount: result.amount,
          description: result.description,
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$actionName 처리 완료')),
          );
        }
      } catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$actionName 처리에 실패했습니다. 다시 시도하세요.')),
          );
        }
      }
    } finally {
      amountController.dispose();
      descriptionController.dispose();
    }
  }
}
