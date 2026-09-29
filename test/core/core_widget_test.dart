import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/core/network/interceptors/error_interceptor.dart';

import '../support/fake_backend.dart';

void main() {
  late FakeBackend backend;
  late GlobalKey<ScaffoldMessengerState> messengerKey;

  setUp(() {
    backend = FakeBackend();
    messengerKey = GlobalKey<ScaffoldMessengerState>();
    backend.dio.interceptors.add(ErrorInterceptor(messengerKey));
  });

  tearDown(() => backend.close());

  Future<void> pumpApp(WidgetTester tester) {
    return tester.pumpWidget(
      MaterialApp(
        scaffoldMessengerKey: messengerKey,
        home: const Scaffold(body: SizedBox.shrink()),
      ),
    );
  }

  Future<void> request(
    WidgetTester tester,
    String path, {
    Options? options,
  }) async {
    await tester.runAsync(() async {
      try {
        await backend.dio.get(path, options: options);
      } on DioException {
        // 화면에 보이는 오류 안내만 검증한다.
      }
    });
    await tester.pump();
  }

  testWidgets('서버 오류는 상태 코드에 맞는 안내를 스낵바로 보여준다', (tester) async {
    backend.reply('GET', '/api/x', failure(500, 'boom'), status: 500);
    await pumpApp(tester);

    await request(tester, '/api/x');

    expect(find.text('서버 내부 오류가 발생했습니다'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
  });

  testWidgets('연결할 수 없으면 네트워크 확인 안내를 보여준다', (tester) async {
    await pumpApp(tester);

    await request(tester, '/api/unregistered');

    expect(find.text('네트워크 연결을 확인해주세요'), findsOneWidget);
  });

  testWidgets('인증 경로의 401은 조용히 넘긴다', (tester) async {
    backend.reply('GET', '/auth/me', failure(401, 'expired'), status: 401);
    await pumpApp(tester);

    await request(tester, '/auth/me');

    expect(find.byType(SnackBar), findsNothing);
  });

  testWidgets('silentError를 지정한 요청은 안내를 띄우지 않는다', (tester) async {
    backend.reply('GET', '/api/x', failure(409, 'conflict'), status: 409);
    await pumpApp(tester);

    final options = Options(extra: {ErrorInterceptor.silentErrorKey: true});
    await request(tester, '/api/x', options: options);

    expect(find.byType(SnackBar), findsNothing);
  });
}
