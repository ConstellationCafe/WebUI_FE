
import 'package:constellation_cafe/core/network/discordBot/Translator.dart';

class MembershipAPI {
  final APITranslator translator;

  MembershipAPI(this.translator);

  Future<Map<String, dynamic>> createCard(List<dynamic> args) {
    /** args : [membershipID] */
    String path = "/ConstellationAPI/MembershipAPI/create_card";
    return translator.request(path, args);
  }

  Future<String> updateUID(List<dynamic> args) async {
    /** args : [membershipID, version, uid, username] */
    String path = "/ConstellationAPI/MembershipAPI/update_uid";
    final res = await translator.request(path, args);
    return res["payload"]["result"];
  }

  Future<String> updateGuild(List<dynamic> args) async {
    /** args : [membershipID, version, guild, username] */
    String path = "/ConstellationAPI/MembershipAPI/update_guild";
    final res = await translator.request(path, args);
    return res["payload"]["result"];
  }
}
