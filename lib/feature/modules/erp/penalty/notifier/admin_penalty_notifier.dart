import 'dart:async';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/penalty_strings.dart';
import '../data/dto/request/penalty_create_request.dart';
import '../data/repository/penalty_repository.dart';
import '../data/repository/penalty_repository_provider.dart';
import '../state/admin_penalty_state.dart';

part 'admin_penalty_notifier.g.dart';

@riverpod
class AdminPenaltyNotifier extends _$AdminPenaltyNotifier {
  late PenaltyRepository _repository;
  int _historyRequest = 0;
  int _membersRequest = 0;
  int _detailRequest = 0;
  CancelToken? _historyToken;
  CancelToken? _membersToken;
  CancelToken? _detailToken;

  @override
  AdminPenaltyState build() {
    _repository = ref.read(penaltyRepositoryProvider);
    ref.onDispose(() {
      _historyToken?.cancel();
      _membersToken?.cancel();
      _detailToken?.cancel();
    });
    scheduleMicrotask(() {
      if (ref.mounted && _historyRequest == 0) unawaited(loadHistory());
      if (ref.mounted && _membersRequest == 0) unawaited(loadMembers());
    });
    return const AdminPenaltyState();
  }

  Future<void> loadHistory({
    int page = 1,
    String? channelId,
    String? discordId,
    String? sort,
  }) async {
    if (!ref.mounted) return;
    final request = ++_historyRequest;
    _historyToken?.cancel();
    final token = _historyToken = CancelToken();
    final nextChannel = channelId ?? state.channelId;
    final nextDiscord = discordId ?? state.discordId;
    final nextSort = sort ?? state.sort;
    state = state.copyWith(
      channelId: nextChannel,
      discordId: nextDiscord,
      sort: nextSort,
      isHistoryLoading: true,
      hasHistoryError: false,
    );
    try {
      final history = await _repository.history(
        channelId: nextChannel,
        discordId: nextDiscord,
        sort: nextSort,
        page: page,
        cancelToken: token,
      );
      if (!ref.mounted || request != _historyRequest) return;
      state = state.copyWith(history: history, isHistoryLoading: false);
    } catch (_) {
      if (!ref.mounted || request != _historyRequest) return;
      state = state.copyWith(isHistoryLoading: false, hasHistoryError: true);
    }
  }

  Future<void> loadMembers({int page = 1, String? discordId}) async {
    if (!ref.mounted) return;
    final request = ++_membersRequest;
    _membersToken?.cancel();
    final token = _membersToken = CancelToken();
    final search = discordId ?? state.rankingSearch;
    state = state.copyWith(
      rankingSearch: search,
      isMembersLoading: true,
      hasMembersError: false,
    );
    try {
      final members = await _repository.members(
        discordId: search,
        page: page,
        cancelToken: token,
      );
      if (!ref.mounted || request != _membersRequest) return;
      state = state.copyWith(members: members, isMembersLoading: false);
    } catch (_) {
      if (!ref.mounted || request != _membersRequest) return;
      state = state.copyWith(isMembersLoading: false, hasMembersError: true);
    }
  }

  Future<void> selectMember(String discordId, {int page = 1}) async {
    if (!ref.mounted || state.isSubmitting) return;
    final request = ++_detailRequest;
    _detailToken?.cancel();
    final token = _detailToken = CancelToken();
    state = state.copyWith(
      selectedId: discordId,
      selected: state.selectedId == discordId ? state.selected : null,
      isDetailLoading: true,
      hasDetailError: false,
    );
    try {
      final detail = await _repository.member(
        discordId,
        page: page,
        cancelToken: token,
      );
      if (!ref.mounted || request != _detailRequest) return;
      state = state.copyWith(selected: detail, isDetailLoading: false);
    } catch (_) {
      if (!ref.mounted || request != _detailRequest) return;
      state = state.copyWith(isDetailLoading: false, hasDetailError: true);
    }
  }

  Future<bool> award(PenaltyCreateRequest request) async {
    if (!ref.mounted || state.isSubmitting) return false;
    state = state.copyWith(isSubmitting: true, submissionError: null);
    try {
      final detail = await _repository.award(request);
      if (!ref.mounted) return true;
      ++_detailRequest;
      _detailToken?.cancel();
      state = state.copyWith(
        selectedId: detail.discordId,
        selected: detail,
        isDetailLoading: false,
        hasDetailError: false,
        isSubmitting: false,
      );
      unawaited(loadHistory(page: state.history?.page ?? 1));
      unawaited(loadMembers(page: state.members?.page ?? 1));
      return true;
    } catch (_) {
      if (ref.mounted) {
        state = state.copyWith(
          isSubmitting: false,
          submissionError: PenaltyStrings.submitFailed,
        );
      }
      return false;
    }
  }

  Future<bool> cancel(int penaltyId, String reason) async {
    if (!ref.mounted || state.isSubmitting) return false;
    state = state.copyWith(isSubmitting: true, submissionError: null);
    try {
      final detail = await _repository.cancel(penaltyId, reason);
      if (!ref.mounted) return true;
      ++_detailRequest;
      _detailToken?.cancel();
      state = state.copyWith(
        selectedId: detail.discordId,
        selected: detail,
        isDetailLoading: false,
        hasDetailError: false,
        isSubmitting: false,
      );
      unawaited(loadHistory(page: state.history?.page ?? 1));
      unawaited(loadMembers(page: state.members?.page ?? 1));
      return true;
    } catch (_) {
      if (ref.mounted) {
        state = state.copyWith(
          isSubmitting: false,
          submissionError: PenaltyStrings.cancelFailed,
        );
      }
      return false;
    }
  }
}
