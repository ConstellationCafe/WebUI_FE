import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:constellation_cafe/core/utils/date_formatter.dart';
import 'package:constellation_cafe/shared/data/dto/request/SocketModel.dart';
import 'package:constellation_cafe/shared/data/dto/response/backend/ApiResponse.dart';

void main() {
  group('SocketModel request contract', () {
    test('serializes the required envelope and payload fields', () {
      final request = SocketModel(
        dst: 'ConstellationAPI',
        sub: 'CompetitionAPI',
        targetFunc: 'competition_list',
        args: const [
          {'page': 1},
        ],
      );

      expect(request.toJson(), {
        'pri': 1,
        'auth_id': 731001,
        'src': 'WebUI',
        'dst': 'ConstellationAPI',
        'payload': {
          'sub': 'CompetitionAPI',
          'target_func': 'competition_list',
          'args': const [
            {'page': 1},
          ],
        },
      });
    });
  });

  group('ApiResponse contract', () {
    test('parses a successful HTTP response without an error', () {
      final response = ApiResponse.fromHttpResponse(
        http.Response(
          jsonEncode({
            'success': true,
            'response': {'items': []},
            'error': null,
          }),
          200,
        ),
      );

      expect(response.success, isTrue);
      expect(response.response, {'items': []});
      expect(response.error, isNull);
    });

    test('parses an error payload and preserves its status and message', () {
      final httpResponse = http.Response.bytes(
        utf8.encode(
          jsonEncode({
            'success': false,
            'response': null,
            'error': {
              'status': 400,
              'message': '잘못된 요청입니다',
            },
          }),
        ),
        400,
        headers: {
          'content-type': 'application/json; charset=utf-8',
        },
      );

      final apiResponse = ApiResponse.fromHttpResponse(httpResponse);

      expect(apiResponse.success, isFalse);
      expect(apiResponse.error?.status, 400);
      expect(apiResponse.error?.message, '잘못된 요청입니다');
    });
  });

  group('DateFormatter', () {
    test('formats a date with zero-padded month and day', () {
      expect(
        DateFormatter.toYyyyMmDd(DateTime(2026, 9, 3)),
        '2026-09-03',
      );
    });

    test('uses the fallback for a missing date', () {
      expect(DateFormatter.toYyyyMmDd(null), '-');
      expect(DateFormatter.toYyyyMmDd(null, fallback: '날짜 없음'), '날짜 없음');
    });
  });
}
