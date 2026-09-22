import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/shared/widgets/loading/ButtonLoading.dart';
import 'package:constellation_cafe/shared/widgets/loading/PageLoading.dart';
import 'package:constellation_cafe/shared/widgets/padding/CustomPadding.dart';
import 'package:constellation_cafe/shared/widgets/snackBar/SaveResultBar.dart';

void main() {
  group('loading widgets', () {
    testWidgets('ButtonLoading renders a compact white progress indicator',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ButtonLoading(),
          ),
        ),
      );

      final progress = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );

      expect(progress.strokeWidth, 2);
      expect(progress.color, Colors.white);
    });

    testWidgets('PageLoading expands and centers its progress indicator',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PageLoading(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);
    });
  });

  testWidgets('CustomPadding preserves its child and applies padding',
      (tester) async {
    const childKey = Key('padded-child');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomPadding.paddingAll03(
            child: const SizedBox(key: childKey),
          ),
        ),
      ),
    );

    final padding = tester.widget<Padding>(find.byType(Padding));

    expect(find.byKey(childKey), findsOneWidget);
    expect(padding.padding, isNot(EdgeInsets.zero));
  });

  testWidgets('SaveResultBar creates an error snackbar with an action',
      (tester) async {
    final actionKey = GlobalKey();
    var actionPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              key: actionKey,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SaveResultBar.buildOne(
                    context,
                    '저장에 실패했습니다',
                    type: SaveResultType.error,
                    actionLabel: '다시 시도',
                    onAction: () => actionPressed = true,
                  ),
                );
              },
              child: const Text('show'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(actionKey));
    await tester.pump();

    expect(find.text('저장에 실패했습니다'), findsOneWidget);
    expect(find.text('다시 시도'), findsOneWidget);

    await tester.tap(find.text('다시 시도'));
    expect(actionPressed, isTrue);
  });

  testWidgets('loading snackbar remains visible for a long duration',
      (tester) async {
    late SnackBar snackbar;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            snackbar = SaveResultBar.buildOne(
              context,
              '저장 중입니다',
              type: SaveResultType.loading,
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(snackbar.duration, const Duration(days: 1));
    expect(snackbar.content, isA<Row>());
  });
}
