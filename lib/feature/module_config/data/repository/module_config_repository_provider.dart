import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/network/dio_provider.dart';

import '../api/module_config_api.dart';
import 'module_config_repository.dart';

/// 상태가 없는 데이터 계층 의존성 주입용 provider.
final moduleConfigRepositoryProvider = Provider((ref) {
  return ModuleConfigRepository(
    api: ModuleConfigApi(dio: ref.watch(dioProvider)),
  );
});
