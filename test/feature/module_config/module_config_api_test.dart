import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/core/network/interceptors/error_interceptor.dart';
import 'package:constellation_cafe/feature/module_config/data/api/module_config_api.dart';
import 'package:constellation_cafe/feature/module_config/data/repository/module_config_repository.dart';

import '../../support/fake_backend.dart';

void main() {
  late FakeBackend backend;
  late ModuleConfigRepository repository;

  setUp(() {
    backend = FakeBackend();
    repository = ModuleConfigRepository(api: ModuleConfigApi(dio: backend.dio));
  });
  tearDown(() => backend.close());

  test('메뉴용 ModuleConfig DTO를 변환하며 요청에 botId를 넣지 않는다', () async {
    backend.reply(
      'GET',
      '/api/me/module-configs',
      ok([
        {'moduleId': 'chatbot', 'addOns': []},
        {'moduleId': 'shadowverse', 'addOns': []},
        {
          'moduleId': 'network_operations',
          'addOns': ['academy', 'competition'],
        },
      ]),
    );

    final modules = await repository.getAvailability();

    expect(modules.chatbot, isTrue);
    expect(modules.shadowverse, isTrue);
    expect(modules.academy, isTrue);
    expect(modules.competition, isTrue);
    expect(backend.calls, ['GET /api/me/module-configs']);
    expect(backend.last.queryParameters, isEmpty);
    expect(backend.last.data, isNull);
    expect(backend.last.extra[ErrorInterceptor.silentErrorKey], isTrue);
  });

  test('설정이 없는 방은 모든 모듈 메뉴를 비활성화한다', () async {
    backend.reply('GET', '/api/me/module-configs', ok([]));
    expect((await repository.getAvailability()).isEmpty, isTrue);
  });

  test('network_operations 이외 모듈에 적힌 addOn은 사용하지 않는다', () async {
    backend.reply(
      'GET',
      '/api/me/module-configs',
      ok([
        {
          'moduleId': 'chatbot',
          'addOns': ['academy', 'competition'],
        },
        {
          'moduleId': 'unknown',
          'addOns': ['academy', 'competition'],
        },
      ]),
    );
    final modules = await repository.getAvailability();
    expect(modules.chatbot, isTrue);
    expect(modules.shadowverse, isFalse);
    expect(modules.academy, isFalse);
    expect(modules.competition, isFalse);
  });

  test('network_operations의 부가 기능을 각각 구분한다', () async {
    for (final addOn in ['academy', 'competition']) {
      backend.reply(
        'GET',
        '/api/me/module-configs',
        ok([
          {
            'moduleId': 'network_operations',
            'addOns': [addOn],
          },
        ]),
      );
      final modules = await repository.getAvailability();
      expect(modules.academy, addOn == 'academy');
      expect(modules.competition, addOn == 'competition');
    }
  });

  test('불완전한 계약을 활성 메뉴로 해석하지 않는다', () async {
    for (final body in [
      ok(null),
      ok({}),
      ok([
        {'moduleId': 'network_operations'},
      ]),
      ok([
        {'moduleId': null, 'addOns': []},
      ]),
      ok([
        {'moduleId': 'network_operations', 'addOns': null},
      ]),
      failure(500, 'failed'),
    ]) {
      backend.reply('GET', '/api/me/module-configs', body);
      await expectLater(repository.getAvailability(), throwsA(anything));
    }
  });

  test('HTTP 조회 실패를 상위 상태에 전달한다', () async {
    backend.reply(
      'GET',
      '/api/me/module-configs',
      failure(503, 'failed'),
      status: 503,
    );
    await expectLater(repository.getAvailability(), throwsA(anything));
  });
}
