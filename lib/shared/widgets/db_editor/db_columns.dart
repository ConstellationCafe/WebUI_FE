import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';

import '../../constants/db_editor_colors.dart';
import '../../constants/db_editor_strings.dart';
import '../../constants/db_editor_tokens.dart';
import '../../notifier/db_editor/db_editor_notifier.dart';
import 'db_sort_icon.dart';

/// 컬럼 머리글. 누르면 해당 컬럼으로 정렬한다.
class DBColumns extends ConsumerWidget {
  final RepositoryInterface repository;
  final Set<String> hiddenColumns;

  const DBColumns({
    super.key,
    required this.repository,
    this.hiddenColumns = const {},
  });

  Future<void> _sort(
    BuildContext context,
    DbEditorNotifier notifier,
    String columnName,
  ) async {
    try {
      await notifier.sort(columnName);
    } catch (e) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(DbEditorStrings.errorMessage(e))));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dbEditorProvider(repository));
    final notifier = ref.read(dbEditorProvider(repository).notifier);

    return SizedBox(
      width: double.infinity,
      height: DbEditorTokens.headerHeight,
      child: state.countColumn == 0
          ? const SizedBox()
          : Table(
              border: TableBorder.all(
                width: DbEditorTokens.borderWidth,
                color: DBEditorColors.headerBorder,
              ),
              children: [
                TableRow(
                  children: state.model.columns
                      .where(
                        (column) => !hiddenColumns.contains(column.toString()),
                      )
                      .map((column) {
                        return InkWell(
                          onTap: state.isLoading
                              ? null
                              : () =>
                                    _sort(context, notifier, column.toString()),
                          child: Container(
                            height: DbEditorTokens.headerHeight,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              horizontal:
                                  DbEditorTokens.headerHorizontalPadding,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    column.toString(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  width: DbEditorTokens.sortIconGap,
                                ),
                                DbSortIcon(direction: column.sortDir),
                              ],
                            ),
                          ),
                        );
                      })
                      .toList(),
                ),
              ],
            ),
    );
  }
}
