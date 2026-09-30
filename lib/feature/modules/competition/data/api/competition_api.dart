import 'package:dio/dio.dart';

import 'package:constellation_cafe/core/network/interceptors/error_interceptor.dart';

import '../dto/request/competition_create_request.dart';
import '../dto/request/competition_notice_request.dart';
import '../dto/request/competition_winner_grant_request.dart';
import '../dto/response/competition_board_response.dart';
import '../dto/response/competition_permission_response.dart';
import '../dto/response/competition_post_response.dart';
import '../dto/response/competition_winner_response.dart';

/// 대회 API(`/api/competitions`). 대회 매니저 또는 서버장만 쓸 수 있고, 권한 조회는 로그인한 회원 누구나 호출한다.
class CompetitionApi {
  static const base = String.fromEnvironment('BACKEND_URI');
  static const path = '$base/api/competitions';

  final Dio dio;

  const CompetitionApi({required this.dio});

  /// 현재 채팅방에서 대회 매니저 기능을 쓸 수 있는지. 메뉴 표시용이며 최종 판단은 서버가 한다.
  Future<CompetitionPermissionResponse> getMyPermission() async {
    final response = await dio.get<Map<String, dynamic>>(
      '$path/me/permissions',
      options: _silent(),
    );
    final body = _response(response.data);
    if (body is! Map<String, dynamic>) {
      throw const FormatException('대회 권한 응답 형식이 올바르지 않습니다.');
    }
    return CompetitionPermissionResponse.fromJson(body);
  }

  Future<List<CompetitionBoardResponse>> getBoards() async {
    final response = await dio.get<Map<String, dynamic>>(
      '$path/boards',
      options: _silent(),
    );
    final boards = _response(response.data);
    if (boards is! List) {
      throw const FormatException('대회 게시판 응답 형식이 올바르지 않습니다.');
    }
    return [
      for (final board in boards)
        CompetitionBoardResponse.fromJson(board as Map<String, dynamic>),
    ];
  }

  /// 게시하지 않고 검증과 평문 조립만 한다. 실제로 게시될 글을 돌려준다.
  Future<String> preview(CompetitionNoticeRequest request) async {
    final response = await dio.post<Map<String, dynamic>>(
      '$path/notices/preview',
      data: request.toJson(),
      options: _silent(),
    );
    final body = _response(response.data);
    final content = body is Map<String, dynamic> ? body['content'] : null;
    if (content is! String) {
      throw const FormatException('미리보기 응답 형식이 올바르지 않습니다.');
    }
    return content;
  }

  Future<CompetitionPostResponse> post(CompetitionCreateRequest request) async {
    final response = await dio.post<Map<String, dynamic>>(
      '$path/notices',
      data: request.toJson(),
      options: _silent(),
    );
    final body = _response(response.data);
    if (body is! Map<String, dynamic>) {
      throw const FormatException('대회 공지 게시 응답 형식이 올바르지 않습니다.');
    }
    return CompetitionPostResponse.fromJson(body);
  }

  Future<CompetitionWinnerResponse> grantWinner(
    CompetitionWinnerGrantRequest request,
  ) async {
    final response = await dio.post<Map<String, dynamic>>(
      '$path/winners',
      data: request.toJson(),
      options: _silent(),
    );
    final body = _response(response.data);
    if (body is! Map<String, dynamic>) {
      throw const FormatException('우승 칭호 부여 응답 형식이 올바르지 않습니다.');
    }
    return CompetitionWinnerResponse.fromJson(body);
  }

  Future<CompetitionWinnerPageResponse> getWinners({required int page}) async {
    final response = await dio.get<Map<String, dynamic>>(
      '$path/winners',
      queryParameters: {'page': page},
      options: _silent(),
    );
    final body = _response(response.data);
    if (body is! Map<String, dynamic>) {
      throw const FormatException('우승 칭호 이력 응답 형식이 올바르지 않습니다.');
    }
    return CompetitionWinnerPageResponse.fromJson(body);
  }

  /// 화면이 오류를 직접 보여주므로 전역 오류 SnackBar를 띄우지 않는다.
  Options _silent() => Options(extra: {ErrorInterceptor.silentErrorKey: true});

  Object? _response(Map<String, dynamic>? data) {
    if (data?['success'] != true) {
      throw const FormatException('대회 공지 API 응답 형식이 올바르지 않습니다.');
    }
    return data?['response'];
  }
}
