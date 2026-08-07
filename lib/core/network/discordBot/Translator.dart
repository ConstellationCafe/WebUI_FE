import 'package:constellation_cafe/core/network/discordBot/Interface.dart';
import 'package:constellation_cafe/core/network/discordBot/socket/Interface.dart';
import 'package:constellation_cafe/core/network/discordBot/socket/Client.dart';
import 'package:constellation_cafe/shared/model/request/SocketModel.dart';

class APITranslator extends APIInterface {
  final SocketInterface client = SocketClient();

  @override
  Future<Map<String, dynamic>> request(String path, List<dynamic> args) async {
    List<String> parts = path.split("/");
    String dst = parts[1];
    String sub = parts[2];
    String targetFunc = parts[3];

    SocketModel model = SocketModel(
        dst: dst,
        sub: sub,
        targetFunc: targetFunc,
        args: args
    );
    return await client.send(model);
  }
}