import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/di/ApiProvider.dart';
import 'package:constellation_cafe/feature/guild_select/domain/guild.dart';

part 'guild_list_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<Guild>> guildList(Ref ref) async {
  final guildApi = ref.read(guildApiProvider);
  return guildApi.findAll();
}