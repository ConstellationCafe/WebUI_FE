import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/profile/data/api/membership_api.dart';
import 'package:constellation_cafe/feature/profile/data/dto/response/membership_card_response.dart';
import 'package:constellation_cafe/feature/profile/data/repository/point_repository.dart';
import 'package:constellation_cafe/feature/profile/domain/model/membership.dart';
import 'package:constellation_cafe/feature/profile/notifier/membership_notifier.dart';

import 'package:constellation_cafe/test/support/fake_backend.dart';
import 'package:constellation_cafe/test/support/fake_translator.dart';
import 'package:constellation_cafe/test/support/feature/profile/support/membership_fixtures.dart';

void main() {
  group('MembershipAPI', () {
    test('회원증 조회는 Discord ID로 create_card를 호출한다', () async {
      final translator = FakeTranslator((_, _) async => cardPayload());

      final data = await MembershipAPI(translator).createCard(['123']);

      expect(translator.calls.single.$1, createCardPath);
      expect(translator.calls.single.$2, ['123']);
      expect(data.fields, hasLength(9));
    });

    test('회원증 응답은 정해진 순서의 필드를 도메인 모델로 옮긴다', () {
      final membership = MembershipCardResponse.fromJson(
        cardPayload(),
      ).toDomain(avatar: 'avatar');

      expect(membership.username, '별');
      expect(membership.uid1, '111111111');
      expect(membership.uid2, '');
      expect(membership.role, '운영진');
      expect(membership.coin, '1200');
      expect(membership.s1Data, '2025 시즌 우승');
      expect(membership.guild, '은하수');
      expect(membership.joinAt, '2026-01-01');
      expect(membership.avatar, 'avatar');
    });

    test('UID 길이로 게임 버전을 고른다', () {
      expect(Membership.gameVersionOfUid('123456789'), 's1');
      expect(Membership.gameVersionOfUid('1234567890'), 's2');
    });

    test('UID와 길드 수정은 봇 응답 메시지를 반환한다', () async {
      final translator = FakeTranslator();
      final api = MembershipAPI(translator);

      expect(await api.updateUID(['123', 's1', '123456789', '별']), 'ok');
      expect(await api.updateGuild(['123', 's2', '길드', '별']), 'ok');
      final paths = translator.calls.map((call) => call.$1);
      expect(paths, [
        '/ConstellationAPI/MembershipAPI/update_uid',
        '/ConstellationAPI/MembershipAPI/update_guild',
      ]);
    });
  });

  group('PointRepository', () {
    late FakeBackend backend;

    setUp(() => backend = FakeBackend());
    tearDown(() => backend.close());

    test('포인트 내역을 페이지 단위로 조회하고 컬럼명을 화면용으로 바꾼다', () async {
      backend.reply(
        'GET',
        '/api/repository/membership/point_log',
        ok(pointPage()),
      );
      final repository = PointRepository(dio: backend.dio);

      final page = await repository.findPage(page: 2, size: 20);

      final columns = page.metadata.map((meta) => meta['colName']);
      expect(backend.last.queryParameters, {'page': 2, 'size': 20});
      expect(columns, ['변동 금액', '변동 일자', '변동 내용']);
      expect(page.items.single.amount, '500');
      expect(page.items.single.toJson()['변동 내용'], '출석 보상');
      expect(page.hasNext, isTrue);
      expect(page.totalElements, 21);
    });

    test('실패 응답은 서버 메시지를 담은 예외가 된다', () async {
      backend.reply(
        'GET',
        '/api/repository/membership/point_log',
        failure(401, '로그인이 필요합니다'),
      );

      await expectLater(
        PointRepository(dio: backend.dio).findPage(page: 1, size: 20),
        throwsA(predicate((e) => '$e'.contains('로그인이 필요합니다'))),
      );
    });
  });

  group('MembershipNotifier', () {
    late FakeTranslator translator;
    late ProviderContainer container;
    late MembershipNotifier notifier;

    setUp(() async {
      translator = FakeTranslator((path, _) async {
        if (path == createCardPath) return cardPayload();
        return {
          'payload': {'result': '$path 완료'},
        };
      });
      container = ProviderContainer(
        overrides: [
          membershipApiProvider.overrideWithValue(MembershipAPI(translator)),
        ],
      );
      final user = container.read(currentUserStateProvider.notifier);
      user.update(userId: '123', globalName: '별', avatarUrl: 'avatar');
      notifier = container.read(membershipProvider.notifier);
      await notifier.initialize();
    });

    tearDown(() => container.dispose());

    test('회원증 응답을 순서대로 상태에 담고 아바타를 붙인다', () {
      final state = container.read(membershipProvider);

      expect(state.isLoading, isFalse);
      expect(state.username, '별');
      expect(state.uid1, '111111111');
      expect(state.coin, '1200');
      expect(state.guild, '은하수');
      expect(state.avatar, 'avatar');
    });

    test('다시 초기화해도 회원증을 한 번만 조회한다', () async {
      await notifier.initialize();

      final cards = translator.calls.where((call) => call.$1 == createCardPath);
      expect(cards, hasLength(1));
    });

    test('바뀐 값만 저장하고 UID 길이로 시즌을 구분한다', () async {
      notifier.update(uid1: '222222222', uid2: '3333333333');

      final results = await notifier.saveIfChanged();

      final saved = translator.calls.skip(1).toList();
      expect(saved.map((call) => call.$2), [
        ['123', 's1', '222222222', '별'],
        ['123', 's2', '3333333333', '별'],
      ]);
      expect(results, hasLength(2));
      expect(await notifier.saveIfChanged(), isEmpty, reason: '이미 저장된 값');
    });

    test('입력을 비우면 처음 값으로 되돌리고 저장하지 않는다', () async {
      notifier.update(guild: '새 길드');
      notifier.update(guild: '');

      expect(container.read(membershipProvider).guild, '은하수');
      expect(await notifier.saveIfChanged(), isEmpty);
    });
  });
}
