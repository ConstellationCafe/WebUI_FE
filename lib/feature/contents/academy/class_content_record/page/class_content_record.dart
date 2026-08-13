import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import '../notifier/academy_notifier.dart';
import '../widgets/academy_basic_info.dart';
import '../widgets/academy_member_selector.dart';
import '../widgets/academy_teacher_info.dart';
import '../widgets/lesson_description.dart';

class LessonRecordPage extends ConsumerWidget {
  const LessonRecordPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(academyProvider);
    final notifier =
    ref.read(academyProvider.notifier);

    final width = MediaQuery.sizeOf(context).width;

    final deviceType =
    ScreenWidth.widthChecker(width);

    final isMobile =
        deviceType == 'mobileWidth';

    if (state.isLoading &&
        state.academies.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      backgroundColor:
      Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile
                ? ConstPadding.mediumPadding
                : ConstPadding.largePadding,
            vertical: ConstPadding.mediumPadding,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1100,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  _breadcrumb(context),

                  const SizedBox(
                    height: ConstPadding.smallPadding,
                  ),

                  _header(
                    context,
                    notifier,
                    state.isSaving,
                    isMobile,
                  ),

                  const SizedBox(
                    height: ConstPadding.mediumPadding,
                  ),

                  AcademyBasicInfo(
                    state: state,
                  ),

                  AcademyTeacherInfo(
                    state: state,
                  ),

                  AcademyMemberSelector(
                    state: state,
                  ),

                  LessonDescription(
                    description: state.description,
                  ),

                  const SizedBox(
                    height: ConstPadding.mediumPadding,
                  ),

                  _bottomActions(
                    context,
                    notifier,
                    state.isSaving,
                    isMobile,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _breadcrumb(BuildContext context) {
    return Row(
      children: [
        Text(
          '수업 관리',
          style: Theme.of(context)
              .textTheme
              .bodySmall,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Icon(
            Icons.chevron_right,
            size: 16,
          ),
        ),
        Text(
          '수업 내용 기록',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _header(
      BuildContext context,
      dynamic notifier,
      bool isSaving,
      bool isMobile,
      ) {
    if (isMobile) {
      return Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            '수업 내용 기록',
            style: Theme.of(context)
                .textTheme
                .headlineMedium,
          ),
          const SizedBox(
            height: ConstPadding.tinyPadding,
          ),
          Text(
            '수업의 기본 정보를 입력하고 함께한 교사와 멤버를 선택해주세요.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium,
          ),
          const SizedBox(
            height: ConstPadding.mediumPadding,
          ),
          _saveButton(
            context,
            notifier,
            isSaving,
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                '수업 내용 기록',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium,
              ),
              const SizedBox(
                height: ConstPadding.tinyPadding,
              ),
              Text(
                '수업의 기본 정보를 입력하고 함께한 교사와 멤버를 선택해주세요.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(
          width: ConstPadding.mediumPadding,
        ),
        OutlinedButton(
          onPressed: isSaving
              ? null
              : () => context.pop(),
          child: const Text('취소'),
        ),
        const SizedBox(
          width: ConstPadding.smallPadding,
        ),
        _saveButton(
          context,
          notifier,
          isSaving,
        ),
      ],
    );
  }

  Widget _saveButton(
      BuildContext context,
      dynamic notifier,
      bool isSaving,
      ) {
    return ElevatedButton.icon(
      onPressed: isSaving
          ? null
          : () async {
        final success =
        await notifier.saveLessonRecord();

        if (!context.mounted) {
          return;
        }

        if (success) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
              content: Text(
                '수업 기록이 저장되었습니다.',
              ),
            ),
          );

          context.pop();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
              content: Text(
                '필수 항목을 확인해주세요.',
              ),
            ),
          );
        }
      },
      icon: isSaving
          ? const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      )
          : const Icon(
        Icons.save_outlined,
      ),
      label: Text(
        isSaving ? '저장 중...' : '저장하기',
      ),
    );
  }

  Widget _bottomActions(
      BuildContext context,
      dynamic notifier,
      bool isSaving,
      bool isMobile,
      ) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton(
            onPressed: isSaving
                ? null
                : () => context.pop(),
            child: const Text('취소'),
          ),
          const SizedBox(
            width: ConstPadding.smallPadding,
          ),
          _saveButton(
            context,
            notifier,
            isSaving,
          ),
        ],
      ),
    );
  }
}