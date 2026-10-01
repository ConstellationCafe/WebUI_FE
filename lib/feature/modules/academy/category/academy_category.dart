import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_category_section.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_container.dart';

import '../constants/academy_assets.dart';
import '../constants/academy_strings.dart';
import '../notifier/permission_notifier/academy_permission_notifier.dart';

class AcademyCategory extends ConsumerWidget {
  const AcademyCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionState = ref.watch(academyPermissionProvider);
    final permission = permissionState.permission;
    if (!(permission?.isTeacherOrAbove() ?? false)) {
      return const SizedBox.shrink();
    }
    return MenuCategorySection(
      title: AcademyStrings.menuTitle,
      storageKey: 'academy',
      children: [
        MenuContainer(
          iconImage: SvgPicture.asset(
            AcademyAssets.lessonRecordWrite,
            fit: BoxFit.contain,
          ),
          menuName: AcademyStrings.menuWriteLessonRecord,
          callbackUrl: '/academy/write_lesson_record',
        ),
        MenuContainer(
          iconImage: SvgPicture.asset(
            AcademyAssets.lessonRecordRead,
            fit: BoxFit.contain,
          ),
          menuName: AcademyStrings.menuReadLessonRecord,
          callbackUrl: '/academy/read_lesson_record',
        ),
        if (permission?.isOwner() ?? false) ...[
          MenuContainer(
            iconImage: SvgPicture.asset(
              AcademyAssets.teacherManagement,
              fit: BoxFit.contain,
            ),
            menuName: AcademyStrings.menuTeacherManagement,
            callbackUrl: '/academy/teacher_status',
          ),
          MenuContainer(
            iconImage: SvgPicture.asset(
              AcademyAssets.teacherManagement,
              fit: BoxFit.contain,
            ),
            menuName: AcademyStrings.menuReadTeacherStatus,
            callbackUrl: '/academy/read_teacher_status',
          ),
        ],
        MenuContainer(
          iconImage: SvgPicture.asset(
            AcademyAssets.studentManagement,
            fit: BoxFit.contain,
          ),
          menuName: AcademyStrings.menuStudentManagement,
          callbackUrl: '/academy/student_status',
        ),
        MenuContainer(
          iconImage: SvgPicture.asset(
            AcademyAssets.studentManagement,
            fit: BoxFit.contain,
          ),
          menuName: AcademyStrings.menuReadStudentStatus,
          callbackUrl: '/academy/read_student_status',
        ),
      ],
    );
  }
}
