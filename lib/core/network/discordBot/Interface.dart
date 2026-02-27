

abstract class APIInterface {
  Future<Map<String, dynamic>> request(String path, List<dynamic> args);
}