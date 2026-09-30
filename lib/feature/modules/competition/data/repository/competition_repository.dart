import 'package:dio/dio.dart';

import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/domain/version/game_version_type.dart';

import '../../domain/model/competition_board.dart';
import '../../domain/model/competition_draft.dart';
import '../../domain/model/competition_failure.dart';
import '../../domain/model/competition_post_result.dart';
import '../../domain/model/competition_winner.dart';
import '../api/competition_api.dart';
import '../dto/request/competition_create_request.dart';
import '../dto/request/competition_notice_request.dart';
import '../dto/request/competition_winner_grant_request.dart';
import '../dto/response/competition_winner_response.dart';

class CompetitionRepository {
  final CompetitionApi api;

  const CompetitionRepository({required this.api});

  /// 대회 매니저 기능을 쓸 수 있는지. 조회에 실패하면 false로 보고 메뉴를 숨긴다.
  Future<bool> isManager() async {
    final response = await api.getMyPermission();
    return response.manager;
  }

  Future<List<CompetitionBoard>> getBoards() async {
    try {
      final boards = await api.getBoards();
      return [
        for (final board in boards)
          CompetitionBoard(
            key: board.key,
            channelId: board.channelId,
            name: board.name,
            joinable: board.joinable,
          ),
      ];
    } on DioException catch (error) {
      throw _exception(error);
    }
  }

  /// 실패는 [CompetitionException]으로 바꿔 던진다.
  Future<String> preview(CompetitionDraft draft) async {
    try {
      return await api.preview(_notice(draft));
    } on DioException catch (error) {
      throw _exception(error);
    }
  }

  /// 실패는 [CompetitionException]으로 바꿔 던진다.
  Future<CompetitionPostResult> post({
    required String requestId,
    required String boardKey,
    required CompetitionDraft draft,
  }) async {
    try {
      final response = await api.post(
        CompetitionCreateRequest(
          requestId: requestId,
          boardKey: boardKey,
          notice: _notice(draft),
        ),
      );
      return CompetitionPostResult(
        boardKey: response.boardKey,
        messageId: response.messageId,
        messageUrl: response.messageUrl,
        content: response.content,
      );
    } on DioException catch (error) {
      throw _exception(error);
    }
  }

  /// 실패는 [CompetitionWinnerException]으로 바꿔 던진다.
  Future<CompetitionWinner> grantWinner(CompetitionWinnerDraft draft) async {
    try {
      final response = await api.grantWinner(
        CompetitionWinnerGrantRequest(
          competitionName: draft.competitionName,
          version: draft.version.typeToString(),
          winnerDiscordId: draft.winnerDiscordId,
          acquisition: draft.acquisition,
        ),
      );
      return _winner(response);
    } on DioException catch (error) {
      final reason = switch (error.response?.statusCode) {
        400 => CompetitionWinnerFailure.invalid,
        404 => CompetitionWinnerFailure.notMember,
        409 => CompetitionWinnerFailure.conflict,
        _ => CompetitionWinnerFailure.unknown,
      };
      throw CompetitionWinnerException(
        reason,
        _serverMessage(error.response?.data),
      );
    }
  }

  Future<CompetitionWinnerPage> getWinners({required int page}) async {
    final response = await api.getWinners(page: page);
    return CompetitionWinnerPage(
      items: response.items.map(_winner).toList(),
      page: response.page,
      totalPages: response.totalPages,
    );
  }

  CompetitionWinner _winner(CompetitionWinnerResponse response) {
    return CompetitionWinner(
      competitionName: response.competitionName,
      version: GameVersionType.stringToType(response.version),
      winnerDiscordId: response.winnerDiscordId,
      winnerName: response.winnerName,
      acquisition: response.acquisition,
    );
  }

  CompetitionNoticeRequest _notice(CompetitionDraft draft) {
    return CompetitionNoticeRequest(
      title: draft.title,
      participantWay: draft.participantWay,
      format: draft.format,
      registrationStart: draft.registrationStart,
      registrationEnd: draft.registrationEnd,
      eventStart: draft.eventStart,
      prizes: [
        for (final prize in draft.prizes)
          CompetitionPrizeRequest(rank: prize.rank, content: prize.content),
      ],
      extraFields: [
        for (final field in draft.extraFields)
          CompetitionExtraFieldRequest(key: field.key, value: field.value),
      ],
    );
  }

  CompetitionException _exception(DioException error) {
    final reason = switch (error.response?.statusCode) {
      400 => CompetitionFailureReason.invalid,
      404 => CompetitionFailureReason.notConfigured,
      502 => CompetitionFailureReason.discord,
      _ => CompetitionFailureReason.unknown,
    };
    return CompetitionException(reason, _serverMessage(error.response?.data));
  }

  /// 공통 오류 응답 `{success: false, error: {message, status}}`의 안내 문구
  String? _serverMessage(Object? data) {
    if (data is! Map) return null;
    final error = data['error'];
    if (error is! Map) return null;
    final message = error['message'];
    return message is String && message.trim().isNotEmpty ? message : null;
  }
}
