import 'package:dio/dio.dart';

import '../dto/request/admin_point_history_request.dart';
import '../dto/request/admin_point_members_request.dart';
import '../dto/request/admin_point_transaction_request.dart';
import '../dto/response/admin_point_detail_response.dart';
import '../dto/response/admin_point_member_page_response.dart';

class AdminPointApi {
  static const base = String.fromEnvironment('BACKEND_URI');
  static const path = '$base/api/repository/membership/admin/points';

  final Dio dio;

  const AdminPointApi({required this.dio});

  Future<AdminPointMemberPageResponse> getMembers(
    AdminPointMembersRequest request,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '$path/members',
      queryParameters: request.toJson(),
    );
    return AdminPointMemberPageResponse.fromJson(_responseBody(response.data));
  }

  Future<AdminPointDetailResponse> getMember(
    String discordId,
    AdminPointHistoryRequest request,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '$path/members/${Uri.encodeComponent(discordId)}',
      queryParameters: request.toJson(),
    );
    return AdminPointDetailResponse.fromJson(_responseBody(response.data));
  }

  Future<AdminPointDetailResponse> transact(
    String discordId,
    AdminPointTransactionRequest request,
  ) async {
    final response = await dio.post<Map<String, dynamic>>(
      '$path/members/${Uri.encodeComponent(discordId)}/transactions',
      data: request.toJson(),
    );
    return AdminPointDetailResponse.fromJson(_responseBody(response.data));
  }

  Map<String, dynamic> _responseBody(Map<String, dynamic>? data) {
    final response = data?['response'];
    if (data?['success'] != true || response is! Map<String, dynamic>) {
      throw const FormatException('포인트 API 응답 형식이 올바르지 않습니다.');
    }
    return response;
  }
}
