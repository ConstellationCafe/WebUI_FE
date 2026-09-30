import 'package:flutter/material.dart';

import '../constants/competition_strings.dart';
import '../constants/competition_tokens.dart';

/// 두 칸짜리 입력 줄 하나. 컨트롤러는 목록을 가진 폼 위젯이 만들고 해제한다.
class CompetitionLine {
  final TextEditingController left = TextEditingController();
  final TextEditingController right = TextEditingController();

  void dispose() {
    left.dispose();
    right.dispose();
  }
}

/// 우승 상품·추가 입력란처럼 "이름 : 내용" 줄을 더하고 빼는 목록.
class CompetitionLineList extends StatelessWidget {
  final String title;
  final String leftLabel;
  final String rightLabel;
  final String addLabel;
  final List<CompetitionLine> lines;
  final int maxLines;
  final bool enabled;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final String? Function(int index, String? value) validateLeft;
  final String? Function(int index, String? value) validateRight;

  const CompetitionLineList({
    super.key,
    required this.title,
    required this.leftLabel,
    required this.rightLabel,
    required this.addLabel,
    required this.lines,
    required this.maxLines,
    required this.enabled,
    required this.onAdd,
    required this.onRemove,
    required this.validateLeft,
    required this.validateRight,
  });

  @override
  Widget build(BuildContext context) {
    final canAdd = enabled && lines.length < maxLines;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        for (var index = 0; index < lines.length; index++) ...[
          const SizedBox(height: CompetitionTokens.rowGap),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: lines[index].left,
                  enabled: enabled,
                  decoration: InputDecoration(labelText: leftLabel),
                  validator: (value) => validateLeft(index, value),
                ),
              ),
              const SizedBox(width: CompetitionTokens.rowGap),
              Expanded(
                flex: 5,
                child: TextFormField(
                  controller: lines[index].right,
                  enabled: enabled,
                  decoration: InputDecoration(labelText: rightLabel),
                  validator: (value) => validateRight(index, value),
                ),
              ),
              IconButton(
                tooltip: CompetitionStrings.remove,
                onPressed: enabled ? () => onRemove(index) : null,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ],
        const SizedBox(height: CompetitionTokens.rowGap),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: canAdd ? onAdd : null,
            icon: const Icon(Icons.add),
            label: Text(
              lines.length < maxLines
                  ? addLabel
                  : CompetitionStrings.itemLimit(maxLines),
            ),
          ),
        ),
      ],
    );
  }
}
