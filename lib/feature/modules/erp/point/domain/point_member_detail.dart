import 'point_log.dart';
import 'point_member.dart';
import 'point_page.dart';

class PointMemberDetail {
  final PointMember member;
  final PointPage<PointLog> logs;

  const PointMemberDetail({required this.member, required this.logs});
}
