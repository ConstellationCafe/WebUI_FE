import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/module_config/data/repository/module_config_repository_provider.dart';
import 'package:constellation_cafe/feature/module_config/domain/model/module_availability.dart';
import 'package:constellation_cafe/feature/module_config/notifier/module_config_notifier.dart';
import 'package:constellation_cafe/feature/modules/academy/data/api/academy_api.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/academy_permission.dart';
import 'package:constellation_cafe/feature/modules/academy/notifier/permission_notifier/academy_permission_notifier.dart';
import 'package:constellation_cafe/feature/modules/competition/data/repository/competition_repository_provider.dart';
import 'package:constellation_cafe/feature/modules/competition/notifier/competition_permission_notifier.dart';

import '../../support/fake_academy_api.dart';
import '../../support/fake_module_config_repository.dart';
import '../modules/competition/support/fake_competition_repository.dart';

void main() {
  late FakeModuleConfigRepository repository;
  late FakeAcademyApi academy;
  late FakeCompetitionRepository competition;
  late ProviderContainer container;
  late ModuleConfigNotifier notifier;

  setUp(() {
    repository = FakeModuleConfigRepository();
    academy = FakeAcademyApi();
    competition = FakeCompetitionRepository()..manager = true;
    container = ProviderContainer(
      overrides: [
        moduleConfigRepositoryProvider.overrideWithValue(repository),
        academyApiProvider.overrideWithValue(academy),
        competitionRepositoryProvider.overrideWithValue(competition),
      ],
    );
    notifier = container.read(moduleConfigProvider.notifier);
  });
  tearDown(() => container.dispose());

  test('모듈 설정 응답 전에는 권한 API를 호출하지 않는다', () async {
    final pending = Completer<ModuleAvailability>();
    repository.replies.add(pending.future);
    final load = notifier.load();
    expect(container.read(moduleConfigProvider).isLoading, isTrue);
    expect(academy.permissionCalls, 0);
    expect(competition.permissionCalls, 0);
    pending.complete(
      const ModuleAvailability(academy: true, competition: true),
    );
    await load;
    expect(academy.permissionCalls, 1);
    expect(competition.permissionCalls, 1);
  });

  test('비활성 모듈의 권한은 조회하지 않고 활성 부가 기능만 조회한다', () async {
    repository.availability = const ModuleAvailability(chatbot: true);
    await notifier.load();
    expect(academy.permissionCalls, 0);
    expect(competition.permissionCalls, 0);

    repository.availability = const ModuleAvailability(competition: true);
    await notifier.load();
    expect(academy.permissionCalls, 0);
    expect(competition.permissionCalls, 1);

    repository.availability = const ModuleAvailability(academy: true);
    await notifier.load();
    expect(academy.permissionCalls, 1);
    expect(competition.permissionCalls, 1);
    expect(container.read(competitionPermissionProvider).isManager, isFalse);
  });

  test('모듈 조회 실패는 이전 메뉴와 권한을 지우고 재시도를 허용한다', () async {
    await notifier.load();
    repository.error = StateError('offline');
    await notifier.load();
    expect(container.read(moduleConfigProvider).hasError, isTrue);
    expect(container.read(moduleConfigProvider).value, isNull);
    expect(container.read(academyPermissionProvider).isInitialized, isFalse);
    expect(container.read(competitionPermissionProvider).isManager, isFalse);
    expect(academy.permissionCalls, 1);
    expect(competition.permissionCalls, 1);

    repository.error = null;
    await notifier.load();
    expect(container.read(moduleConfigProvider).hasValue, isTrue);
    expect(competition.permissionCalls, 2);
  });

  test('한 권한 조회가 실패해도 다른 활성 메뉴의 권한을 유지한다', () async {
    academy.permissionError = StateError('offline');
    await notifier.load();
    expect(container.read(moduleConfigProvider).hasValue, isTrue);
    expect(container.read(academyPermissionProvider).isInitialized, isFalse);
    expect(container.read(competitionPermissionProvider).isManager, isTrue);
  });

  test('새 채팅방보다 늦게 도착한 이전 모듈 응답을 버린다', () async {
    final previous = Completer<ModuleAvailability>();
    repository.replies.add(previous.future);
    final oldLoad = notifier.load();
    repository.availability = const ModuleAvailability(shadowverse: true);
    await notifier.load();
    previous.complete(
      const ModuleAvailability(academy: true, competition: true),
    );
    await oldLoad;
    final modules = container.read(moduleConfigProvider).requireValue;
    expect(modules.shadowverse, isTrue);
    expect(modules.academy, isFalse);
    expect(modules.competition, isFalse);
    expect(academy.permissionCalls, 0);
    expect(competition.permissionCalls, 0);
  });

  test('채팅방 변경 후 이전 아카데미·대회 권한 응답이 상태를 덮지 않는다', () async {
    final oldAcademy = Completer<AcademyPermission>();
    final oldCompetition = Completer<bool>();
    academy.pendingPermission = oldAcademy.future;
    competition.pendingPermission = oldCompetition.future;
    final load = notifier.load();
    // 설정이 반영되어 권한 요청을 시작할 때까지 microtask를 처리한다.
    await Future<void>.delayed(Duration.zero);
    expect(academy.permissionCalls, 1);
    expect(competition.permissionCalls, 1);
    notifier.clear();
    academy.pendingPermission = null;
    competition.pendingPermission = null;
    repository.availability = const ModuleAvailability(chatbot: true);
    await notifier.load();

    oldAcademy.complete(const AcademyPermission(admin: true, academies: []));
    oldCompetition.complete(true);
    await load;
    expect(container.read(moduleConfigProvider).requireValue.chatbot, isTrue);
    expect(container.read(academyPermissionProvider).permission, isNull);
    expect(container.read(competitionPermissionProvider).isManager, isFalse);
  });

  test('로그아웃 뒤 진행 중 모듈 응답으로 권한 조회를 시작하지 않는다', () async {
    final pending = Completer<ModuleAvailability>();
    repository.replies.add(pending.future);
    final load = notifier.load();
    notifier.clear();
    pending.complete(
      const ModuleAvailability(academy: true, competition: true),
    );
    await load;
    expect(container.read(moduleConfigProvider).requireValue.isEmpty, isTrue);
    expect(academy.permissionCalls, 0);
    expect(competition.permissionCalls, 0);
  });
}
