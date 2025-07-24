import 'Socket/Client.dart';


Future<Map<String, dynamic>> request(String path, Map<String, dynamic> jsonBody) async {
  SocketClient socket = parseRequest(path, jsonBody);
  return await socket.send();
}

SocketClient parseRequest(String path, Map<String, dynamic> jsonBody) {
  /*
  http 요청을 socket 요청 객체로 변환
  path 예시: '/ConstellationAPI/MembershipAPI/create_card'
  */
  final segments = path.split('/');
  if (segments.length < 4) {
    throw FormatException('Invalid path format,'
                          '\nmust be /dst/sub/target_func');
  }
  // args는 JSON 값들의 순서대로 리스트 생성
  final args = jsonBody.values.toList();

  return SocketClient(
    dst: segments[1],
    sub: segments[2],
    targetFunc: segments[3],
    args: args,
  );
}
