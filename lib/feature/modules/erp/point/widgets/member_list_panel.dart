import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/point_strings.dart';
import '../domain/model/point_member.dart';
import 'point_load_error.dart';

class MemberListPanel extends StatelessWidget {
  final List<PointMember> members;
  final String? selectedDiscordId;
  final ValueChanged<String> onSearchChanged;
  final bool isLoading;
  final bool isSubmitting;
  final bool hasError;
  final VoidCallback? onRetry;
  final int page;
  final int totalPages;
  final VoidCallback onSearch;
  final ValueChanged<PointMember> onSelected;
  final ValueChanged<int> onPageChanged;

  const MemberListPanel({
    super.key,
    required this.members,
    required this.selectedDiscordId,
    required this.onSearchChanged,
    required this.isLoading,
    this.isSubmitting = false,
    this.hasError = false,
    this.onRetry,
    required this.page,
    required this.totalPages,
    required this.onSearch,
    required this.onSelected,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              PointStrings.members,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            SearchBar(
              onChanged: onSearchChanged,
              hintText: PointStrings.searchHint,
              leading: const Icon(Icons.search),
              onSubmitted: (_) => onSearch(),
              trailing: [
                IconButton(
                  tooltip: PointStrings.search,
                  onPressed: onSearch,
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    )
                  : hasError
                  ? PointLoadError(
                      message: PointStrings.membersFailed,
                      onRetry: onRetry,
                    )
                  : members.isEmpty
                  ? const Center(child: Text(PointStrings.noMembers))
                  : ListView.separated(
                      itemCount: members.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final member = members[index];
                        return ListTile(
                          selected: member.discordId == selectedDiscordId,
                          selectedColor: Theme.of(
                            context,
                          ).colorScheme.onSecondaryContainer,
                          selectedTileColor: Theme.of(
                            context,
                          ).colorScheme.secondaryContainer,
                          title: Text(member.username),
                          subtitle: Text(
                            '${member.discordId}\n${NumberFormat.decimalPattern().format(member.coin)} P',
                          ),
                          onTap: isSubmitting ? null : () => onSelected(member),
                        );
                      },
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: PointStrings.previousPage,
                  onPressed: !isLoading && page > 1
                      ? () => onPageChanged(page - 1)
                      : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text('$page / ${totalPages == 0 ? 1 : totalPages}'),
                IconButton(
                  tooltip: PointStrings.nextPage,
                  onPressed: !isLoading && page < totalPages
                      ? () => onPageChanged(page + 1)
                      : null,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
