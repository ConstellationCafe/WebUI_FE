import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';

import '../../constants/db_editor_colors.dart';
import '../../constants/db_editor_tokens.dart';
import 'db_columns.dart';
import 'db_data_view.dart';
import 'db_search.dart';
import 'editor_bar.dart';

/// 편집기 카드: 검색, 컬럼 머리글, 데이터 표, 편집 도구를 세로로 배치한다.
class DbEditorPanel extends StatelessWidget {
  final RepositoryInterface repository;
  final bool readonly;
  final Set<String> hiddenColumns;
  final Set<String> readOnlyColumns;
  final GlobalKey columnKey;
  final GlobalKey viewKey;
  final GlobalKey addKey;
  final GlobalKey deleteKey;
  final GlobalKey editKey;
  final GlobalKey saveKey;

  const DbEditorPanel({
    super.key,
    required this.repository,
    required this.readonly,
    required this.hiddenColumns,
    required this.readOnlyColumns,
    required this.columnKey,
    required this.viewKey,
    required this.addKey,
    required this.deleteKey,
    required this.editKey,
    required this.saveKey,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxH = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : DbEditorTokens.editorMaxHeight;

        final editorH = maxH < DbEditorTokens.editorMaxHeight
            ? maxH
            : DbEditorTokens.editorMaxHeight;

        return SizedBox(
          width: DbEditorTokens.editorWidth,
          height: editorH,
          child: Container(
            decoration: BoxDecoration(
              color: DBEditorColors.editorBackground,
              borderRadius: BorderRadius.circular(DbEditorTokens.editorRadius),
              boxShadow: const [
                BoxShadow(
                  color: DBEditorColors.shadow,
                  blurRadius: DbEditorTokens.shadowBlur,
                  offset: DbEditorTokens.shadowOffset,
                ),
              ],
            ),
            padding: const EdgeInsets.all(ConstSize.mediumSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DBSearch(repository: repository, hiddenColumns: hiddenColumns),
                const SizedBox(height: ConstSize.mediumSpacing),
                DBColumns(
                  key: columnKey,
                  repository: repository,
                  hiddenColumns: hiddenColumns,
                ),
                const SizedBox(height: ConstSize.mediumSpacing),
                Expanded(
                  child: DBDataView(
                    key: viewKey,
                    repository: repository,
                    hiddenColumns: hiddenColumns,
                    readOnlyColumns: readOnlyColumns,
                  ),
                ),
                if (!readonly) ...[
                  const SizedBox(height: ConstSize.mediumSpacing),
                  EditorBar(
                    repository: repository,
                    addKey: addKey,
                    deleteKey: deleteKey,
                    editKey: editKey,
                    saveKey: saveKey,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
