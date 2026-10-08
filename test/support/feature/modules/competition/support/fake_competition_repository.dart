import 'package:constellation_cafe/feature/modules/competition/data/api/competition_api.dart';
import 'package:constellation_cafe/feature/modules/competition/data/repository/competition_repository.dart';
import 'package:constellation_cafe/feature/modules/competition/domain/model/competition_board.dart';
import 'package:constellation_cafe/feature/modules/competition/domain/model/competition_draft.dart';
import 'package:constellation_cafe/feature/modules/competition/domain/model/competition_post_result.dart';
import 'package:constellation_cafe/feature/modules/competition/domain/model/competition_winner.dart';

/// widget 테스트용 대회 repository. 네트워크 없이 등록한 값을 돌려준다.
class FakeCompetitionRepository implements CompetitionRepository {
  bool manager = false;
  int permissionCalls = 0;
  Object? permissionError;
  Future<bool>? pendingPermission;

  @override
  CompetitionApi get api => throw UnimplementedError();

  @override
  Future<bool> isManager() async {
    permissionCalls++;
    final error = permissionError;
    if (error != null) throw error;
    return pendingPermission ?? manager;
  }

  List<CompetitionBoard> boards = const [
    CompetitionBoard(
      key: 'inner_board',
      channelId: '123456',
      name: '대회 게시판',
      joinable: true,
    ),
  ];
  int postCalls = 0;

  @override
  Future<List<CompetitionBoard>> getBoards() async => boards;

  @override
  Future<String> preview(CompetitionDraft draft) async => '';

  @override
  Future<CompetitionPostResult> post({
    required String requestId,
    required String boardKey,
    required CompetitionDraft draft,
  }) async {
    postCalls++;
    return CompetitionPostResult(
      boardKey: boardKey,
      messageId: '1',
      messageUrl: null,
      content: draft.title,
    );
  }

  @override
  Future<CompetitionWinner> grantWinner(CompetitionWinnerDraft draft) =>
      throw UnimplementedError();

  @override
  Future<CompetitionWinnerPage> getWinners({required int page}) async =>
      const CompetitionWinnerPage(items: [], page: 1, totalPages: 0);
}
