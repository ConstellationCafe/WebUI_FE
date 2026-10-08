import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/core/network/interceptors/auth_interceptor.dart';

import '../../support/fake_backend.dart';

void main() {
  late FakeBackend backend;

  setUp(() {
    backend = FakeBackend();
    backend.dio.interceptors.add(AuthInterceptor(backend.dio));
  });

  tearDown(() => backend.close());

  group('AuthInterceptor', () {
    test('401이면 토큰을 한 번 갱신하고 원래 요청을 다시 보낸다', () async {
      backend.reply('GET', '/api/me', ok('retried'));
      backend.reply(
        'GET',
        '/api/me',
        failure(401, 'expired'),
        status: 401,
        once: true,
      );
      backend.reply('POST', '/auth/refresh', ok(null));

      final response = await backend.dio.get('/api/me');

      expect(response.data['response'], 'retried');
      expect(backend.calls, [
        'GET /api/me',
        'POST /auth/refresh',
        'GET /api/me',
      ]);
      expect(backend.last.extra['authRetry'], isTrue);
    });

    test('403은 권한 거부이므로 갱신 없이 그대로 실패한다', () async {
      backend.reply('GET', '/api/me', failure(403, 'denied'), status: 403);

      DioException? error;
      try {
        await backend.dio.get('/api/me');
      } on DioException catch (e) {
        error = e;
      }

      expect(error?.response?.statusCode, 403);
      expect(backend.calls, ['GET /api/me']);
    });

    test('갱신에 실패하면 원래 401 오류를 전달하고 반복하지 않는다', () async {
      backend.reply('GET', '/api/me', failure(401, 'expired'), status: 401);
      backend.reply('POST', '/auth/refresh', failure(401, 'no'), status: 401);

      await expectLater(
        backend.dio.get('/api/me'),
        throwsA(isA<DioException>()),
      );
      expect(backend.calls, ['GET /api/me', 'POST /auth/refresh']);
    });
  });
}
