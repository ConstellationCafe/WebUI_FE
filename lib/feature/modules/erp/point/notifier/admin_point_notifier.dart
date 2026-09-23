import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/di/DioProvider.dart';

import '../data/api/admin_point_api.dart';
import '../data/repository/admin_point_repository.dart';
import '../state/admin_point_state.dart';

final adminPointRepositoryProvider = Provider<AdminPointRepository>((ref) {
  return AdminPointRepository(api: AdminPointApi(dio: ref.read(dioProvider)));
});

final adminPointProvider =
    StateNotifierProvider.autoDispose<AdminPointNotifier, AdminPointState>(
      (ref) {
        return AdminPointNotifier(ref.read(adminPointRepositoryProvider))
          ..loadMembers();
      },
    );

class AdminPointNotifier extends StateNotifier<AdminPointState> {
  final AdminPointRepository repository;

  AdminPointNotifier(this.repository) : super(const AdminPointState());

  Future<void> loadMembers({int page = 1, String? search}) async {
    final nextSearch = search ?? state.search;
    state = state.copyWith(
      search: nextSearch,
      isLoadingMembers: true,
      clearError: true,
    );
    try {
      final result = await repository.getMembers(
        page: page,
        discordId: nextSearch,
      );
      state = state.copyWith(
        members: result.items,
        memberPage: result.page,
        memberTotalPages: result.totalPages,
        isLoadingMembers: false,
      );
    } catch (error) {
      state = state.copyWith(isLoadingMembers: false, error: error);
    }
  }

  Future<void> selectMember(String discordId, {int page = 1}) async {
    state = state.copyWith(isLoadingDetail: true, clearError: true);
    try {
      final detail = await repository.getMember(discordId, page: page);
      state = state.copyWith(selected: detail, isLoadingDetail: false);
    } catch (error) {
      state = state.copyWith(isLoadingDetail: false, error: error);
    }
  }

  Future<bool> transact({
    required bool isDeposit,
    required int amount,
    required String description,
  }) async {
    final selected = state.selected;
    if (selected == null || state.isSubmitting) return false;
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      final detail = await repository.transact(
        discordId: selected.member.discordId,
        isDeposit: isDeposit,
        amount: amount,
        description: description,
      );
      state = state.copyWith(selected: detail, isSubmitting: false);
      await loadMembers(page: state.memberPage);
      return true;
    } catch (error) {
      state = state.copyWith(isSubmitting: false, error: error);
      return false;
    }
  }
}
