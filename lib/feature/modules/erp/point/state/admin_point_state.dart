import '../domain/model/point_member.dart';
import '../domain/model/point_member_detail.dart';

class AdminPointState {
  final List<PointMember> members;
  final PointMemberDetail? selected;
  final String? selectedDiscordId;
  final String search;
  final int memberPage;
  final int memberTotalPages;
  final bool isLoadingMembers;
  final bool isLoadingDetail;
  final bool isSubmitting;
  final bool hasMembersError;
  final bool hasDetailError;

  const AdminPointState({
    this.members = const [],
    this.selected,
    this.selectedDiscordId,
    this.search = '',
    this.memberPage = 1,
    this.memberTotalPages = 0,
    this.isLoadingMembers = false,
    this.isLoadingDetail = false,
    this.isSubmitting = false,
    this.hasMembersError = false,
    this.hasDetailError = false,
  });

  AdminPointState copyWith({
    List<PointMember>? members,
    PointMemberDetail? selected,
    String? selectedDiscordId,
    bool clearSelected = false,
    String? search,
    int? memberPage,
    int? memberTotalPages,
    bool? isLoadingMembers,
    bool? isLoadingDetail,
    bool? isSubmitting,
    bool? hasMembersError,
    bool? hasDetailError,
  }) {
    return AdminPointState(
      members: members ?? this.members,
      selected: clearSelected ? null : selected ?? this.selected,
      selectedDiscordId: selectedDiscordId ?? this.selectedDiscordId,
      search: search ?? this.search,
      memberPage: memberPage ?? this.memberPage,
      memberTotalPages: memberTotalPages ?? this.memberTotalPages,
      isLoadingMembers: isLoadingMembers ?? this.isLoadingMembers,
      isLoadingDetail: isLoadingDetail ?? this.isLoadingDetail,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      hasMembersError: hasMembersError ?? this.hasMembersError,
      hasDetailError: hasDetailError ?? this.hasDetailError,
    );
  }
}
