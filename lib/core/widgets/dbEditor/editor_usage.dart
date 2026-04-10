import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/widgets/usage/usage.dart';

class EditorUsage {
  static List<UsageStep> steps({
    required GlobalKey columnKey,
    required GlobalKey viewKey,
    required GlobalKey addKey,
    required GlobalKey deleteKey,
    required GlobalKey editKey,
    required GlobalKey saveKey,
  }) {
    return [
      UsageStep(
        key: columnKey,
        message: '컬럼을 클릭하면 해당 열을 오름차순/내림차순 정렬 할 수 있어요',
      ),
      UsageStep(
        key: viewKey,
        message: '셀을 더블클릭하면 해당 셀을 편집 할 수 있어요',
      ),
      UsageStep(
        key: addKey,
        message: '행을 추가하는 버튼이에요',
      ),
      UsageStep(
        key: deleteKey,
        message: '선택한 행을 삭제하는 버튼이에요',
      ),
      UsageStep(
        key: editKey,
        message: '선택한 셀을 편집하는 버튼이에요',
      ),
      UsageStep(
        key: saveKey,
        message: '변경 사항을 저장하는 버튼이에요',
      ),
    ];
  }

  static const String key = 'editor_tutorial_v0.0.1';
}