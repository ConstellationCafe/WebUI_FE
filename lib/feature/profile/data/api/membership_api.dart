import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/network/discord_bot/translator.dart';
import 'package:constellation_cafe/shared/data/dto/response/bot/bot_command_response.dart';

import '../dto/response/membership_card_response.dart';

final membershipApiProvider = Provider(
  (ref) => MembershipAPI(ref.watch(apiTranslatorProvider)),
);

class MembershipAPI {
  final APITranslator translator;

  MembershipAPI(this.translator);

  Future<MembershipCardResponse> createCard(List<dynamic> args) async {
    /** args : [membershipID] */
    String path = "/ConstellationAPI/MembershipAPI/create_card";
    final res = await translator.request(path, args);
    return MembershipCardResponse.fromJson(res);
  }

  Future<String> updateUID(List<dynamic> args) async {
    /** args : [membershipID, version, uid, username] */
    String path = "/ConstellationAPI/MembershipAPI/update_uid";
    final res = await translator.request(path, args);
    return BotCommandResponse.fromJson(res).resultMessage;
  }

  Future<String> updateGuild(List<dynamic> args) async {
    /** args : [membershipID, version, guild, username] */
    String path = "/ConstellationAPI/MembershipAPI/update_guild";
    final res = await translator.request(path, args);
    return BotCommandResponse.fromJson(res).resultMessage;
  }
}
