import 'package:dio/dio.dart';
import 'package:test/test.dart';

import 'package:constellation_cafe/feature/modules/erp/point/data/api/admin_point_api.dart';
import 'package:constellation_cafe/feature/modules/erp/point/data/dto/request/admin_point_history_request.dart';
import 'package:constellation_cafe/feature/modules/erp/point/data/dto/request/admin_point_members_request.dart';
import 'package:constellation_cafe/feature/modules/erp/point/data/repository/admin_point_repository.dart';

Map<String, dynamic> memberJson({int coin = 1200}) => {
  'discordId': '123',
  'username': '별자리',
  'state': '재적',
  'coin': coin,
};

Map<String, dynamic> paginationJson() => {
  'page': 2,
  'size': 20,
  'totalElements': 21,
  'totalPages': 2,
  'hasNext': false,
};

Map<String, dynamic> detailJson({
  int coin = 1200,
  String at = '2026-09-24T01:02:03',
}) => {
  ...memberJson(coin: coin),
  ...paginationJson(),
  'logs': [
    {'amount': 100, 'at': at, 'description': null},
  ],
};

void main() {
  late Dio dio;
  late AdminPointApi api;
  late AdminPointRepository repository;
  late RequestOptions request;
  late Map<String, dynamic> response;

  setUp(() {
    response = {'success': true, 'response': detailJson()};
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
    api = AdminPointApi(dio: dio);
    repository = AdminPointRepository(api: api);
  });

  tearDown(() => dio.close());

  test('회원 검색 요청과 items 및 페이지 응답을 백엔드 DTO에 맞춘다', () async {
    response['response'] = {
      ...paginationJson(),
      'items': [memberJson()],
    };
    final result = await api.getMembers(
      const AdminPointMembersRequest(page: 2, size: 20, discordId: ' 123 '),
    );
    expect(request.method, 'GET');
    expect(request.path, '${AdminPointApi.path}/members');
    expect(request.queryParameters, {
      'page': 2,
      'size': 20,
      'discordId': '123',
    });
    expect(result.items.single.discordId, '123');
    expect(result.items.single.username, '별자리');
    expect(result.items.single.coin, 1200);
    expect(result.page, 2);
    expect(result.size, 20);
    expect(result.totalElements, 21);
    expect(result.totalPages, 2);
    expect(result.hasNext, isFalse);
  });

  test('빈 검색어는 전송하지 않고 회원 DTO를 도메인으로 변환한다', () async {
    response['response'] = {
      ...paginationJson(),
      'items': [
        {...memberJson(), 'username': null},
      ],
    };
    final result = await repository.getMembers(page: 2, discordId: '   ');
    expect(request.queryParameters, {'page': 2, 'size': 20});
    expect(result.items.single.username, '');
    expect(result.items.single.state, '재적');
    expect(result.page, 2);
    expect(result.totalPages, 2);
  });

  test('평면 회원 상세 응답과 nullable 설명 및 UTC 일시를 파싱한다', () async {
    final result = await api.getMember(
      '123',
      const AdminPointHistoryRequest(page: 2, size: 20),
    );
    expect(request.path, '${AdminPointApi.path}/members/123');
    expect(request.queryParameters, {'page': 2, 'size': 20});
    expect(result.discordId, '123');
    expect(result.username, '별자리');
    expect(result.coin, 1200);
    expect(result.logs.single.description, isNull);
    expect(result.logs.single.at, DateTime.utc(2026, 9, 24, 1, 2, 3));
    expect(result.page, 2);
    expect(result.size, 20);
    expect(result.totalElements, 21);
    expect(result.totalPages, 2);
    expect(result.hasNext, isFalse);
  });

  for (final isDeposit in [true, false]) {
    test('${isDeposit ? '입금' : '출금'} 요청과 갱신된 상세 응답을 변환한다', () async {
      final balance = isDeposit ? 1300 : 1100;
      response['response'] = detailJson(coin: balance);
      final result = await repository.transact(
        discordId: '123',
        isDeposit: isDeposit,
        amount: 100,
        description: ' 정산 ',
      );
      expect(request.method, 'POST');
      expect(request.path, '${AdminPointApi.path}/members/123/transactions');
      expect(request.data, {
        'type': isDeposit ? 'DEPOSIT' : 'WITHDRAW',
        'amount': 100,
        'description': '정산',
      });
      expect(result.member.coin, balance);
      expect(result.member.discordId, '123');
      expect(result.logs.single.amount, 100);
      expect(result.page, 2);
    });
  }

  test('설명이 null인 기존 내역과 시간대가 있는 일시를 변환한다', () async {
    response['response'] = detailJson(at: '2026-09-24T10:02:03+09:00');
    final result = await repository.getMember('123', page: 2);
    expect(result.logs.single.description, '');
    expect(result.logs.single.at, DateTime.utc(2026, 9, 24, 1, 2, 3));
  });

  test('실패 응답을 정상 상세 데이터로 처리하지 않는다', () async {
    response['success'] = false;
    await expectLater(repository.getMember('123'), throwsFormatException);
  });
}
