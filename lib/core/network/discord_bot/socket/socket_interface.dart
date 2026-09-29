import 'package:constellation_cafe/shared/data/dto/request/socket_model.dart';

abstract class SocketInterface {
  Future<Map<String, dynamic>> send(SocketModel model);
}
