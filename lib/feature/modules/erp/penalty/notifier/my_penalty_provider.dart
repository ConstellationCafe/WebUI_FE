import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repository/penalty_repository_provider.dart';
import '../domain/model/penalty_detail.dart';

final myPenaltyProvider = FutureProvider.autoDispose.family<PenaltyDetail, int>(
  (ref, page) async {
    final token = CancelToken();
    ref.onDispose(token.cancel);
    return ref
        .read(penaltyRepositoryProvider)
        .mine(page: page, cancelToken: token);
  },
);
