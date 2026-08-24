import 'package:flutter/material.dart';

import '../../../domain/model/academy.dart';

class AcademyDropdown extends StatelessWidget {
  final List<Academy> academies;
  final int? selectedAcademyId;
  final bool isLoading;
  final ValueChanged<Academy> onChanged;

  const AcademyDropdown({
    super.key,
    required this.academies,
    required this.selectedAcademyId,
    required this.isLoading,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int?>(
      initialValue: selectedAcademyId,
      decoration: const InputDecoration(
        labelText: '아카데미',
      ),
      items: [
        const DropdownMenuItem<int?>(
          value: null,
          child: Text('전체'),
        ),
        ...academies.map(
              (academy) => DropdownMenuItem<int?>(
            value: academy.id,
            child: Text(academy.name),
          ),
        ),
      ],
      onChanged: isLoading
          ? null
          : (academyId) {
        if (academyId == null) {
          return;
        }

        final academy = academies.firstWhere(
              (academy) => academy.id == academyId,
        );

        onChanged(academy);
      },
    );
  }
}