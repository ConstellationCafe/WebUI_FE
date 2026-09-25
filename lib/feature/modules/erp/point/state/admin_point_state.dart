import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/model/point_member.dart';
import '../domain/model/point_member_detail.dart';

part 'admin_point_state.freezed.dart';

@freezed
abstract class AdminPointState with _$AdminPointState {
  const factory AdminPointState({
    @Default([]) List<PointMember> members,
    PointMemberDetail? selected,
    String? selectedDiscordId,
    @Default('') String searchInput,
    @Default('') String search,
    @Default(1) int memberPage,
    @Default(0) int memberTotalPages,
    @Default(false) bool isLoadingMembers,
    @Default(false) bool isLoadingDetail,
    @Default(false) bool isSubmitting,
    @Default(false) bool hasMembersError,
    @Default(false) bool hasDetailError,
  }) = _AdminPointState;
}
