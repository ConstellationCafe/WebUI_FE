
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';
import 'package:constellation_cafe/feature/contents/chatbot/learning/repository/learning_repository.dart';
import 'package:constellation_cafe/feature/contents/chatbot/menu//repository/menu_repository.dart';
import 'package:constellation_cafe/feature/contents/chatbot/music/repository/music_repository.dart';
import 'package:constellation_cafe/feature/contents/chatbot/content/repository/content_repository.dart';
import 'package:constellation_cafe/feature/profile/repository/point_repository.dart';
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