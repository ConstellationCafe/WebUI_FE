import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/network/discord_bot/translator.dart';
import 'package:constellation_cafe/shared/data/dto/response/bot/bot_command_response.dart';

import '../dto/request/friendly_match_request.dart';

final shadowverseApiProvider = Provider(
  (ref) => ShadowverseAPI(ref.watch(apiTranslatorProvider)),
);

class ShadowverseAPI {
  final APITranslator translator;

  ShadowverseAPI(this.translator);

  /// 친선전 모집 글을 빗자루가 있는 채팅방에 보내고 봇의 결과 문구를 돌려준다.
  Future<String> friendlyMatch(FriendlyMatchRequest request) async {
    final res = await translator.request(request.path, request.args);
    return BotCommandResponse.fromJson(res).resultMessage;
  }
}
