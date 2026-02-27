// import 'package:test/test.dart';
// import 'package:constellation_cafe/Api/Socket/Client.dart';
// import 'package:constellation_cafe/Api/Socket/Model.dart';
//
//
// void main() {
//   group('request 함수 테스트', () {
//     test('정상 응답 테스트', () async {
//       final socketModel = SocketModel(
//           dst: "ConstellationAPI",
//           sub: "CompetitionAPI",
//           targetFunc: "competition_list",
//           args: []
//       );
//       final testResponse = await ApiClient.send(socketModel);
//       // 결과 확인 - 실제 API 응답 형식에 맞게 수정 필요
//       expect(testResponse, isA<Map<String, dynamic>>());
//       print('정상 응답 테스트');
//       print(testResponse);
//     });
//
//   //   test('허용되지 않은 API 요청 테스트', () async {
//   //     final testPath = "/ChatBotAPI/menu/recommend_menu";
//   //     final Map<String, dynamic> testBody = {
//   //
//   //     };
//   //     final Map<String, dynamic> testResponse = await request(testPath, testBody);
//   //
//   //     // 결과 확인 - 실제 API 응답 형식에 맞게 수정 필요
//   //     expect(testResponse, isA<Map<String, dynamic>>());
//   //     print('허용되지 않은 API 요청 테스트');
//   //     print(testResponse);
//   //   });
//   //
//   //   test('잘못된 요청 시 에러 메시지 테스트', () async {
//   //     final testPath = "/invalid/path/target_func";
//   //     final Map<String, dynamic> testBody = {
//   //       "bad": "data"
//   //     };
//   //     final Map<String, dynamic> testResponse = await request(testPath, testBody);
//   //     print('잘못된 요청 시 에러 메시지 테스트');
//   //     print(testResponse);
//   //   });
//   });
// }
