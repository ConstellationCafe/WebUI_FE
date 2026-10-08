import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/shared/data/dto/response/backend/repository_page_response.dart';
import 'package:constellation_cafe/shared/data/dto/response/bot/bot_command_response.dart';

import '../../support/fake_backend.dart';

void main() {
  group('RepositoryPageResponse', () {
    test('metadata·entities와 페이지 정보를 읽는다', () {
      final response = RepositoryPageResponse.fromJson(
        ok({
          'metadata': [
            {'colName': 'ln_key', 'isPrimary': 1, 'isNullable': 0},
          ],
          'entities': [
            {'lnKey': '안녕'},
          ],
          'page': 2,
          'size': 20,
          'totalElements': 21,
          'totalPages': 2,
          'hasNext': false,
        }),
      );

      expect(response.metadata.single['colName'], 'ln_key');
      expect(response.entities.single['lnKey'], '안녕');
      expect(response.page, 2);
      expect(response.totalElements, 21);
      expect(response.hasNext, isFalse);
    });

    test('page·size가 없으면 요청한 값을 쓰고 목록이 없으면 비운다', () {
      final response = RepositoryPageResponse.fromJson(ok(<String, dynamic>{}));

      final page = response.toPageResult<String>(
        items: const [],
        columns: const [],
        requestedPage: 3,
        requestedSize: 20,
      );

      expect(response.metadata, isEmpty);
      expect(response.entities, isEmpty);
      expect(page.page, 3);
      expect(page.size, 20);
      expect(page.totalPages, 0);
      expect(page.hasNext, isFalse);
    });

    test('실패 응답은 서버 메시지를 담은 예외가 된다', () {
      expect(
        () => RepositoryPageResponse.fromJson(failure(403, '권한 없음')),
        throwsA(predicate((e) => '$e'.contains('권한 없음'))),
      );
    });
  });

  group('BotCommandResponse', () {
    test('성공 응답은 payload.result를 결과로 읽는다', () {
      final response = BotCommandResponse.fromJson({
        'payload': {'result': '완료'},
      });

      expect(response.result, '완료');
      expect(response.resultMessage, '완료');
      expect(response.errorMessage, isNull);
    });

    test('봇 router 실패 응답은 오류 문구를 담고 결과가 없다', () {
      final response = BotCommandResponse.fromJson({
        'status_code': false,
        'message': '요청 시간이 초과되었습니다.',
      });

      expect(response.result, isNull);
      expect(response.errorMessage, '요청 시간이 초과되었습니다.');
      expect(() => response.resultMessage, throwsA(isA<TypeError>()));
    });
  });
}
