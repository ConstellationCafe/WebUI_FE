import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';
import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';
import 'package:constellation_cafe/shared/model/db_editor/DBController.dart';
import '../usage/usage.dart';
import 'DBColumns.dart';
import 'DBDataView.dart';
// import 'DBSearch.dart';
import 'EditorBar.dart';
import 'editor_usage.dart';

class DBEditor extends StatefulWidget {
  final RepositoryInterface repository;
  final bool readonly;

  const DBEditor({
    super.key,
    required this.repository,
    this.readonly = false,
  });

  @override
  State<DBEditor> createState() => _DBEditorState();
}

class _DBEditorState extends State<DBEditor> {
  DBController? _controller;

  final GlobalKey columnKey = GlobalKey();
  final GlobalKey viewKey = GlobalKey();
  final GlobalKey addKey = GlobalKey();
  final GlobalKey deleteKey = GlobalKey();
  final GlobalKey editKey = GlobalKey();
  final GlobalKey saveKey = GlobalKey();

  Widget buildDBEditor(DBController controller) {
    if (widget.readonly) {
      return DBEditor(controller);
    } else {
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
          child: DBEditor(controller)
      );
    }
  }

  Widget DBEditor(DBController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxH = constraints.maxHeight.isFinite ? constraints.maxHeight : 500.0;
        final editorH = maxH < 500 ? maxH : 500.0;

        return SizedBox(
          width: 500,
          height: editorH,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF000D27).withOpacity(0.12),  // rgba(0, 13, 39, 0.12)
                  blurRadius: 24,                              // 24px 흐림
                  offset: Offset(0, 8),                        // 0px x, 8px y
                ),
              ],
            ),
            padding: const EdgeInsets.all(ConstSize.mediumWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DBColumns(
                    key: columnKey,
                    controller: controller
                ),
                SizedBox(height: ConstSize.mediumHeight),
                Expanded(child: DBDataView(
                    key: viewKey,
                    controller: controller
                )),
                if (widget.readonly==false)...[
                  SizedBox(height: ConstSize.mediumHeight),
                  EditorBar(
                      addKey: addKey,
                      deleteKey: deleteKey,
                      editKey: editKey,
                      saveKey: saveKey,
                      controller: controller
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Entity>>(
      future: widget.repository.findAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text("에러: ${snapshot.error}");
        } else if (snapshot.hasData) {
          // DBController 최초 한 번만 생성
          _controller ??= DBController(
              snapshot.data!,
              repository: widget.repository
          );
          return buildDBEditor(_controller!);
        } else {
          return const Text("데이터 없음");
        }
      },
    );
  }
}
