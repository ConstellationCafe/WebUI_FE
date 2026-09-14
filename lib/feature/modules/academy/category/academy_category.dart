import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import '../../../home/frame/widgets/menu_bar_area/categories/container/menu_container.dart';
import '../notifier/permission_notifier/academy_permission_notifier.dart';

class AcademyCategory extends ConsumerWidget {
  const AcademyCategory({super.key});

  @override
  Widget build(BuildContext build, WidgetRef ref) {
    final permissionState = ref.watch(academyPermissionProvider);
    final permission = permissionState.permission;
    if (permission?.isTeacherOrAbove() ?? false) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                textAlign: TextAlign.left,
                "아카데미 메뉴"
            ),
            SizedBox(height: ConstSize.tinyWidth),
            MenuContainer(
              iconImage: SvgPicture.asset(
                  "assets/icons/modules/academy/lesson_record_write.svg",
                  fit: BoxFit.contain
              ),
              menuName: "수업 기록",
              callbackUrl: "/academy/write_lesson_record",
            ),
            MenuContainer(
              iconImage: SvgPicture.asset(
                  "assets/icons/modules/academy/lesson_record_read.svg",
                  fit: BoxFit.contain
              ),
              menuName: "수업 기록 조회",
              callbackUrl: "/academy/read_lesson_record",
            ),
            if (permission?.isOwner() ?? false) ... [
              MenuContainer(
                iconImage: SvgPicture.asset(
                    "assets/icons/modules/academy/teacher_hr.svg",
                    fit: BoxFit.contain
                ),
                menuName: "교사 관리",
                callbackUrl: "/academy/teacher_status",
              ),
              MenuContainer(
                iconImage: SvgPicture.asset(
                    "assets/icons/modules/academy/teacher_hr.svg",
                    fit: BoxFit.contain
                ),
                menuName: "교사 조회",
                callbackUrl: "/academy/read_teacher_status",
              ),
            ],
            MenuContainer(
              iconImage: SvgPicture.asset(
                  "assets/icons/modules/academy/student_hr.svg",
                  fit: BoxFit.contain
              ),
              menuName: "학생 관리",
              callbackUrl: "/academy/student_status",
            ),
            MenuContainer(
              iconImage: SvgPicture.asset(
                  "assets/icons/modules/academy/student_hr.svg",
                  fit: BoxFit.contain
              ),
              menuName: "학생 조회",
              callbackUrl: "/academy/read_student_status",
            )
          ]
      );
    } else {
      return Column();
    }
  }
}