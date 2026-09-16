import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';

import '../../controller/db_editor/DBController.dart';
import '../usage/usage.dart';

import 'DBColumns.dart';
import 'DBDataView.dart';
import 'DBSearch.dart';
import 'EditorBar.dart';
import 'editor_usage.dart';


class DBEditor extends StatefulWidget {
  final RepositoryInterface repository;
  final bool readonly;
  final Set<String> hiddenColumns;

  const DBEditor({
    super.key,
    required this.repository,
    this.readonly = false,
    this.hiddenColumns = const {},
  });

  @override
  State<DBEditor> createState() => _DBEditorState();
}

class _DBEditorState extends State<DBEditor> {
  late DBController _controller;

  final GlobalKey columnKey = GlobalKey();
  final GlobalKey viewKey = GlobalKey();

  final GlobalKey addKey = GlobalKey();
  final GlobalKey deleteKey = GlobalKey();
  final GlobalKey editKey = GlobalKey();
  final GlobalKey saveKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _controller = DBController(
      repository: widget.repository,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialPage();
    });
  }

  Future<void> _loadInitialPage() async {
    try {
      await _controller.loadInitialPage();
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '데이터 조회 실패: $e',
          ),
        ),
      );
    }
  }

  @override
  void didUpdateWidget(
      covariant DBEditor oldWidget,
      ) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.repository != widget.repository) {
      _controller.dispose();

      _controller = DBController(
        repository: widget.repository,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadInitialPage();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildDBEditor(
      DBController controller,
      ) {
    if (widget.readonly) {
      return _buildEditor(controller);
    }

    return Usage(
      usageKey: EditorUsage.key,
      steps: EditorUsage.steps(
        columnKey: columnKey,
        viewKey: viewKey,
        addKey: addKey,
        deleteKey: deleteKey,
        editKey: editKey,
        saveKey: saveKey,
      ),
      child: _buildEditor(controller),
    );
  }

  Widget _buildEditor(
      DBController controller,
      ) {
    return LayoutBuilder(
      builder: (
          context,
          constraints,
          ) {
        final maxH =
        constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 500.0;

        final editorH =
        maxH < 500
            ? maxH
            : 500.0;

        return SizedBox(
          width: 500,
          height: editorH,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: const Color(
                    0xFF000D27,
                  ).withOpacity(0.12),
                  blurRadius: 24,
                  offset:
                  const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(
              ConstSize.mediumWidth,
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .stretch,
              children: [

                // 검색 UI 추가
                DBSearch(
                  controller: controller,
                  hiddenColumns: widget.hiddenColumns,
                ),

                SizedBox(
                  height:
                  ConstSize
                      .mediumHeight,
                ),

                DBColumns(
                  key: columnKey,
                  controller: controller,
                  hiddenColumns: widget.hiddenColumns,
                ),
                SizedBox(
                  height: ConstSize.mediumHeight,
                ),
                Expanded(
                  child: DBDataView(
                    key: viewKey,
                    controller: controller,
                    hiddenColumns: widget.hiddenColumns,
                  ),
                ),
                if (controller.isLoading && controller.isInitialized)
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 8,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child:
                        CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),

                if (!widget.readonly) ...[
                  SizedBox(
                    height:
                    ConstSize
                        .mediumHeight,
                  ),

                  EditorBar(
                    addKey: addKey,
                    deleteKey:
                    deleteKey,
                    editKey: editKey,
                    saveKey: saveKey,
                    controller:
                    controller,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    if (!_controller.isInitialized &&
        _controller.isLoading) {
      return const Center(
        child:
        CircularProgressIndicator(),
      );
    }

    return buildDBEditor(
      _controller,
    );
  }
}