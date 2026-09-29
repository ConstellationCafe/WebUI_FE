import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;

class ApiResponse {
  final bool success;
  final dynamic response;
  final ApiError? error;

  ApiResponse({
    required this.success,
    required this.response,
    required this.error,
  });

  factory ApiResponse.fromHttpResponse(http.Response res) {
    final Map<String, dynamic> json =
        jsonDecode(res.body) as Map<String, dynamic>;

    return ApiResponse(
      success: json['success'] == true,
      response: json['response'],
      error: json['error'] == null
          ? null
          : ApiError.fromJson(json['error'] as Map<String, dynamic>),
    );
  }

  factory ApiResponse.fromDioResponse(dio.Response res) {
    final Map<String, dynamic> json = res.data is String
        ? jsonDecode(res.data)
        : res.data as Map<String, dynamic>;

    return ApiResponse(
      success: json['success'] == true,
      response: json['response'],
      error: json['error'] == null
          ? null
          : ApiError.fromJson(json['error'] as Map<String, dynamic>),
    );
  }
}

class ApiError {
  final String? message;
  final int? status;

  ApiError({this.message, this.status});

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
    message: json['message'] as String?,
    status: json['status'] as int?,
  );
}
