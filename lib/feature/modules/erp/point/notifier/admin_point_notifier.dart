import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/di/DioProvider.dart';

import '../data/api/admin_point_api.dart';
import '../data/repository/admin_point_repository.dart';
import '../state/admin_point_state.dart';

final adminPointRepositoryProvider = Provider<AdminPointRepository>((ref) {
  return AdminPointRepository(api: AdminPointApi(dio: ref.read(dioProvider)));
});

final adminPointProvider =
    NotifierProvider.autoDispose<AdminPointNotifier, AdminPointState>(
      AdminPointNotifier.new,
    );

class AdminPointNotifier extends Notifier<AdminPointState> {
  late AdminPointRepository _repository;
  int _membersRequest = 0;
  int _detailRequest = 0;

  @override
  AdminPointState build() {
    _repository = ref.read(adminPointRepositoryProvider);
    scheduleMicrotask(() {
      if (ref.mounted && _membersRequest == 0) unawaited(loadMembers());
    });
    return const AdminPointState(isLoadingMembers: true);
  }

  Future<void> loadMembers({int page = 1, String? search}) async {
    if (!ref.mounted) return;
    final request = ++_membersRequest;
    final nextSearch = search ?? state.search;
    state = state.copyWith(
      search: nextSearch,
      isLoadingMembers: true,
      hasMembersError: false,
    );
    try {
      final result = await _repository.getMembers(
        page: page,
        discordId: nextSearch,
      );
      if (!ref.mounted || request != _membersRequest) return;
      state = state.copyWith(
        members: result.items,
        memberPage: result.page,
        memberTotalPages: result.totalPages,
        isLoadingMembers: false,
      );
    } catch (_) {
      if (!ref.mounted || request != _membersRequest) return;
      state = state.copyWith(isLoadingMembers: false, hasMembersError: true);
    }
  }

  Future<void> selectMember(String discordId, {int page = 1}) async {
    if (!ref.mounted || state.isSubmitting) return;
    final request = ++_detailRequest;
    state = state.copyWith(
      selectedDiscordId: discordId,
      clearSelected: state.selected?.member.discordId != discordId,
      isLoadingDetail: true,
      hasDetailError: false,
    );
    try {
      final detail = await _repository.getMember(discordId, page: page);
      if (!ref.mounted || request != _detailRequest) return;
      state = state.copyWith(selected: detail, isLoadingDetail: false);
    } catch (_) {
      if (!ref.mounted || request != _detailRequest) return;
      state = state.copyWith(isLoadingDetail: false, hasDetailError: true);
    }
  }

  Future<bool> transact({
    required String discordId,
    required bool isDeposit,
    required int amount,
    required String description,
  }) async {
    if (!ref.mounted) return false;
    if (state.selected?.member.discordId != discordId ||
        state.isSubmitting ||
        state.isLoadingDetail ||
        state.hasDetailError) {
      return false;
    }
    state = state.copyWith(isSubmitting: true);
    try {
      final detail = await _repository.transact(
        discordId: discordId,
        isDeposit: isDeposit,
        amount: amount,
        description: description,
      );
      if (!ref.mounted) return true;
      state = state.copyWith(selected: detail, isSubmitting: false);
      unawaited(loadMembers(page: state.memberPage));
      return true;
    } catch (_) {
      if (ref.mounted) state = state.copyWith(isSubmitting: false);
      return false;
    }
  }
}
