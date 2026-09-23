import 'package:dio/dio.dart';

class AdminPointApi {
  static const base = String.fromEnvironment('BACKEND_URI');
  static const path = '$base/api/repository/membership/admin/points';

  final Dio dio;

  const AdminPointApi({required this.dio});

  Future<Map<String, dynamic>> getMembers({
    required int page,
    required int size,
    String? discordId,
  }) async {
    final response = await dio.get<Map<String, dynamic>>(
      '$path/members',
      queryParameters: {
        'page': page,
        'size': size,
        if (discordId != null && discordId.isNotEmpty) 'discordId': discordId,
      },
    );
    return _responseBody(response.data);
  }

  Future<Map<String, dynamic>> getMember(
    String discordId, {
    required int page,
    required int size,
  }) async {
    final response = await dio.get<Map<String, dynamic>>(
      '$path/members/$discordId',
      queryParameters: {'page': page, 'size': size},
    );
    return _responseBody(response.data);
  }

  Future<Map<String, dynamic>> transact({
    required String discordId,
    required bool isDeposit,
    required int amount,
    required String description,
  }) async {
    final response = await dio.post<Map<String, dynamic>>(
      '$path/members/$discordId/transactions',
      data: {
        'type': isDeposit ? 'DEPOSIT' : 'WITHDRAW',
        'amount': amount,
        'description': description,
      },
    );
    return _responseBody(response.data);
  }

  Map<String, dynamic> _responseBody(Map<String, dynamic>? data) {
    final response = data?['response'];
    if (data?['success'] != true || response is! Map<String, dynamic>) {
      throw const FormatException('포인트 API 응답 형식이 올바르지 않습니다.');
    }
    return response;
  }
}
