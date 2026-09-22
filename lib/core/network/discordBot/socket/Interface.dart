import 'package:constellation_cafe/shared/data/dto/request/SocketModel.dart';

abstract class SocketInterface {
  Future<Map<String, dynamic>> send(SocketModel model);
}
