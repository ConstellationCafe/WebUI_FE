import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/modules/chatbot/content/data/repository/content_repository.dart';
import 'package:constellation_cafe/feature/modules/chatbot/learning/data/repository/learning_repository.dart';
import 'package:constellation_cafe/feature/modules/chatbot/menu/data/repository/menu_repository.dart';
import 'package:constellation_cafe/feature/modules/chatbot/music/data/repository/music_repository.dart';
import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';

import '../../../support/fake_backend.dart';
import 'support/chatbot_fixtures.dart';

/// 추천 저장소(콘텐츠·메뉴·노래)는 값 컬럼 하나와 추천자 컬럼을 가진 같은 계약이다.
class RecommendCase {
  const RecommendCase(
    this.name,
    this.path,
    this.dbColumn,
    this.column,
    this.create,
  );

  final String name;
  final String path;
  final String dbColumn;
  final String column;
  final RepositoryInterface Function(FakeBackend backend) create;
}

final recommendCases = [
  RecommendCase(
    '놀이 추천',
    '/api/repository/content',
    'cn_value',
    'cnValue',
    (backend) => ContentRepository(dio: backend.dio),
  ),
  RecommendCase(
    '메뉴 추천',
    '/api/repository/menu',
    'mn_value',
    'mnValue',
    (backend) => MenuRepository(dio: backend.dio),
  ),
  RecommendCase(
    '노래 추천',
    '/api/repository/music',
    'video_id',
    'videoId',
    (backend) => MusicRepository(dio: backend.dio),
  ),
];

void main() {
  late FakeBackend backend;

  setUp(() => backend = FakeBackend());
  tearDown(() => backend.close());

  for (final c in recommendCases) {
    group(c.name, () {
      test('목록은 페이지·검색·정렬을 DB 컬럼명으로 보낸다', () async {
        final page = recommendPage(c.dbColumn, c.column);
        backend.reply('GET', '${c.path}/list', ok(page));

        final repository = c.create(backend);
        final result = await repository.findPage(
          page: 1,
          size: 20,
          searchColumn: 'discordId',
          searchValue: '900',
          sortColumn: c.column,
          sortDirection: 'DESC',
        );

        expect(backend.last.queryParameters, {
          'page': 1,
          'size': 20,
          'searchColumn': 'recommender',
          'searchValue': '900',
          'sortColumn': c.column,
          'sortDirection': 'DESC',
        });
        final columns = result.metadata.map((meta) => meta['colName']);
        final dbNames = result.metadata.map((meta) => meta['dbName']);
        expect(columns, [c.column, 'discordId']);
        expect(dbNames, [c.dbColumn, 'recommender']);
        expect(result.items.single.toDisplayJson(), {
          c.column: '추천 값',
          'discordId': '900',
        });
        expect(result.hasNext, isFalse);
      });

      test('저장과 삭제는 화면 컬럼을 API 필드로 바꿔 보낸다', () async {
        backend.reply('POST', '${c.path}/save_all', ok(['저장 완료']));
        backend.reply('POST', '${c.path}/delete_all', ok('삭제 완료'));
        final repository = c.create(backend);
        final rows = [
          {c.column: '새 값', 'discordId': '901'},
        ];

        await repository.saveAll(rows);
        final saved = backend.last.data;
        await repository.deleteAll(rows);

        final expected = [
          {c.column: '새 값', 'recommender': '901'},
        ];
        expect(saved, expected);
        expect(backend.last.data, expected);
      });

      test('실패 응답은 서버 메시지를 담은 예외가 된다', () async {
        backend.reply('GET', '${c.path}/list', failure(403, '권한 없음'));

        await expectLater(
          c.create(backend).findPage(page: 1, size: 20),
          throwsA(predicate((e) => '$e'.contains('권한 없음'))),
        );
      });
    });
  }

  group('가르치기', () {
    test('학습 키·값과 교사 컬럼을 화면 이름으로 바꾼다', () async {
      backend.reply('GET', '/api/repository/learning/list', ok(learningPage()));

      final repository = LearningRepository(dio: backend.dio);
      final result = await repository.findPage(
        page: 1,
        size: 20,
        searchColumn: 'discordId',
        searchValue: '900',
      );

      expect(backend.last.queryParameters['searchColumn'], 'teacher');
      final columns = result.metadata.map((meta) => meta['colName']);
      expect(columns, ['lnKey', 'lnValue', 'discordId']);
      final entity = result.items.single;
      expect(entity.toJson(), {
        'lnKey': '안녕',
        'lnValue': '반가워',
        'teacher': '900',
      });
      expect(entity.toDisplayJson()['discordId'], '900');
      expect(result.hasNext, isTrue);
    });

    test('저장 요청은 discordId를 teacher 필드로 보낸다', () async {
      backend.reply('POST', '/api/repository/learning/save_all', ok([]));

      final repository = LearningRepository(dio: backend.dio);
      await repository.saveAll([
        {'lnKey': '안녕', 'lnValue': '반가워', 'discordId': '900'},
      ]);

      expect(backend.last.data, [
        {'lnKey': '안녕', 'lnValue': '반가워', 'teacher': '900'},
      ]);
    });
  });
}
