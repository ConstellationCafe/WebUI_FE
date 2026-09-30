import 'package:dio/dio.dart';

import '../../domain/model/competition_board.dart';
import '../../domain/model/competition_draft.dart';
import '../../domain/model/competition_failure.dart';
import '../../domain/model/competition_post_result.dart';
import '../api/competition_api.dart';
import '../dto/request/competition_create_request.dart';
import '../dto/request/competition_notice_request.dart';

class CompetitionRepository {
  final CompetitionApi api;

  const CompetitionRepository({required this.api});

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
