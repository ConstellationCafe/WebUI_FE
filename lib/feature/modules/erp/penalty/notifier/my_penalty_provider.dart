import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/repository/penalty_repository_provider.dart';
import '../domain/model/penalty_detail.dart';

part 'my_penalty_provider.g.dart';

/// 로그인한 회원의 벌점 상세. 페이지별로 조회하고 화면을 벗어나면 요청을 취소한다.
@riverpod
Future<PenaltyDetail> myPenalty(Ref ref, int page) async {
  final token = CancelToken();
  ref.onDispose(token.cancel);
  return ref
      .read(penaltyRepositoryProvider)
      .mine(page: page, cancelToken: token);
}
