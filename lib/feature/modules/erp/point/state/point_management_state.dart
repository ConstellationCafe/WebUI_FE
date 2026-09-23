import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/point_member.dart';
import '../domain/point_member_detail.dart';
import '../domain/point_page.dart';

class PointManagementState {
  final AsyncValue<PointPage<PointMember>> members;
  final String discordIdSearch;
  final int memberPage;
  final String? selectedDiscordId;
  final AsyncValue<PointMemberDetail>? detail;
  final bool isSubmitting;

  const PointManagementState({
    this.members = const AsyncLoading(),
    this.discordIdSearch = '',
    this.memberPage = 1,
    this.selectedDiscordId,
    this.detail,
    this.isSubmitting = false,
  });

  PointManagementState copyWith({
    AsyncValue<PointPage<PointMember>>? members,
    String? discordIdSearch,
    int? memberPage,
    String? selectedDiscordId,
    bool clearSelectedDiscordId = false,
    AsyncValue<PointMemberDetail>? detail,
    bool clearDetail = false,
    bool? isSubmitting,
  }) {
    return PointManagementState(
      members: members ?? this.members,
      discordIdSearch: discordIdSearch ?? this.discordIdSearch,
      memberPage: memberPage ?? this.memberPage,
      selectedDiscordId: clearSelectedDiscordId
          ? null
          : selectedDiscordId ?? this.selectedDiscordId,
      detail: clearDetail ? null : detail ?? this.detail,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
