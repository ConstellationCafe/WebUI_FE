import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';

import '../../constants/db_editor_strings.dart';
import '../../notifier/db_editor/db_editor_notifier.dart';
import '../usage/usage.dart';
import 'db_editor_panel.dart';
import 'editor_usage.dart';

/// 서버 데이터를 표로 보여주고 검색·정렬·편집·저장하는 편집기.
///
/// 상태는 [repository]별 [dbEditorProvider]가 소유하고, 이 위젯은 최초 조회와
/// 튜토리얼 대상 key만 관리한다.
class DBEditor extends ConsumerStatefulWidget {
  final RepositoryInterface repository;
  final bool readonly;
  final Set<String> hiddenColumns;
  final Set<String> readOnlyColumns;

  const DBEditor({
    super.key,
    required this.repository,
    this.readonly = false,
    this.hiddenColumns = const {},
    this.readOnlyColumns = const {},
  });

  @override
  ConsumerState<DBEditor> createState() => _DBEditorState();
}

class _DBEditorState extends ConsumerState<DBEditor> {
  final GlobalKey columnKey = GlobalKey();
  final GlobalKey viewKey = GlobalKey();

  final GlobalKey addKey = GlobalKey();
  final GlobalKey deleteKey = GlobalKey();
  final GlobalKey editKey = GlobalKey();
  final GlobalKey saveKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scheduleInitialLoad();
  }

  @override
  void didUpdateWidget(covariant DBEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.repository != widget.repository) {
      _scheduleInitialLoad();
    }
  }

  void _scheduleInitialLoad() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadInitialPage());
  }

  Future<void> _loadInitialPage() async {
    if (!mounted) return;
    try {
      await ref
          .read(dbEditorProvider(widget.repository).notifier)
          .loadInitialPage();
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(DbEditorStrings.loadFailed)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final panel = DbEditorPanel(
      repository: widget.repository,
      readonly: widget.readonly,
      hiddenColumns: widget.hiddenColumns,
      readOnlyColumns: widget.readOnlyColumns,
      columnKey: columnKey,
      viewKey: viewKey,
      addKey: addKey,
      deleteKey: deleteKey,
      editKey: editKey,
      saveKey: saveKey,
    );

    if (widget.readonly) {
      return panel;
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
      child: panel,
    );
  }
}
