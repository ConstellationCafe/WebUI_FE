import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/model/competition_board.dart';
import '../domain/model/competition_failure.dart';

part 'admin_competition_state.freezed.dart';

/// 대회 개최 화면 상태. 입력값은 폼 위젯이 소유하고,
/// 여기에는 게시판 목록·선택, 미리보기, 게시 진행 상태만 둔다.
@freezed
abstract class AdminCompetitionState with _$AdminCompetitionState {
  const factory AdminCompetitionState({
    @Default([]) List<CompetitionBoard> boards,
    String? selectedBoardKey,
    @Default(false) bool isLoadingBoards,
    @Default(false) bool hasBoardsError,

    /// 서버가 조립한 실제 게시글. 필수 입력이 비어 있거나 검증에 실패하면 null
    String? preview,

    /// 미리보기 실패 이유. 입력 오류(invalid)면 서버 안내 문구를 함께 담는다.
    CompetitionException? previewFailure,
    @Default(false) bool isPreviewing,
    @Default(false) bool isSubmitting,
  }) = _AdminCompetitionState;
}
