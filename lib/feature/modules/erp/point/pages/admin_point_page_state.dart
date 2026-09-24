part of 'admin_point_page.dart';

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
                  searchController: _searchController,
                  isLoading: state.isLoadingMembers,
                  isSubmitting: state.isSubmitting,
                  hasError: state.hasMembersError,
                  onRetry: () => ref
                      .read(adminPointProvider.notifier)
                      .loadMembers(page: state.memberPage),
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

  Future<void> _showTransactionDialog(bool isDeposit) async {
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
    if (!mounted) return;
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
