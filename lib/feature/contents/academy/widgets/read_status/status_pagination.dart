import 'package:flutter/material.dart';

import '../../constants/academy_constants.dart';

class StatusPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const StatusPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) {
      return const SizedBox.shrink();
    }

    final pages = List.generate(
      totalPages,
          (index) => index + 1,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: AcademyConstants.statusPaginationButtonSize,
          height: AcademyConstants.statusPaginationButtonSize,
          child: IconButton(
            onPressed: currentPage > 1
                ? () {
              onPageChanged(
                currentPage - 1,
              );
            }
                : null,
            icon: const Icon(
              Icons.chevron_left,
            ),
          ),
        ),
        ...pages.map(
              (page) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal:
              AcademyConstants.statusPaginationSpacing,
            ),
            child: SizedBox(
              width: AcademyConstants.statusPaginationButtonSize,
              height: AcademyConstants.statusPaginationButtonSize,
              child: page == currentPage
                  ? FilledButton(
                onPressed: () {
                  onPageChanged(page);
                },
                child: Text(
                  '$page',
                ),
              )
                  : TextButton(
                onPressed: () {
                  onPageChanged(page);
                },
                child: Text(
                  '$page',
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: AcademyConstants.statusPaginationButtonSize,
          height: AcademyConstants.statusPaginationButtonSize,
          child: IconButton(
            onPressed: currentPage < totalPages
                ? () {
              onPageChanged(
                currentPage + 1,
              );
            }
                : null,
            icon: const Icon(
              Icons.chevron_right,
            ),
          ),
        ),
      ],
    );
  }
}