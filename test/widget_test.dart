import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/main.dart' as application;

void main() {
  testWidgets('renders the application shell', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: application.MyApp(),
      ),
    );

    expect(find.byType(application.MyApp), findsOneWidget);
  });
}
