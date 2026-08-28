import 'package:freezed_annotation/freezed_annotation.dart';

import '../academy.dart';
import '../academy_class.dart';
import '../academy_member.dart';

import '../../type/roster_status.dart';

part 'status_query.freezed.dart';

@freezed
class StatusQuery<
  TMember extends AcademyMember,
  TStatus extends RosterStatus
> with _$StatusQuery<TMember, TStatus> {
  const StatusQuery._();

  const factory StatusQuery({
    @Default([])
    List<Academy> academies,

    @Default([])
    List<AcademyClass> classes,

    @Default([])
    List<TMember> academyMembers,

    Academy? selectedAcademy,

    AcademyClass? selectedAcademyClass,

    TMember? selectedAcademyMember,

    TStatus? selectedStatus,

    @Default(1)
    int page,

    @Default(20)
    int pageSize,
  }) = _StatusQuery<TMember, TStatus>;
}