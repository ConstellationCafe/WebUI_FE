import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:constellation_cafe/core/network/discordBot/socket/Interface.dart';
import 'package:constellation_cafe/data/model/request/SocketModel.dart';

class SocketClient extends SocketInterface {
  static const String routerUrl = String.fromEnvironment('ROUTE_URI'); // https://constellationcafe.p-e.kr/route/
  static const int _timeout = 10;

  @override
  Future<Map<String, dynamic>> send(SocketModel model) async {
    try {
      final url = Uri.parse(routerUrl);
      // 연결 테스트를 위한 로그
      print("요청 URL: $url");
      print("요청 데이터: ${json.encode(model.toJson())}");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(model.toJson()),
      ).timeout(
        Duration(seconds: _timeout),
        onTimeout: () {
          throw Exception('요청 시간이 초과되었습니다.');
        },
      );
      print("응답 상태 코드: ${response.statusCode}");

      // HTTP 상태 코드 확인
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("frontend: $responseData");
        return responseData;
      } else {
        // 서버에서 에러 응답을 보낸 경우
        final Map<String, dynamic> errorData = json.decode(response.body);
        return {
          'status_code': false,
          'message': errorData['message'] ?? '서버 오류가 발생했습니다. (${response.statusCode})'
        };
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
