import 'package:constellation_cafe/data/model/request/SocketModel.dart';

abstract class SocketInterface {
  Future<Map<String, dynamic>> send(SocketModel model);
}