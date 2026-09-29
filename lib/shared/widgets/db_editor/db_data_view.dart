import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';

import '../../constants/db_editor_colors.dart';
import '../../constants/db_editor_strings.dart';
import '../../constants/db_editor_tokens.dart';
import '../../notifier/db_editor/db_editor_notifier.dart';
import 'db_data_cell.dart';

/// 조회한 데이터 표. 끝에 가까워지면 다음 페이지를 불러온다.
class DBDataView extends ConsumerStatefulWidget {
  final RepositoryInterface repository;
  final Set<String> hiddenColumns;
  final Set<String> readOnlyColumns;

  const DBDataView({
    super.key,
    required this.repository,
    this.hiddenColumns = const {},
    this.readOnlyColumns = const {},
  });

  @override
  ConsumerState<DBDataView> createState() => _DBDataViewState();
}

class _DBDataViewState extends ConsumerState<DBDataView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;

    if (position.pixels >=
        position.maxScrollExtent - DbEditorTokens.loadMoreThreshold) {
      ref.read(dbEditorProvider(widget.repository).notifier).loadNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  static const _border = BorderSide(
    color: DBEditorColors.border,
    width: DbEditorTokens.borderWidth,
  );

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dbEditorProvider(widget.repository));
    final notifier = ref.read(dbEditorProvider(widget.repository).notifier);

    if (state.countRow == 0) {
      if (state.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      return const Center(child: Text(DbEditorStrings.empty));
    }

    final columns = state.model.columns;
    final selectedCell = state.selectedCell;
    final visibleColumnIndexes = List.generate(columns.length, (index) => index)
        .where(
          (index) => !widget.hiddenColumns.contains(columns[index].toString()),
        )
        .toList();

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      child: Table(
        border: const TableBorder(
          top: _border,
          bottom: _border,
          left: _border,
          right: _border,
          horizontalInside: _border,
          verticalInside: _border,
        ),
        children: List.generate(state.countRow, (rowIndex) {
          final isRowSelected = rowIndex == selectedCell[1];
          return TableRow(
            children: visibleColumnIndexes.map((colIndex) {
              final columnName = columns[colIndex].toString();
              return DBDataCell(
                key: ValueKey('${rowIndex}_$colIndex'),
                value: state.model.getDisplayValue(colIndex, rowIndex),
                rowHeight: DbEditorTokens.rowHeight,
                isSelected: isRowSelected && colIndex == selectedCell[0],
                isEditMode: state.isEditMode,
                isEditable: !widget.readOnlyColumns.contains(columnName),
                onSelected: () => notifier.setSelectedCell(colIndex, rowIndex),
                onChanged: (value) =>
                    notifier.updateCell(colIndex, rowIndex, value),
              );
            }).toList(),
          );
        }),
      ),
    );
  }
}
