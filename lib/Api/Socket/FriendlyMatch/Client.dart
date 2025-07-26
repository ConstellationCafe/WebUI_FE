import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/Model.dart';

class FriendlyMatchApiClient {
  static const String _baseUrl = 'http://127.0.0.1:8000';
  static const String _endpoint = '/api/friendly_match/send';

  static Future<Map<String, dynamic>> send(SocketModel model) async {
    try {
      final url = Uri.parse('$_baseUrl$_endpoint');
      // 연결 테스트를 위한 로그
      print("요청 URL: $url");
      print("요청 데이터: ${json.encode(model.toJson())}");
      final response = await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(model.toJson()),
      )
          .timeout(
        Duration(seconds: 10), // 10초 타임아웃
        onTimeout: () {
          throw Exception('요청 시간이 초과되었습니다.');
        },
      );
      print("응답 상태 코드: ${response.statusCode}");
      print("응답 본문: ${response.body}");

      // HTTP 상태 코드 확인
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("frontend: $responseData");
        return responseData;
      } else {
        // 서버에서 에러 응답을 보낸 경우
        final Map<String, dynamic> errorData = json.decode(response.body);
        return {'status_code': false, 'message': errorData['message'] ?? '서버 오류가 발생했습니다. (${response.statusCode})'};
      }
    } on http.ClientException catch (e) {
      return {'status_code': false, 'message': '네트워크 연결 오류: ${e.message}'};
    } on FormatException catch (e) {
      return {'status_code': false, 'message': '응답 데이터 형식 오류: ${e.message}'};
    } on Exception catch (e) {
      return {'status_code': false, 'message': e.toString()};
    } catch (e) {
      return {'status_code': false, 'message': '알 수 없는 오류가 발생했습니다: ${e.toString()}'};
    }
  }
}
