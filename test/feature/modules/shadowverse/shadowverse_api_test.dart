import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:constellation_cafe/core/network/discord_bot/translator.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/api/shadowverse_api.dart';
import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/domain/friendly_match_template.dart';
import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/domain/mode/s1/mode_type_s1.dart';
import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/domain/platform/s1/platform_type_s1.dart';
import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/domain/platform/s2/platform_type_s2.dart';
import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/domain/version/game_version_type.dart';
import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/notifier/friendly_match_notifier.dart';

import '../../../support/fake_translator.dart';

FriendlyMatchTemplate template() => FriendlyMatchTemplate(
  version: 's2',
  mode: '로테이션',
  platform: 'bo3',
  roomNumber: '12345',
  message: '같이 해요',
  sender: '별',
);

void main() {
  group('친선전 전송 계약', () {
    test('템플릿은 check_match_form 요청 형식으로 변환된다', () {
      final model = FriendlyMatchTemplate.toJson(template());

      expect(model.toJson()['dst'], 'ShadowverseAPI');
      expect(model.toJson()['payload']['sub'], 'friendlyMatch');
      expect(model.toJson()['payload']['target_func'], 'check_match_form');
      expect(model.args, [
        'True',
        ['s2', '로테이션', 'bo3', '12345', '같이 해요'],
        '섀버 별자리 Cafe',
        '별',
      ]);
    });

    test('API는 봇 응답의 result 문구를 돌려준다', () async {
      final translator = FakeTranslator((_, _) async {
        return {
          'payload': {'result': '3개 채팅방에 전송했습니다'},
        };
      });
      final args = FriendlyMatchTemplate.toJson(template()).args;

      final result = await ShadowverseAPI(translator).friedlyMatch(args);

      expect(result, '3개 채팅방에 전송했습니다');
      final call = translator.calls.single;
      expect(call.$1, '/ShadowverseAPI/friendlyMatch/check_match_form');
      expect(call.$2, args);
    });

    test('봇 라우터에는 경로를 목적지·모듈·함수로 나눈 JSON을 보낸다', () async {
      late Map<String, dynamic> sent;
      final client = MockClient((request) async {
        sent = jsonDecode(request.body) as Map<String, dynamic>;
        final body = {
          'payload': {'result': 'ok'},
        };
        return http.Response(jsonEncode(body), 200);
      });

      const path = '/ShadowverseAPI/friendlyMatch/check_match_form';
      final translator = APITranslator();

      final result = await http.runWithClient(
        () => translator.request(path, ['a']),
        () => client,
      );

      expect(result['payload']['result'], 'ok');
      expect(sent['src'], 'WebUI');
      expect(sent['dst'], 'ShadowverseAPI');
      expect(sent['payload'], {
        'sub': 'friendlyMatch',
        'target_func': 'check_match_form',
        'args': ['a'],
      });
    });

    test('봇 라우터 오류 응답은 실패 메시지로 바꾼다', () async {
      final client = MockClient((_) async {
        return http.Response.bytes(
          utf8.encode(jsonEncode({'message': '등록되지 않은 명령'})),
          400,
          headers: {'content-type': 'application/json; charset=utf-8'},
        );
      });

      final result = await http.runWithClient(
        () => APITranslator().request('/A/B/c', const []),
        () => client,
      );

      expect(result['status_code'], isFalse);
      expect(result['message'], '등록되지 않은 명령');
    });
  });

  group('친선전 선택지', () {
    test('버전과 모드 문자열을 enum으로 변환한다', () {
      expect(GameVersionType.stringToType('s1'), GameVersionType.S1);
      expect(GameVersionType.stringToType('unknown'), GameVersionType.S2);
      expect(
        FriendlyMatchS1ModeType.stringToType('투픽'),
        FriendlyMatchS1ModeType.two_pick,
      );
      expect(FriendlyMatchS1PlatformType.bo7.typeToString(), 'bo3 1ban');
      expect(FriendlyMatchS2PlatformType.two_decks_bo1.name, 'Bo1/2deck');
    });

    test('보낸 사람은 로그인 사용자 이름이고 버전을 바꾸면 방 정보가 초기화된다', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final user = container.read(currentUserStateProvider.notifier);
      user.update(globalName: '별');
      container.listen(friendlyMatchProvider, (_, _) {});
      final notifier = container.read(friendlyMatchProvider.notifier);

      notifier.update(version: 's1', mode: '투픽', platform: 'bo1');
      notifier.update(roomNumber: '777', message: '구함');
      expect(container.read(friendlyMatchProvider).roomNumber, '777');
      expect(container.read(friendlyMatchProvider).sender, '별');

      notifier.update(version: 's2', mode: '로테이션', platform: 'bo1');
      final state = container.read(friendlyMatchProvider);
      expect(state.roomNumber, isEmpty);
      expect(state.message, isEmpty);
      expect(state.mode, '로테이션');
      expect(state.sender, '별');
    });
  });
}
