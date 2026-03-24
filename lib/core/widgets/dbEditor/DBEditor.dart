import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/ConstSize.dart';
import 'package:constellation_cafe/data/api/backend/repository/RepositoryInterface.dart';
import 'package:constellation_cafe/data/model/entity/EntityInterface.dart';
import 'package:constellation_cafe/data/model/dbEditor/DBController.dart';
import 'DBColumns.dart';
import 'DBDataView.dart';
// import 'DBSearch.dart';
import 'EditorBar.dart';

class DBEditor extends StatefulWidget {
  final RepositoryInterface repository;

  const DBEditor({super.key, required this.repository});

  @override
  State<DBEditor> createState() => _DBEditorState();
}

class _DBEditorState extends State<DBEditor> {
  DBController? _controller;

  Widget createDBEditor(DBController controller) {
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
                DBColumns(controller: controller),
                SizedBox(height: ConstSize.mediumHeight),
                Expanded(child: DBDataView(controller: controller)),
                SizedBox(height: ConstSize.mediumHeight),
                EditorBar(controller: controller),
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
          return createDBEditor(_controller!);
        } else {
          return const Text("데이터 없음");
        }
      },
    );
  }
}
