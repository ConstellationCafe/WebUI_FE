import 'package:dio/dio.dart';

class PointManagementApi {
  static const base = String.fromEnvironment('BACKEND_URI');

  final Dio dio;

  const PointManagementApi({required this.dio});

  Future<Map<String, dynamic>> getMembers({
    required String discordId,
    required int page,
    required int size,
  }) async {
    final response = await dio.get(
      '$base/api/repository/membership/admin/points/members',
      queryParameters: {
        if (discordId.trim().isNotEmpty) 'discordId': discordId.trim(),
        'page': page,
        'size': size,
      },
    );
    return _unwrap(response.data);
  }

  Future<Map<String, dynamic>> getMemberDetail({
    required String discordId,
    required int page,
    required int size,
  }) async {
    final path =
        '$base/api/repository/membership/admin/points/members/' +
        Uri.encodeComponent(discordId);
    final response = await dio.get(
      path,
      queryParameters: {'page': page, 'size': size},
    );
    return _unwrap(response.data);
  }

  Future<Map<String, dynamic>> adjustPoint({
    required String discordId,
    required String type,
    required int amount,
    required String description,
  }) async {
    final path =
        '$base/api/repository/membership/admin/points/members/' +
        Uri.encodeComponent(discordId) +
        '/transactions';
    final response = await dio.post(
      path,
      data: {
        'type': type,
        'amount': amount,
        'description': description,
      },
    );
    return _unwrap(response.data);
  }

  Map<String, dynamic> _unwrap(dynamic data) {
    if (data is! Map) {
      throw const FormatException('포인트 API 응답 형식이 올바르지 않습니다.');
    }
    final response = Map<String, dynamic>.from(data);
    if (response['success'] != true) {
      final error = response['error'];
      final message = error is Map ? error['message']?.toString() : null;
      throw Exception(message ?? '포인트 요청을 처리하지 못했습니다.');
    }
    final body = response['response'];
    if (body is! Map) {
      throw const FormatException('포인트 API 응답 본문이 올바르지 않습니다.');
    }
    return Map<String, dynamic>.from(body);
  }
}
