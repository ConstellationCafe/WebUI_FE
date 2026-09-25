import 'point_log.dart';
import 'point_member.dart';

class PointMemberDetail {
  final PointMember member;
  final List<PointLog> logs;
  final int page;
  final int totalPages;

  const PointMemberDetail({
    required this.member,
    required this.logs,
    required this.page,
    required this.totalPages,
  });
}
