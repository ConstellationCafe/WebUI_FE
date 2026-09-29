import 'package:constellation_cafe/core/network/discord_bot/api_interface.dart';
import 'package:constellation_cafe/core/network/discord_bot/socket/socket_interface.dart';
import 'package:constellation_cafe/core/network/discord_bot/socket/socket_client.dart';
import 'package:constellation_cafe/shared/data/dto/request/socket_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiTranslatorProvider = Provider((ref) => APITranslator());

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
      args: args,
    );
    return await client.send(model);
  }
}
