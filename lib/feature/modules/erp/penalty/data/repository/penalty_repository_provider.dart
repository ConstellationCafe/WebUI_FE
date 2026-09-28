import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/network/DioProvider.dart';

import '../api/penalty_api.dart';
import 'penalty_repository.dart';

final penaltyRepositoryProvider = Provider<PenaltyRepository>((ref) {
  return PenaltyRepository(api: PenaltyApi(dio: ref.read(dioProvider)));
});
