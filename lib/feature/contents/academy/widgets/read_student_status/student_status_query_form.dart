import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';
import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/student.dart';
import '../../domain/type/student_roster_status.dart';

class StudentStatusQueryForm extends StatelessWidget {
  final List<Academy> academies;
  final List<AcademyClass> classes;
  final List<Student> students;

  final Academy? selectedAcademy;
  final AcademyClass? selectedAcademyClass;
  final Student? selectedStudent;
  final StudentRosterStatus? selectedStatus;

  final bool isLoading;

  final ValueChanged<Academy?> onAcademyChanged;
  final ValueChanged<AcademyClass?> onClassChanged;
  final ValueChanged<Student?> onStudentChanged;
  final ValueChanged<StudentRosterStatus?> onStatusChanged;

  final VoidCallback onReset;
  final VoidCallback onSearch;

  const StudentStatusQueryForm({
    super.key,
    required this.academies,
    required this.classes,
    required this.students,
    required this.selectedAcademy,
    required this.selectedAcademyClass,
    required this.selectedStudent,
    required this.selectedStatus,
    required this.isLoading,
    required this.onAcademyChanged,
    required this.onClassChanged,
    required this.onStudentChanged,
    required this.onStatusChanged,
    required this.onReset,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: ConstPadding.largePaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.filter_alt_outlined,
                ),
                const SizedBox(
                  width: ConstPadding.smallPadding,
                ),
                Text(
                  '조회 조건',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
              ],
            ),
            const SizedBox(
              height: ConstPadding.largePadding,
            ),

            Wrap(
              spacing:
              AcademyConstants.studentStatusFilterSpacing,
              runSpacing:
              AcademyConstants.studentStatusFilterRunSpacing,
              children: [
                SizedBox(
                  width: AcademyConstants
                      .studentStatusFilterFieldWidth,
                  child: DropdownButtonFormField<Academy?>(
                    value: selectedAcademy,
                    decoration: const InputDecoration(
                      labelText: '아카데미',
                    ),
                    items: [
                      const DropdownMenuItem<Academy?>(
                        value: null,
                        child: Text(
                          '전체 아카데미',
                        ),
                      ),
                      ...academies.map(
                            (academy) =>
                            DropdownMenuItem<Academy?>(
                              value: academy,
                              child: Text(
                                academy.name,
                              ),
                            ),
                      ),
                    ],
                    onChanged: isLoading
                        ? null
                        : onAcademyChanged,
                  ),
                ),
                SizedBox(
                  width: AcademyConstants
                      .studentStatusFilterFieldWidth,
                  child:
                  DropdownButtonFormField<AcademyClass?>(
                    value: selectedAcademyClass,
                    decoration: const InputDecoration(
                      labelText: '분반',
                    ),
                    items: [
                      const DropdownMenuItem<
                          AcademyClass?>(
                        value: null,
                        child: Text(
                          '전체 분반',
                        ),
                      ),
                      ...classes.map(
                            (academyClass) =>
                            DropdownMenuItem<
                                AcademyClass?>(
                              value: academyClass,
                              child: Text(
                                '${academyClass.classNumber}분반',
                              ),
                            ),
                      ),
                    ],
                    onChanged:
                    selectedAcademy == null ||
                        isLoading
                        ? null
                        : onClassChanged,
                  ),
                ),
                SizedBox(
                  width: AcademyConstants
                      .studentStatusFilterFieldWidth,
                  child:
                  DropdownButtonFormField<Student?>(
                    value: selectedStudent,
                    decoration: const InputDecoration(
                      labelText: '학생',
                    ),
                    items: [
                      const DropdownMenuItem<Student?>(
                        value: null,
                        child: Text(
                          '전체 학생',
                        ),
                      ),
                      ...students.map(
                            (student) =>
                            DropdownMenuItem<Student?>(
                              value: student,
                              child: Text(
                                student.name,
                              ),
                            ),
                      ),
                    ],
                    onChanged:
                    selectedAcademyClass == null ||
                        isLoading
                        ? null
                        : onStudentChanged,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: ConstPadding.largePadding,
            ),

            Text(
              '학생 상태',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge,
            ),
            const SizedBox(
              height: ConstPadding.smallPadding,
            ),

            Wrap(
              spacing:
              AcademyConstants.studentStatusFilterSpacing,
              runSpacing:
              AcademyConstants.studentStatusFilterRunSpacing,
              children: [
                ChoiceChip(
                  label: const Text('전체'),
                  selected: selectedStatus == null,
                  onSelected: isLoading
                      ? null
                      : (_) {
                    onStatusChanged(null);
                  },
                ),
                ChoiceChip(
                  label: const Text('재적'),
                  selected: selectedStatus ==
                      StudentRosterStatus.enrolled,
                  onSelected: isLoading
                      ? null
                      : (_) {
                    onStatusChanged(
                      StudentRosterStatus.enrolled,
                    );
                  },
                ),
                ChoiceChip(
                  label: const Text('졸업'),
                  selected: selectedStatus ==
                      StudentRosterStatus.graduation,
                  onSelected: isLoading
                      ? null
                      : (_) {
                    onStatusChanged(
                      StudentRosterStatus.graduation,
                    );
                  },
                ),
                ChoiceChip(
                  label: const Text('퇴학'),
                  selected: selectedStatus ==
                      StudentRosterStatus.expulsion,
                  onSelected: isLoading
                      ? null
                      : (_) {
                    onStatusChanged(
                      StudentRosterStatus.expulsion,
                    );
                  },
                ),
                ChoiceChip(
                  label: const Text('자퇴'),
                  selected: selectedStatus ==
                      StudentRosterStatus.withdrawal,
                  onSelected: isLoading
                      ? null
                      : (_) {
                    onStatusChanged(
                      StudentRosterStatus.withdrawal,
                    );
                  },
                ),
                ChoiceChip(
                  label: const Text('은퇴'),
                  selected: selectedStatus ==
                      StudentRosterStatus.retirement,
                  onSelected: isLoading
                      ? null
                      : (_) {
                    onStatusChanged(
                      StudentRosterStatus.retirement,
                    );
                  },
                ),
                ChoiceChip(
                  label: const Text('징계'),
                  selected: selectedStatus ==
                      StudentRosterStatus.disciplinary,
                  onSelected: isLoading
                      ? null
                      : (_) {
                    onStatusChanged(
                      StudentRosterStatus.disciplinary,
                    );
                  },
                ),
              ],
            ),

            const SizedBox(
              height: ConstPadding.largePadding,
            ),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed:
                  isLoading ? null : onReset,
                  icon: const Icon(
                    Icons.refresh,
                  ),
                  label: const Text(
                    '초기화',
                  ),
                ),
                const SizedBox(
                  width: ConstPadding.smallPadding,
                ),
                FilledButton.icon(
                  onPressed:
                  isLoading ? null : onSearch,
                  icon: isLoading
                      ? const SizedBox(
                    width: AcademyConstants
                        .savingIndicatorSize,
                    height: AcademyConstants
                        .savingIndicatorSize,
                    child:
                    CircularProgressIndicator(
                      strokeWidth:
                      AcademyConstants
                          .savingIndicatorStrokeWidth,
                    ),
                  )
                      : const Icon(
                    Icons.search,
                  ),
                  label: const Text(
                    '조회',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}