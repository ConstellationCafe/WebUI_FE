import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/model/penalty_detail.dart';
import '../domain/model/penalty_log.dart';
import '../domain/model/penalty_member.dart';
import '../domain/model/penalty_page.dart';
import '../domain/type/penalty_history_sort.dart';

part 'admin_penalty_state.freezed.dart';

@freezed
abstract class AdminPenaltyState with _$AdminPenaltyState {
  const factory AdminPenaltyState({
    PenaltyPage<PenaltyLog>? history,
    PenaltyPage<PenaltyMember>? members,
    PenaltyDetail? selected,
    String? selectedId,
    @Default('') String channelId,
    @Default('') String discordId,
    @Default('') String rankingSearch,
    @Default(PenaltyHistorySort.newest) String sort,
    @Default(true) bool isHistoryLoading,
    @Default(true) bool isMembersLoading,
    @Default(false) bool isDetailLoading,
    @Default(false) bool isSubmitting,
    @Default(false) bool hasHistoryError,
    @Default(false) bool hasMembersError,
    @Default(false) bool hasDetailError,
    String? submissionError,
  }) = _AdminPenaltyState;
}
