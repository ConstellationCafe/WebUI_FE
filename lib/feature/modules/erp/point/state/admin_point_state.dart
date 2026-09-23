import '../domain/model/point_member.dart';
import '../domain/model/point_member_detail.dart';

class AdminPointState {
  final List<PointMember> members;
  final PointMemberDetail? selected;
  final String search;
  final int memberPage;
  final int memberTotalPages;
  final bool isLoadingMembers;
  final bool isLoadingDetail;
  final bool isSubmitting;
  final Object? error;

  const AdminPointState({
    this.members = const [],
    this.selected,
    this.search = '',
    this.memberPage = 1,
    this.memberTotalPages = 0,
    this.isLoadingMembers = false,
    this.isLoadingDetail = false,
    this.isSubmitting = false,
    this.error,
  });

  AdminPointState copyWith({
    List<PointMember>? members,
    PointMemberDetail? selected,
    String? search,
    int? memberPage,
    int? memberTotalPages,
    bool? isLoadingMembers,
    bool? isLoadingDetail,
    bool? isSubmitting,
    Object? error,
    bool clearError = false,
  }) {
    return AdminPointState(
      members: members ?? this.members,
      selected: selected ?? this.selected,
      search: search ?? this.search,
      memberPage: memberPage ?? this.memberPage,
      memberTotalPages: memberTotalPages ?? this.memberTotalPages,
      isLoadingMembers: isLoadingMembers ?? this.isLoadingMembers,
      isLoadingDetail: isLoadingDetail ?? this.isLoadingDetail,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: clearError ? null : error ?? this.error,
    );
  }
}
