import 'package:dio/dio.dart';
import 'package:test/test.dart';

import 'package:constellation_cafe/feature/modules/erp/penalty/data/api/penalty_api.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/data/dto/request/penalty_create_request.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/data/repository/penalty_repository.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/domain/new_penalty_request_id.dart';

Map<String, dynamic> historyItem({String status = 'ACTIVE'}) => {
  'penaltyId': 42,
  'channelId': '999',
  'channelName': null,
  'targetDiscordId': '123',
  'targetUsername': '별',
  'reason': '도배',
  'score': 1,
  'issuerDiscordId': '900',
  'occurredAt': '2026-09-28T00:30:00Z',
  'createdAt': '2026-09-28T00:31:00Z',
  'status': status,
  'targetCumulativeScore30d': status == 'ACTIVE' ? 2 : 1,
  'canceledByDiscordId': status == 'ACTIVE' ? null : '901',
  'canceledAt': status == 'ACTIVE' ? null : '2026-09-28T00:40:00Z',
  'cancellationReason': status == 'ACTIVE' ? null : '잘못 부여',
};

Map<String, dynamic> page(List<Map<String, dynamic>> items) => {
  'items': items,
  'page': 1,
  'size': 20,
  'totalElements': items.length,
  'totalPages': items.isEmpty ? 0 : 1,
  'hasNext': false,
};

Map<String, dynamic> detail({String status = 'ACTIVE'}) => {
  'discordId': '123',
  'username': '별',
  'state': '재적',
  'cumulativeScore30d': status == 'ACTIVE' ? 2 : 1,
  'history': page([historyItem(status: status)]),
};

void main() {
  late Dio dio;
  late RequestOptions request;
  late Map<String, dynamic> response;
  late PenaltyRepository repository;

  setUp(() {
    response = {'success': true, 'response': detail()};
    dio = Dio(BaseOptions(baseUrl: 'https://example.invalid'));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          request = options;
          handler.resolve(
            Response(requestOptions: options, statusCode: 200, data: response),
          );
        },
      ),
    );
    repository = PenaltyRepository(api: PenaltyApi(dio: dio));
  });

  tearDown(() => dio.close());

  test('이력 필터와 조회 시점 누적 점수를 계약대로 읽는다', () async {
    response['response'] = page([historyItem()]);
    final result = await repository.history(
      channelId: '999',
      discordId: '123',
      sort: 'OCCURRED_AT_ASC',
    );
    expect(request.method, 'GET');
    expect(request.path, PenaltyApi.adminPath);
    expect(request.queryParameters, {
      'channelId': '999',
      'discordId': '123',
      'sort': 'OCCURRED_AT_ASC',
      'page': 1,
      'size': 20,
    });
    expect(result.items.single.targetCumulativeScore30d, 2);
    expect(result.items.single.channelName, isNull);
    expect(result.items.single.occurredAt, DateTime.utc(2026, 9, 28, 0, 30));
    expect(result.totalElements, 1);
  });

  test('순위와 회원 상세에서 숫자·시간·페이지를 변환한다', () async {
    response['response'] = page([
      {
        'discordId': '123',
        'username': '별',
        'cumulativeScore30d': 2,
        'penaltyCount30d': 2,
        'lastOccurredAt': '2026-09-28T00:30:00Z',
      },
    ]);
    final ranked = await repository.members(discordId: '12');
    expect(request.path, '${PenaltyApi.adminPath}/members');
    expect(request.queryParameters['discordId'], '12');
    expect(ranked.items.single.penaltyCount30d, 2);
    expect(ranked.items.single.lastOccurredAt.isUtc, isTrue);

    response['response'] = detail(status: 'CANCELED');
    final member = await repository.member('123', page: 1);
    expect(request.path, '${PenaltyApi.adminPath}/members/123');
    expect(member.history.items.single.isCanceled, isTrue);
    expect(member.history.items.single.cancellationReason, '잘못 부여');
    expect(member.cumulativeScore30d, 1);
  });

  test('부여·취소·본인 조회 경로와 요청 본문은 botId나 sk를 보내지 않는다', () async {
    final id = newPenaltyRequestId();
    expect(
      RegExp(
        r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
      ).hasMatch(id),
      isTrue,
    );
    await repository.award(
      PenaltyCreateRequest(
        requestId: id,
        targetDiscordId: '123',
        channelId: '999',
        reason: ' 도배 ',
        occurredAt: DateTime.parse('2026-09-28T09:30:00+09:00'),
      ),
    );
    expect(request.method, 'POST');
    expect(request.data, {
      'requestId': id,
      'targetDiscordId': '123',
      'channelId': '999',
      'reason': '도배',
      'score': 1,
      'occurredAt': '2026-09-28T00:30:00.000Z',
    });
    expect(
      (request.data as Map<String, dynamic>).containsKey('botId'),
      isFalse,
    );
    expect((request.data as Map<String, dynamic>).containsKey('sk'), isFalse);

    response['response'] = detail(status: 'CANCELED');
    await repository.cancel(42, ' 오입력 ');
    expect(request.method, 'PATCH');
    expect(request.path, '${PenaltyApi.adminPath}/42/cancel');
    expect(request.data, {'reason': '오입력'});

    await repository.mine();
    expect(request.path, PenaltyApi.myPath);
    expect(request.queryParameters, {'page': 1, 'size': 20});
  });

  test('공통 응답 래퍼가 실패하면 성공으로 해석하지 않는다', () async {
    response['success'] = false;
    await expectLater(repository.mine(), throwsFormatException);
  });
}
