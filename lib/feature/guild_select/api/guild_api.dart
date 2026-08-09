
import 'package:dio/dio.dart';
import '../domain/guild.dart';


class GuildApi {
  static const base = String.fromEnvironment('BACKEND_URI');
  final Dio dio;

  GuildApi({
    required this.dio
  });

  @override
  Future<List<Guild>> findAll() async {
    final response = await dio.get("$base/auth/guilds");
    final res = response.data;
    if (res['success'] == true) {
      final List entities = (res['response'] as List?)?.toList() ?? const [];
      if (entities.isNotEmpty) {
        return entities
            .map((e) => Guild.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else {
      final err = res['error'];
      final msg = (err is Map<String, dynamic>) ? (err['message']?.toString() ?? 'unknown') : 'unknown';
      throw Exception('API error: $msg');
    }
  }
}