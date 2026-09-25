import 'point_member.dart';

class PointMemberPage {
  final List<PointMember> items;
  final int page;
  final int totalPages;

  const PointMemberPage({
    required this.items,
    required this.page,
    required this.totalPages,
  });
}
