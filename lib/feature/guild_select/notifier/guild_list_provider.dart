import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/feature/guild_select/data/api/guild_api.dart';
import 'package:constellation_cafe/feature/guild_select/domain/guild.dart';

part 'guild_list_provider.g.dart';

/// 가입한 채팅방 목록. 라우터가 로그인 가드에서 계속 참조하므로 앱 수명 동안 유지한다.
@Riverpod(keepAlive: true)
Future<List<Guild>> guildList(Ref ref) async {
  final guildApi = ref.watch(guildApiProvider);
  return guildApi.findAll();
}
