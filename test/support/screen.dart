import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// 화면 크기를 [size] 논리 픽셀로 바꾼다.
///
/// `setSurfaceSize`는 `MediaQuery` 크기를 바꾸지 않으므로, 화면 폭으로
/// 레이아웃을 고르는 위젯은 이 함수를 사용한다.
void setScreenSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}
