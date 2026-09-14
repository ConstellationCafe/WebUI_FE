
import 'package:constellation_cafe/core/network/discordBot/Translator.dart';

class ShadowverseAPI {
  final APITranslator translator;

  ShadowverseAPI(this.translator);

  Future<String> friedlyMatch(List<dynamic> args) async {
    /** args : [
     * from_discord,
     * (version, mode, platform, room_number, message),
     * room_name, sender
     * ]
     */
    String path = "/ShadowverseAPI/friendlyMatch/check_match_form";
    final res = await translator.request(path, args);
    return res["payload"]["result"];
  }
}
