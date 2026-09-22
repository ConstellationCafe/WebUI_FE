import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:constellation_cafe/shared/controller/db_editor/DBController.dart';

class DBDataCell extends StatefulWidget {
  final DBController controller;
  final int rowIndex;
  final int colIndex;
  final double rowHeight;
  final bool isSelected;
  final bool isEditMode;
  final bool isEditable;

  const DBDataCell({
    super.key,
    required this.controller,
    required this.rowIndex,
    required this.colIndex,
    required this.rowHeight,
    required this.isSelected,
    required this.isEditMode,
    this.isEditable = true,
  });

  @override
  State<DBDataCell> createState() => _EditableCellState();
}

class _EditableCellState extends State<DBDataCell> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text:
          widget.controller.model[widget.colIndex][widget.rowIndex]
              .toString() ??
          '',
    );
  }

  @override
  void didUpdateWidget(covariant DBDataCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 선택된 셀이 바뀌면 초기값 업데이트
    if (widget.isSelected && !oldWidget.isSelected) {
      _controller.text =
          widget.controller.model[widget.colIndex][widget.rowIndex]
              .toString() ??
          '';
    }
  }

  @override
  void dispose() {
    BrowserContextMenu.enableContextMenu();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _copyToClipboard() async {
    final value = widget.controller.model.getDisplayValue(
      widget.colIndex,
      widget.rowIndex,
    );

    await Clipboard.setData(ClipboardData(text: value));
  }

  Future<void> _disableContextMenu() async {
    await BrowserContextMenu.disableContextMenu();
  }

  Future<void> _enableContextMenu() async {
    await BrowserContextMenu.enableContextMenu();
  }

  @override
  Widget build(BuildContext context) {
    Color? bgColor = widget.isSelected
        ? Colors.grey.withOpacity(0.3)
        : Colors.transparent;

    if (widget.isSelected && widget.isEditMode && widget.isEditable) {
      return Container(
        height: widget.rowHeight,
        color: bgColor,
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: TextFormField(
            controller: _controller,
            autofocus: true,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
            ),
            onChanged: (value) {
              widget.controller.model[widget.colIndex][widget.rowIndex] = value;
            },
          ),
        ),
      );
    } else {
      final value = widget.controller.model.getDisplayValue(
        widget.colIndex,
        widget.rowIndex,
      );
      return MouseRegion(
        onEnter: (_) {
          _disableContextMenu();
        },
        onExit: (_) {
          _enableContextMenu();
        },
        child: GestureDetector(
          onTap: () {
            widget.controller.setSelectedCell(widget.colIndex, widget.rowIndex);
          },
          onSecondaryTap: () {
            _copyToClipboard();
          },
          child: Container(
            height: widget.rowHeight,
            color: bgColor,
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.centerLeft,
            child: Text(value, overflow: TextOverflow.ellipsis),
          ),
        ),
      );
    }
  }
}
