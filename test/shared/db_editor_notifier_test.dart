import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/modules/chatbot/learning/domain/entity/learning_entity.dart';
import 'package:constellation_cafe/shared/constants/db_editor_strings.dart';
import 'package:constellation_cafe/shared/domain/pagination/page_result.dart';
import 'package:constellation_cafe/shared/notifier/db_editor/db_editor_notifier.dart';

import '../support/fake_page_repository.dart';

PageResult<LearningEntity> learningPage({bool hasNext = false}) {
  final metadata = [
    {'colName': 'lnKey', 'dbName': 'ln_key', 'isPrimary': 1, 'isNullable': 0},
    {'colName': 'lnValue', 'dbName': 'ln_value', 'isPrimary': 0},
  ];
  return PageResult(
    items: [
      LearningEntity.fromJson(metadata, {'lnKey': '안녕', 'lnValue': '반가워'}),
    ],
    metadata: metadata,
    page: 1,
    size: 20,
    totalElements: 1,
    totalPages: 1,
    hasNext: hasNext,
  );
}

void main() {
  late FakePageRepository<LearningEntity> repository;
  late ProviderContainer container;

  DbEditorNotifier notifier() =>
      container.read(dbEditorProvider(repository).notifier);

  setUp(() {
    repository = FakePageRepository(learningPage());
    container = ProviderContainer();
    container.listen(dbEditorProvider(repository), (_, _) {});
  });

  tearDown(() => container.dispose());

  test('첫 페이지를 불러오면 표와 페이지 상태가 채워진다', () async {
    await notifier().loadInitialPage();

    final state = container.read(dbEditorProvider(repository));
    expect(repository.requestedPages, [1]);
    expect(state.isInitialized, isTrue);
    expect(state.isLoading, isFalse);
    expect(state.columnNames, ['lnKey', 'lnValue']);
    expect(state.countRow, 1);
    expect(state.model.getDisplayValue(0, 0), '안녕');
  });

  test('행을 추가하면 편집 모드가 켜지고 저장 전에는 정렬할 수 없다', () async {
    await notifier().loadInitialPage();

    notifier().addRow();

    expect(container.read(dbEditorProvider(repository)).isEditMode, isTrue);
    expect(notifier().hasUnsavedChanges, isTrue);
    await expectLater(
      notifier().sort('lnKey'),
      throwsA(
        isA<StateError>().having(
          (e) => e.message,
          'message',
          DbEditorStrings.unsavedBeforeSort,
        ),
      ),
    );
  });

  test('셀 입력은 표에 반영되지만 화면 갱신을 알리지 않는다', () async {
    await notifier().loadInitialPage();
    final revision = container.read(dbEditorProvider(repository)).revision;

    notifier().updateCell(1, 0, '또 봐');

    final state = container.read(dbEditorProvider(repository));
    expect(state.model.getDisplayValue(1, 0), '또 봐');
    expect(state.revision, revision);
  });

  test('다음 페이지가 없으면 더 불러오지 않는다', () async {
    await notifier().loadInitialPage();

    await notifier().loadNextPage();

    expect(repository.requestedPages, [1]);
  });
}
