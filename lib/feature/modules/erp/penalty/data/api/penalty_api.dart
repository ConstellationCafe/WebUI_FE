import 'package:dio/dio.dart';

import 'package:constellation_cafe/core/network/interceptors/error_interceptor.dart';

import '../dto/request/penalty_cancel_request.dart';
import '../dto/request/penalty_create_request.dart';
import '../dto/request/penalty_history_request.dart';
import '../dto/request/penalty_members_request.dart';
import '../dto/request/penalty_page_request.dart';
import '../dto/response/penalty_detail_response.dart';
import '../dto/response/penalty_history_response.dart';
import '../dto/response/penalty_member_response.dart';
import '../dto/response/penalty_page_response.dart';
import '../dto/response/penalty_permission_response.dart';

/// 벌점 API. 관리 기능(`/api/penalties`)은 운영 매니저·운영 본부원·서버장만 쓰고,
/// 권한 조회와 본인 조회(`/api/me/penalties`)는 로그인한 회원 누구나 호출한다.
class PenaltyApi {
  static const base = String.fromEnvironment('BACKEND_URI');
  static const managePath = '$base/api/penalties';
  static const myPath = '$base/api/me/penalties';

  final Dio dio;

  const PenaltyApi({required this.dio});

  static final _options = Options(receiveTimeout: const Duration(seconds: 15));

  /// 현재 채팅방에서 벌점을 관리할 수 있는지. 메뉴 표시용이며 최종 판단은 서버가 한다.
  /// 권한이 없는 회원도 매번 호출하므로 실패해도 오류 안내를 띄우지 않는다.
  Future<PenaltyPermissionResponse> permission() async {
    final result = await dio.get<Map<String, dynamic>>(
      '$managePath/me/permissions',
      options: Options(
        receiveTimeout: const Duration(seconds: 15),
        extra: {ErrorInterceptor.silentErrorKey: true},
      ),
    );
    return PenaltyPermissionResponse.fromJson(_body(result.data));
  }

  Future<PenaltyPageResponse<PenaltyHistoryResponse>> history(
    PenaltyHistoryRequest request, {
    CancelToken? cancelToken,
  }) async {
    final result = await dio.get<Map<String, dynamic>>(
      managePath,
      queryParameters: request.toJson(),
      options: _options,
      cancelToken: cancelToken,
    );
    return PenaltyPageResponse.fromJson(
      _body(result.data),
      PenaltyHistoryResponse.fromJson,
    );
  }

  Future<PenaltyPageResponse<PenaltyMemberResponse>> members(
    PenaltyMembersRequest request, {
    CancelToken? cancelToken,
  }) async {
    final result = await dio.get<Map<String, dynamic>>(
      '$managePath/members',
      queryParameters: request.toJson(),
      options: _options,
      cancelToken: cancelToken,
    );
    return PenaltyPageResponse.fromJson(
      _body(result.data),
      PenaltyMemberResponse.fromJson,
    );
  }

  Future<PenaltyDetailResponse> member(
    String discordId,
    PenaltyPageRequest request, {
    CancelToken? cancelToken,
  }) async {
    final result = await dio.get<Map<String, dynamic>>(
      '$managePath/members/${Uri.encodeComponent(discordId)}',
      queryParameters: request.toJson(),
      options: _options,
      cancelToken: cancelToken,
    );
    return PenaltyDetailResponse.fromJson(_body(result.data));
  }

  Future<PenaltyDetailResponse> mine(
    PenaltyPageRequest request, {
    CancelToken? cancelToken,
  }) async {
    final result = await dio.get<Map<String, dynamic>>(
      myPath,
      queryParameters: request.toJson(),
      options: _options,
      cancelToken: cancelToken,
    );
    return PenaltyDetailResponse.fromJson(_body(result.data));
  }

  Future<PenaltyDetailResponse> award(PenaltyCreateRequest request) async {
    final result = await dio.post<Map<String, dynamic>>(
      managePath,
      data: request.toJson(),
      options: _options,
    );
    return PenaltyDetailResponse.fromJson(_body(result.data));
  }

  Future<PenaltyDetailResponse> cancel(
    int penaltyId,
    PenaltyCancelRequest request,
  ) async {
    final result = await dio.patch<Map<String, dynamic>>(
      '$managePath/$penaltyId/cancel',
      data: request.toJson(),
      options: _options,
    );
    return PenaltyDetailResponse.fromJson(_body(result.data));
  }

  Map<String, dynamic> _body(Map<String, dynamic>? data) {
    final response = data?['response'];
    if (data?['success'] != true || response is! Map<String, dynamic>) {
      throw const FormatException('벌점 API 응답 형식이 올바르지 않습니다.');
    }
    return response;
  }
}
