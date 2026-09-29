import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:constellation_cafe/shared/data/dto/request/socket_model.dart';

import '../../network_strings.dart';
import '../../network_timeouts.dart';
import 'socket_interface.dart';

/// 빗자루 봇 router에 [SocketModel] envelope을 HTTP POST로 보낸다.
///
/// 실패하면 예외 대신 `{'status_code': false, 'message': ...}`를 돌려준다. 사용자에게
/// 보여줄 수 있는 고정 문구만 담고 예외 원문(내부 정보)은 담지 않는다.
class SocketClient extends SocketInterface {
  static const String routerUrl = String.fromEnvironment('ROUTE_URI');

  @override
  Future<Map<String, dynamic>> send(SocketModel model) async {
    try {
      final url = Uri.parse(routerUrl);
      final response = await http
          .post(
            url,
            headers: {'Content-type': 'application/json'},
            body: json.encode(model.toJson()),
          )
          .timeout(NetworkTimeouts.botRouter);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }

      // 서버에서 에러 응답을 보낸 경우
      final Map<String, dynamic> errorData = json.decode(response.body);
      return _failure(
        errorData['message'] ??
            NetworkStrings.botRouterStatusError(response.statusCode),
      );
    } on TimeoutException {
      return _failure(NetworkStrings.botRouterTimeout);
    } on http.ClientException {
      return _failure(NetworkStrings.botRouterNetworkError);
    } on FormatException {
      return _failure(NetworkStrings.botRouterFormatError);
    } catch (_) {
      return _failure(NetworkStrings.botRouterUnknownError);
    }
  }

  Map<String, dynamic> _failure(Object message) => {
    'status_code': false,
    'message': message,
  };
}
