
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/data/api/backend/repository/RepositoryInterface.dart';
import 'package:constellation_cafe/data/api/backend/repository/chatbot/LearningRepository.dart';
import 'package:constellation_cafe/data/api/backend/repository/chatbot/MenuRepository.dart';
import 'package:constellation_cafe/data/api/backend/repository/chatbot/MusicRepository.dart';
import 'package:constellation_cafe/data/api/backend/repository/chatbot/ContentRepository.dart';
import 'package:constellation_cafe/data/api/backend/repository/membership/PointRepository.dart';
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