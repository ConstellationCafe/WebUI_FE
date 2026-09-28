import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// 실제 네트워크 대신 등록한 응답을 돌려주는 Dio 테스트 대역.
///
/// HTTP 어댑터를 바꾸므로 상태 코드 처리와 interceptor는 실제 Dio와 같게
/// 동작한다. 경로는 `BACKEND_URI` 설정과 관계없이 `uri.path`로 비교한다.
class FakeBackend {
  FakeBackend() {
    dio.httpClientAdapter = _FakeAdapter(this);
  }

  final Dio dio = Dio(BaseOptions(baseUrl: 'https://example.invalid'));
  final List<RequestOptions> requests = [];
  final Map<String, _Reply> _replies = {};
  final Map<String, List<_Reply>> _once = {};

  RequestOptions get last => requests.last;

  /// `METHOD /path` 형식의 요청 기록.
  List<String> get calls {
    return [for (final r in requests) '${r.method} ${r.uri.path}'];
  }

  /// [method] [path] 요청에 [status]와 [body]로 응답한다.
  ///
  /// [once]가 true면 다음 한 번의 요청에만 먼저 쓰인다.
  void reply(
    String method,
    String path,
    Object? body, {
    int status = 200,
    bool once = false,
  }) {
    final key = '$method $path';
    if (once) {
      _once.putIfAbsent(key, () => []).add(_Reply(status, body));
    } else {
      _replies[key] = _Reply(status, body);
    }
  }

  void close() => dio.close(force: true);

  ResponseBody _respond(RequestOptions options) {
    requests.add(options);
    final key = '${options.method} ${options.uri.path}';
    final queued = _once[key];
    final reply = queued != null && queued.isNotEmpty
        ? queued.removeAt(0)
        : _replies[key];
    if (reply == null) {
      throw DioException.connectionError(
        requestOptions: options,
        reason: 'unexpected $key',
      );
    }
    return ResponseBody.fromString(
      jsonEncode(reply.body),
      reply.status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.backend);

  final FakeBackend backend;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return backend._respond(options);
  }

  @override
  void close({bool force = false}) {}
}

class _Reply {
  const _Reply(this.status, this.body);

  final int status;
  final Object? body;
}

/// 백엔드 공통 응답 봉투.
Map<String, dynamic> ok(Object? response) => {
  'success': true,
  'response': response,
  'error': null,
};

Map<String, dynamic> failure(int status, String message) => {
  'success': false,
  'response': null,
  'error': {'status': status, 'message': message},
};
