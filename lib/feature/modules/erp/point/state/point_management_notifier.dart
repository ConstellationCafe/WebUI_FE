import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/di/DioProvider.dart';

import '../data/api/point_management_api.dart';
import '../data/repository/point_management_repository.dart';
import '../domain/point_member.dart';
import '../domain/point_member_detail.dart';
import '../domain/point_page.dart';
import 'point_management_state.dart';

final pointManagementRepositoryProvider =
    Provider<PointManagementRepository>((ref) {
      return PointManagementRepository(
        api: PointManagementApi(dio: ref.watch(dioProvider)),
      );
    });

final pointManagementProvider =
    NotifierProvider<PointManagementNotifier, PointManagementState>(
      PointManagementNotifier.new,
    );

class PointManagementNotifier extends Notifier<PointManagementState> {
  late PointManagementRepository _repository;

  @override
  PointManagementState build() {
    _repository = ref.read(pointManagementRepositoryProvider);
    Future<void>.microtask(() => loadMembers());
    return const PointManagementState();
  }

  void updateDiscordIdSearch(String value) {
    state = state.copyWith(discordIdSearch: value);
  }

  Future<void> loadMembers({int page = 1}) async {
    state = state.copyWith(
      members: const AsyncLoading(),
      memberPage: page,
    );
    try {
      final result = await _repository.getMembers(
        discordId: state.discordIdSearch,
        page: page,
      );
      state = state.copyWith(members: AsyncData(result));
    } catch (error, stackTrace) {
      state = state.copyWith(members: AsyncError(error, stackTrace));
    }
  }

  Future<void> selectMember(PointMember member) async {
    state = state.copyWith(
      selectedDiscordId: member.discordId,
      detail: const AsyncLoading(),
    );
    await _loadMemberDetail(member.discordId, page: 1);
  }

  Future<void> changeLogPage(int page) async {
    final discordId = state.selectedDiscordId;
    final detail = state.detail?.valueOrNull;
    if (discordId == null || detail == null) {
      return;
    }
    await _loadMemberDetail(discordId, page: page);
  }

  Future<void> adjustPoint({
    required String type,
    required int amount,
    required String description,
  }) async {
    final discordId = state.selectedDiscordId;
    if (discordId == null || state.isSubmitting) {
      return;
    }
    state = state.copyWith(isSubmitting: true);
    try {
      await _repository.adjustPoint(
        discordId: discordId,
        type: type,
        amount: amount,
        description: description,
      );
      await loadMembers(page: state.memberPage);
      await _loadMemberDetail(discordId, page: 1);
    } finally {
      state = state.copyWith(isSubmitting: false);
    }
  }

  Future<void> _loadMemberDetail(String discordId, {required int page}) async {
    state = state.copyWith(detail: const AsyncLoading());
    try {
      final PointMemberDetail detail = await _repository.getMemberDetail(
        discordId: discordId,
        page: page,
      );
      state = state.copyWith(detail: AsyncData(detail));
    } catch (error, stackTrace) {
      state = state.copyWith(detail: AsyncError(error, stackTrace));
    }
  }
}
