import 'package:dio/dio.dart';
import 'package:test/test.dart';

import 'package:constellation_cafe/core/network/interceptors/error_interceptor.dart';
import 'package:constellation_cafe/feature/modules/competition/data/api/competition_api.dart';
import 'package:constellation_cafe/feature/modules/competition/data/repository/competition_repository.dart';
import 'package:constellation_cafe/feature/modules/competition/domain/model/competition_draft.dart';
import 'package:constellation_cafe/feature/modules/competition/domain/model/competition_failure.dart';
import 'package:constellation_cafe/feature/modules/competition/domain/model/competition_winner.dart';
import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/domain/version/game_version_type.dart';

void main() {
  late Dio dio;
  late RequestOptions request;
  late Object? response;
  int status = 200;

  setUp(() {
    status = 200;
    response = {'success': true, 'response': <String, dynamic>{}};
    dio = Dio(BaseOptions(baseUrl: 'https://example.invalid'));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          request = options;
          final result = Response(
            requestOptions: options,
            statusCode: status,
            data: response,
          );
          if (status >= 400) {
            handler.reject(
              DioException.badResponse(
                statusCode: status,
                requestOptions: options,
                response: result,
              ),
            );
            return;
          }
          handler.resolve(result);
        },
      ),
    );
  });

  tearDown(() => dio.close());

  CompetitionRepository repository() =>
      CompetitionRepository(api: CompetitionApi(dio: dio));

  // 브라우저 현지 시각. 서버에는 UTC로 보내야 한다.
  final draft = CompetitionDraft(
    title: ' 미니미 Bo1 대회 ',
    participantWay: 'https://tonamel.com/competition/XtzgX',
    format: '싱글 엘리미네이션 Bo1',
    registrationStart: DateTime.utc(2026, 9, 29, 14),
    registrationEnd: DateTime.utc(2026, 10, 2, 12, 30),
    eventStart: DateTime.utc(2026, 10, 2, 13),
    prizes: const [CompetitionPrize(rank: '1등', content: '치킨 기프티콘')],
    extraFields: const [CompetitionExtraField(key: '대회 규칙', value: '덱 공개 없음')],
  );

  test('대회 권한은 본인 권한 경로에서 받는다', () async {
    response = {
      'success': true,
      'response': {'manager': true},
    };

    final isManager = await repository().isManager();

    expect(request.method, 'GET');
    expect(request.uri.path, '/api/competitions/me/permissions');
    expect(request.extra[ErrorInterceptor.silentErrorKey], isTrue);
    expect(isManager, isTrue);
  });

  test('게시판 목록은 대회 경로에서 받아 도메인 모델로 바꾼다', () async {
    response = {
      'success': true,
      'response': [
        {
          'key': 'inner_board',
          'channelId': '111',
          'name': '내부대회게시판',
          'joinable': true,
        },
        {
          'key': 'outer_board',
          'channelId': '222',
          'name': 'outer_board',
          'joinable': false,
        },
      ],
    };

    final boards = await repository().getBoards();

    expect(request.method, 'GET');
    expect(request.uri.path, '/api/competitions/boards');
    expect(request.extra[ErrorInterceptor.silentErrorKey], isTrue);
    expect(boards.map((board) => board.key), ['inner_board', 'outer_board']);
    expect(boards.first.name, '내부대회게시판');
    expect(boards.first.joinable, isTrue);
    expect(boards.last.joinable, isFalse);
  });

  test('미리보기는 입력을 UTC 시각으로 보내고 서버가 조립한 글을 돌려받는다', () async {
    response = {
      'success': true,
      'response': {'content': '"미니미 Bo1 대회"가 개최되었습니다 !'},
    };

    final content = await repository().preview(draft);

    expect(request.method, 'POST');
    expect(request.uri.path, '/api/competitions/notices/preview');
    expect(request.data, {
      'title': '미니미 Bo1 대회',
      'participantWay': 'https://tonamel.com/competition/XtzgX',
      'format': '싱글 엘리미네이션 Bo1',
      'registrationStart': '2026-09-29T14:00:00.000Z',
      'registrationEnd': '2026-10-02T12:30:00.000Z',
      'eventStart': '2026-10-02T13:00:00.000Z',
      'prizes': [
        {'rank': '1등', 'content': '치킨 기프티콘'},
      ],
      'extraFields': [
        {'key': '대회 규칙', 'value': '덱 공개 없음'},
      ],
    });
    expect(content, '"미니미 Bo1 대회"가 개최되었습니다 !');
  });

  test('게시는 요청 ID와 게시판 키를 보내고 공지글 주소를 돌려받는다', () async {
    response = {
      'success': true,
      'response': {
        'boardKey': 'inner_board',
        'channelId': '111',
        'messageId': '999',
        'messageUrl': 'https://discord.com/channels/1/111/999',
        'content': '공지',
      },
    };

    final result = await repository().post(
      requestId: 'req-1',
      boardKey: 'inner_board',
      draft: draft,
    );

    expect(request.method, 'POST');
    expect(request.uri.path, '/api/competitions/notices');
    final body = request.data as Map<String, dynamic>;
    expect(body['requestId'], 'req-1');
    expect(body['boardKey'], 'inner_board');
    expect((body['notice'] as Map)['eventStart'], '2026-10-02T13:00:00.000Z');
    expect(result.messageId, '999');
    expect(result.messageUrl, 'https://discord.com/channels/1/111/999');
  });

  const failures = {
    400: CompetitionFailureReason.invalid,
    404: CompetitionFailureReason.notConfigured,
    502: CompetitionFailureReason.discord,
    503: CompetitionFailureReason.unknown,
  };
  for (final entry in failures.entries) {
    test('게시 실패 ${entry.key}는 ${entry.value}로 바꾸고 서버 안내 문구를 담는다', () async {
      status = entry.key;
      response = {
        'success': false,
        'response': null,
        'error': {'message': '서버 안내', 'status': entry.key},
      };

      CompetitionException? failure;
      try {
        await repository().post(
          requestId: 'req-2',
          boardKey: 'inner_board',
          draft: draft,
        );
      } on CompetitionException catch (error) {
        failure = error;
      }

      expect(failure?.reason, entry.value);
      expect(failure?.message, '서버 안내');
    });
  }

  final winnerDraft = CompetitionWinnerDraft(
    competitionName: ' 미니미 Bo1 대회 ',
    version: GameVersionType.s2,
    winnerDiscordId: '123',
    acquisition: DateTime(2026, 9, 3),
  );

  test('우승 칭호 부여는 GameVersionType 값과 날짜만 보낸다', () async {
    response = {
      'success': true,
      'response': {
        'competitionName': '미니미 Bo1 대회',
        'version': 's2',
        'winnerDiscordId': '123',
        'winnerName': '별',
        'acquisition': '2026-09-03',
      },
    };

    final winner = await repository().grantWinner(winnerDraft);

    expect(request.method, 'POST');
    expect(request.uri.path, '/api/competitions/winners');
    expect(request.data, {
      'competitionName': '미니미 Bo1 대회',
      'version': 's2',
      'winnerDiscordId': '123',
      'acquisition': '2026-09-03',
    });
    expect(winner.version, GameVersionType.s2);
    expect(winner.winnerName, '별');
    expect(winner.acquisition, DateTime(2026, 9, 3));
  });

  test('우승 칭호 이력은 페이지 번호로 조회한다', () async {
    response = {
      'success': true,
      'response': {
        'items': [
          {
            'competitionName': '대회 A',
            'version': 's2',
            'winnerDiscordId': '123',
            'winnerName': null,
            'acquisition': '2026-09-30',
          },
        ],
        'page': 2,
        'size': 20,
        'totalElements': 21,
        'totalPages': 2,
        'hasNext': false,
      },
    };

    final page = await repository().getWinners(page: 2);

    expect(request.method, 'GET');
    expect(request.uri.path, '/api/competitions/winners');
    expect(request.uri.queryParameters, {'page': '2'});
    expect(page.page, 2);
    expect(page.totalPages, 2);
    expect(page.items.single.winnerName, isNull);
  });

  const winnerFailures = {
    400: CompetitionWinnerFailure.invalid,
    404: CompetitionWinnerFailure.notMember,
    409: CompetitionWinnerFailure.conflict,
    503: CompetitionWinnerFailure.unknown,
  };
  for (final entry in winnerFailures.entries) {
    test('칭호 부여 실패 ${entry.key}는 ${entry.value}로 바꾼다', () async {
      status = entry.key;
      response = {
        'success': false,
        'response': null,
        'error': {'message': '서버 안내', 'status': entry.key},
      };

      CompetitionWinnerException? failure;
      try {
        await repository().grantWinner(winnerDraft);
      } on CompetitionWinnerException catch (error) {
        failure = error;
      }

      expect(failure?.reason, entry.value);
      expect(failure?.message, '서버 안내');
    });
  }

  test('실패 응답을 정상 목록으로 처리하지 않는다', () async {
    response = {'success': false, 'response': null};
    await expectLater(repository().getBoards(), throwsFormatException);
  });
}
