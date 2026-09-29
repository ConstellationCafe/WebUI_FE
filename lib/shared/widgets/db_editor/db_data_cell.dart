import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/db_editor_colors.dart';
import '../../constants/db_editor_tokens.dart';

/// 표의 셀 하나. 선택된 셀은 편집 모드에서 입력란으로 바뀌고, 우클릭하면 값을 복사한다.
class DBDataCell extends StatefulWidget {
  final String value;
  final double rowHeight;
  final bool isSelected;
  final bool isEditMode;
  final bool isEditable;
  final VoidCallback onSelected;
  final ValueChanged<String> onChanged;

  const DBDataCell({
    super.key,
    required this.value,
    required this.rowHeight,
    required this.isSelected,
    required this.isEditMode,
    required this.onSelected,
    required this.onChanged,
    this.isEditable = true,
  });

  @override
  State<DBDataCell> createState() => _DBDataCellState();
}

class _DBDataCellState extends State<DBDataCell> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant DBDataCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 선택된 셀이 바뀌면 초기값 업데이트
    if (widget.isSelected && !oldWidget.isSelected) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    BrowserContextMenu.enableContextMenu();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: widget.value));
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isSelected
        ? DBEditorColors.selectedCell
        : Colors.transparent;

    if (widget.isSelected && widget.isEditMode && widget.isEditable) {
      return Container(
        height: widget.rowHeight,
        color: bgColor,
        padding: const EdgeInsets.all(DbEditorTokens.cellPadding),
        child: Center(
          child: TextFormField(
            controller: _controller,
            autofocus: true,
            cursorColor: DBEditorColors.cursor,
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: DbEditorTokens.cellPadding,
              ),
            ),
            onChanged: widget.onChanged,
          ),
        ),
      );
    }

    return MouseRegion(
      onEnter: (_) => BrowserContextMenu.disableContextMenu(),
      onExit: (_) => BrowserContextMenu.enableContextMenu(),
      child: GestureDetector(
        onTap: widget.onSelected,
        onSecondaryTap: _copyToClipboard,
        child: Container(
          height: widget.rowHeight,
          color: bgColor,
          padding: const EdgeInsets.all(DbEditorTokens.cellPadding),
          alignment: Alignment.centerLeft,
          child: Text(widget.value, overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
