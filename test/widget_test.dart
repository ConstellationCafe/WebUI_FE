import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders a Flutter widget on the web platform', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Text('WebUI FE')),
    );

    expect(find.text('WebUI FE'), findsOneWidget);
  });
}
