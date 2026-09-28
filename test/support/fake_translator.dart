import 'package:constellation_cafe/core/network/discordBot/Translator.dart';

typedef TranslatorHandler =
    Future<Map<String, dynamic>> Function(String path, List<dynamic> args);

/// Discord Bot 라우터 대신 호출 경로와 인자를 기록하는 테스트 대역.
class FakeTranslator extends APITranslator {
  FakeTranslator([this.handler]);

  TranslatorHandler? handler;

  final List<(String, List<dynamic>)> calls = [];

  @override
  Future<Map<String, dynamic>> request(String path, List<dynamic> args) async {
    calls.add((path, args));
    final respond = handler;
    if (respond == null) {
      return {
        'payload': {'result': 'ok'},
      };
    }
    return respond(path, args);
  }
}
