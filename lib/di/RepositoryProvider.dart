
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';
import 'package:constellation_cafe/feature/contents/learning/repository/learning_repository.dart';
import 'package:constellation_cafe/feature/contents/menu//repository/menu_repository.dart';
import 'package:constellation_cafe/feature/contents/music//repository/music_repository.dart';
import 'package:constellation_cafe/feature/contents/content/repository/content_repository.dart';
import 'package:constellation_cafe/feature/user/profile/repository/point_repository.dart';
import 'DioProvider.dart';

// Api
final learningRepositoryProvider = Provider<RepositoryInterface>(
      (ref) => LearningRepository(dio: ref.watch(dioProvider)),
);
final menuRepositoryProvider = Provider<RepositoryInterface>(
      (ref) => MenuRepository(dio: ref.watch(dioProvider)),
);
final musicRepositoryProvider = Provider<RepositoryInterface>(
      (ref) => MusicRepository(dio: ref.watch(dioProvider)),
);
final contentRepositoryProvider = Provider<RepositoryInterface>(
      (ref) => ContentRepository(dio: ref.watch(dioProvider)),
);
final pointRepositoryProvider = Provider<RepositoryInterface>(
      (ref) => PointRepository(dio: ref.watch(dioProvider)),
);