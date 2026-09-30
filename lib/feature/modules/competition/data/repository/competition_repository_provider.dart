import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/network/dio_provider.dart';

import '../api/competition_api.dart';
import 'competition_repository.dart';

/// 대회 API·repository 의존성 주입용. 상태가 없어 수동 Provider로 둔다(architecture §4 예외).
final competitionRepositoryProvider = Provider((ref) {
  return CompetitionRepository(api: CompetitionApi(dio: ref.read(dioProvider)));
});
