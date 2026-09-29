import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';

import '../../constants/db_editor_strings.dart';
import '../../constants/db_editor_tokens.dart';
import '../../notifier/db_editor/db_editor_notifier.dart';

/// 컬럼을 골라 값으로 검색하는 입력줄.
class DBSearch extends ConsumerStatefulWidget {
  final RepositoryInterface repository;
  final Set<String> hiddenColumns;

  const DBSearch({
    super.key,
    required this.repository,
    this.hiddenColumns = const {},
  });

  @override
  ConsumerState<DBSearch> createState() => _DBSearchState();
}

class _DBSearchState extends ConsumerState<DBSearch> {
  final TextEditingController _valueController = TextEditingController();

  String? _selectedColumn;

  DbEditorNotifier get _notifier =>
      ref.read(dbEditorProvider(widget.repository).notifier);

  Future<void> _search() async {
    final column = _selectedColumn;
    final value = _valueController.text.trim();

    if (column == null) {
      _showMessage(DbEditorStrings.selectSearchColumn);
      return;
    }

    if (value.isEmpty) {
      _showMessage(DbEditorStrings.enterSearchValue);
      return;
    }

    try {
      await _notifier.search(column, value);
    } catch (e) {
      if (!mounted) {
        return;
      }
      _showMessage(DbEditorStrings.errorMessage(e));
    }
  }

  Future<void> _reset() async {
    try {
      await _notifier.clearSearch();

      _valueController.clear();

      if (!mounted) {
        return;
      }

      setState(() {});
    } catch (e) {
      if (!mounted) {
        return;
      }
      _showMessage(DbEditorStrings.errorMessage(e));
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  static const _fieldPadding = EdgeInsets.symmetric(
    horizontal: DbEditorTokens.searchFieldHorizontalPadding,
    vertical: DbEditorTokens.searchFieldVerticalPadding,
  );

  @override
  Widget build(BuildContext context) {
    // 최초 조회가 끝나야 컬럼이 생기므로, 상태가 바뀔 때마다 컬럼 목록을 다시 계산한다.
    final state = ref.watch(dbEditorProvider(widget.repository));
    final columns = state.columnNames
        .where((column) => !widget.hiddenColumns.contains(column))
        .toList();

    // 최초 조회 이후 컬럼 자동 선택
    if (_selectedColumn == null && columns.isNotEmpty) {
      _selectedColumn = columns.first;
    }
    // Repository 변경 등으로 기존 선택 컬럼이 사라진 경우
    if (_selectedColumn != null && !columns.contains(_selectedColumn)) {
      _selectedColumn = columns.isEmpty ? null : columns.first;
    }

    return SizedBox(
      height: DbEditorTokens.searchBarHeight,
      child: Row(
        children: [
          SizedBox(
            width: DbEditorTokens.searchColumnWidth,
            child: DropdownButtonFormField<String>(
              // 선택 컬럼은 이 위젯이 소유하고 컬럼 목록 변경 시 다시 고르므로
              // controlled value를 유지한다.
              // ignore: deprecated_member_use
              value: _selectedColumn,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: DbEditorStrings.columnLabel,
                border: OutlineInputBorder(),
                contentPadding: _fieldPadding,
              ),
              items: columns.map((column) {
                return DropdownMenuItem<String>(
                  value: column,
                  child: Text(column, overflow: TextOverflow.ellipsis),
                );
              }).toList(),
              onChanged: state.isLoading
                  ? null
                  : (value) {
                      setState(() {
                        _selectedColumn = value;
                      });
                    },
            ),
          ),
          const SizedBox(width: DbEditorTokens.searchGap),
          Expanded(
            child: TextField(
              controller: _valueController,
              enabled: !state.isLoading,
              decoration: const InputDecoration(
                labelText: DbEditorStrings.valueLabel,
                border: OutlineInputBorder(),
                contentPadding: _fieldPadding,
              ),
              // Enter로도 검색
              onSubmitted: (_) {
                if (!state.isLoading) {
                  _search();
                }
              },
            ),
          ),
          const SizedBox(width: DbEditorTokens.searchButtonGap),
          IconButton(
            tooltip: DbEditorStrings.search,
            onPressed: state.isLoading ? null : _search,
            icon: const Icon(Icons.search),
          ),
          IconButton(
            tooltip: DbEditorStrings.resetSearch,
            onPressed: state.isLoading ? null : _reset,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
