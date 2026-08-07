import 'package:constellation_cafe/shared/model/request/SocketModel.dart';

abstract class SocketInterface {
  Future<Map<String, dynamic>> send(SocketModel model);
}