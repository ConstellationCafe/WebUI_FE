import 'package:flutter/material.dart';

import '../../controller/db_editor/DBController.dart';

class DBSearch extends StatefulWidget {
  final DBController controller;
  final Set<String> hiddenColumns;

  const DBSearch({
    super.key,
    required this.controller,
    this.hiddenColumns = const {},
  });

  @override
  State<DBSearch> createState() => _DBSearchState();
}

class _DBSearchState extends State<DBSearch> {
  final TextEditingController _valueController = TextEditingController();

  String? _selectedColumn;

  @override
  void initState() {
    super.initState();

    _initializeColumn();
  }

  void _initializeColumn() {
    final columns = widget.controller
        .getColumns()
        .where((column) => !widget.hiddenColumns.contains(column))
        .toList();

    if (columns.isNotEmpty) {
      _selectedColumn = columns.first;
    }
  }

  /*
   * 최초 서버 조회가 끝나기 전에는
   * columns가 비어있을 수 있다.
   *
   * loadInitialPage() 이후 컬럼이 생성되면
   * 첫 번째 컬럼을 자동 선택한다.
   */
  @override
  void didUpdateWidget(covariant DBSearch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_selectedColumn == null) {
      _initializeColumn();
    }
  }

  Future<void> _search() async {
    final column = _selectedColumn;

    final value = _valueController.text.trim();

    if (column == null) {
      _showMessage('검색할 컬럼을 선택해주세요.');

      return;
    }

    if (value.isEmpty) {
      _showMessage('검색할 값을 입력해주세요.');

      return;
    }

    try {
      await widget.controller.search(column, value);
    } catch (e) {
      if (!mounted) {
        return;
      }

      _showMessage(_errorMessage(e));
    }
  }

  Future<void> _reset() async {
    try {
      await widget.controller.clearSearch();

      _valueController.clear();

      if (!mounted) {
        return;
      }

      setState(() {});
    } catch (e) {
      if (!mounted) {
        return;
      }

      _showMessage(_errorMessage(e));
    }
  }

  String _errorMessage(Object error) {
    /*
     * StateError:
     * Bad state: 저장하지 않은...
     *
     * UI에는 Bad state를 제외하고 보여준다.
     */
    if (error is StateError) {
      return error.message.toString();
    }

    return error.toString();
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

  @override
  Widget build(BuildContext context) {
    /*
     * AnimatedBuilder가 필요한 이유:
     *
     * 최초 build 시에는 DBController의
     * columns가 비어있다.
     *
     * loadInitialPage()
     *      ↓
     * model.replace()
     *      ↓
     * columns 생성
     *      ↓
     * notifyListeners()
     *
     * 이때 검색창도 다시 build 해야 한다.
     */
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final columns = widget.controller
            .getColumns()
            .where((column) => !widget.hiddenColumns.contains(column))
            .toList();
        /*
         * 최초 조회 이후 컬럼 자동 선택
         */
        if (_selectedColumn == null && columns.isNotEmpty) {
          _selectedColumn = columns.first;
        }
        /*
         * Repository 변경 등으로
         * 기존 선택 컬럼이 사라진 경우
         */
        if (_selectedColumn != null && !columns.contains(_selectedColumn)) {
          _selectedColumn = columns.isEmpty ? null : columns.first;
        }

        return SizedBox(
          height: 45,
          child: Row(
            children: [
              // =================================
              // Column
              // =================================
              SizedBox(
                width: 130,
                child: DropdownButtonFormField<String>(
                  value: _selectedColumn,
                  isExpanded: true,

                  decoration: const InputDecoration(
                    labelText: 'Column',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                  ),

                  items: columns.map((column) {
                    return DropdownMenuItem<String>(
                      value: column,
                      child: Text(column, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),

                  onChanged: widget.controller.isLoading
                      ? null
                      : (value) {
                          setState(() {
                            _selectedColumn = value;
                          });
                        },
                ),
              ),

              const SizedBox(width: 8),

              // =================================
              // Value
              // =================================
              Expanded(
                child: TextField(
                  controller: _valueController,

                  enabled: !widget.controller.isLoading,

                  decoration: const InputDecoration(
                    labelText: 'Value',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                  ),

                  /*
                   * Enter로도 검색 가능
                   */
                  onSubmitted: (_) {
                    if (!widget.controller.isLoading) {
                      _search();
                    }
                  },
                ),
              ),

              const SizedBox(width: 4),

              // =================================
              // Search
              // =================================
              IconButton(
                tooltip: '검색',

                onPressed: widget.controller.isLoading ? null : _search,

                icon: const Icon(Icons.search),
              ),

              // =================================
              // Reset
              // =================================
              IconButton(
                tooltip: '검색 초기화',

                onPressed: widget.controller.isLoading ? null : _reset,

                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
        );
      },
    );
  }
}
