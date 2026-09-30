import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/core/network/dio_provider.dart';

import '../data/api/competition_api.dart';
import '../data/repository/competition_repository.dart';
import '../domain/model/competition_draft.dart';
import '../domain/model/competition_failure.dart';
import '../domain/model/competition_post_result.dart';
import '../state/admin_competition_state.dart';

part 'admin_competition_notifier.g.dart';

final competitionRepositoryProvider = Provider((ref) {
  return CompetitionRepository(api: CompetitionApi(dio: ref.read(dioProvider)));
});

/// 게시 결과. 성공하면 [result], 실패하면 [failure]만 채워진다.
typedef CompetitionPostOutcome = ({
  CompetitionPostResult? result,
  CompetitionException? failure,
});

/// 대회 게시판 목록, 미리보기, 게시.
@riverpod
class AdminCompetitionNotifier extends _$AdminCompetitionNotifier {
  late CompetitionRepository _repository;
  int _boardsRequest = 0;
  int _previewRequest = 0;

  @override
  AdminCompetitionState build() {
    _repository = ref.read(competitionRepositoryProvider);
    scheduleMicrotask(() {
      if (ref.mounted && _boardsRequest == 0) unawaited(loadBoards());
    });
    return const AdminCompetitionState(isLoadingBoards: true);
  }

  Future<void> loadBoards() async {
    if (!ref.mounted) return;
    final request = ++_boardsRequest;
    state = state.copyWith(isLoadingBoards: true, hasBoardsError: false);
    try {
      final boards = await _repository.getBoards();
      if (!ref.mounted || request != _boardsRequest) return;
      final selected = state.selectedBoardKey;
      final keepSelection = boards.any((board) => board.key == selected);
      state = state.copyWith(
        boards: boards,
        selectedBoardKey: keepSelection
            ? selected
            : (boards.isEmpty ? null : boards.first.key),
        isLoadingBoards: false,
      );
    } catch (_) {
      if (!ref.mounted || request != _boardsRequest) return;
      state = state.copyWith(isLoadingBoards: false, hasBoardsError: true);
    }
  }

  void selectBoard(String? key) {
    if (!ref.mounted || state.isSubmitting) return;
    state = state.copyWith(selectedBoardKey: key);
  }

  /// [draft]가 null이면(필수 입력이 비었거나 형식이 맞지 않으면) 미리보기를 비운다.
  /// 늦게 도착한 이전 요청의 결과는 버린다.
  Future<void> preview(CompetitionDraft? draft) async {
    if (!ref.mounted) return;
    final request = ++_previewRequest;
    if (draft == null) {
      state = state.copyWith(
        preview: null,
        previewFailure: null,
        isPreviewing: false,
      );
      return;
    }
    state = state.copyWith(isPreviewing: true);
    try {
      final content = await _repository.preview(draft);
      if (!ref.mounted || request != _previewRequest) return;
      state = state.copyWith(
        preview: content,
        previewFailure: null,
        isPreviewing: false,
      );
    } on CompetitionException catch (error) {
      if (!ref.mounted || request != _previewRequest) return;
      state = state.copyWith(
        preview: null,
        previewFailure: error,
        isPreviewing: false,
      );
    } catch (_) {
      if (!ref.mounted || request != _previewRequest) return;
      state = state.copyWith(
        preview: null,
        previewFailure: const CompetitionException(
          CompetitionFailureReason.unknown,
        ),
        isPreviewing: false,
      );
    }
  }

  /// 선택한 게시판에 게시한다. 진행 중이거나 게시판이 없으면 실행하지 않는다.
  Future<CompetitionPostOutcome> post({
    required String requestId,
    required CompetitionDraft draft,
  }) async {
    final boardKey = state.selectedBoardKey;
    if (!ref.mounted || state.isSubmitting || boardKey == null) {
      return (
        result: null,
        failure: const CompetitionException(CompetitionFailureReason.unknown),
      );
    }
    state = state.copyWith(isSubmitting: true);
    try {
      final result = await _repository.post(
        requestId: requestId,
        boardKey: boardKey,
        draft: draft,
      );
      if (ref.mounted) state = state.copyWith(isSubmitting: false);
      return (result: result, failure: null);
    } on CompetitionException catch (error) {
      if (ref.mounted) state = state.copyWith(isSubmitting: false);
      return (result: null, failure: error);
    } catch (_) {
      if (ref.mounted) state = state.copyWith(isSubmitting: false);
      return (
        result: null,
        failure: const CompetitionException(CompetitionFailureReason.unknown),
      );
    }
  }
}
