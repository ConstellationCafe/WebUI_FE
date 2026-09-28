import 'package:dio/dio.dart';

import '../dto/request/penalty_cancel_request.dart';
import '../dto/request/penalty_create_request.dart';
import '../dto/request/penalty_history_request.dart';
import '../dto/request/penalty_members_request.dart';
import '../dto/request/penalty_page_request.dart';
import '../dto/response/penalty_detail_response.dart';
import '../dto/response/penalty_history_response.dart';
import '../dto/response/penalty_member_response.dart';
import '../dto/response/penalty_page_response.dart';

class PenaltyApi {
  static const base = String.fromEnvironment('BACKEND_URI');
  static const adminPath = '$base/api/admin/penalties';
  static const myPath = '$base/api/me/penalties';

  final Dio dio;

  const PenaltyApi({required this.dio});

  static final _options = Options(receiveTimeout: const Duration(seconds: 15));

  Future<PenaltyPageResponse<PenaltyHistoryResponse>> history(
    PenaltyHistoryRequest request, {
    CancelToken? cancelToken,
  }) async {
    final result = await dio.get<Map<String, dynamic>>(
      adminPath,
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
      '$adminPath/members',
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
      '$adminPath/members/${Uri.encodeComponent(discordId)}',
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
      adminPath,
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
      '$adminPath/$penaltyId/cancel',
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
