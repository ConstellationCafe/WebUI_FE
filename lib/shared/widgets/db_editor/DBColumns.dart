import 'package:flutter/material.dart';

import 'package:constellation_cafe/shared/model/db_editor/DBColumn.dart';

import '../../controller/db_editor/DBController.dart';

class DBColumns extends StatelessWidget {
  final DBController controller;

  const DBColumns({
    super.key,
    required this.controller,
  });

  Future<void> _sort(
      BuildContext context,
      String columnName,
      ) async {
    try {
      await controller.sort(
        columnName,
      );
    } catch (e) {
      if (!context.mounted) {
        return;
      }

      final message = e is StateError
          ? e.message.toString()
          : e.toString();

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }

  Widget _sortIcon(
      DBColumn column,
      ) {
    switch (column.sortDir) {
      case Toggle.asc:
        return const Icon(
          Icons.arrow_upward,
          size: 14,
        );

      case Toggle.desc:
        return const Icon(
          Icons.arrow_downward,
          size: 14,
        );

      case Toggle.none:
        return const SizedBox(
          width: 14,
        );
    }
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    return AnimatedBuilder(
      animation: controller,
      builder: (
          context,
          _,
          ) {
        if (controller.countColumn == 0) {
          return const SizedBox();
        }

        return Table(
          border: TableBorder.all(
            width: 1,
            color: Colors.grey,
          ),
          children: [
            TableRow(
              children:
              controller.model.columns
                  .map(
                    (column) {
                  return InkWell(
                    onTap:
                    controller.isLoading
                        ? null
                        : () {
                      _sort(
                        context,
                        column
                            .toString(),
                      );
                    },
                    child: Container(
                      height: 40,
                      alignment:
                      Alignment.center,
                      padding:
                      const EdgeInsets
                          .symmetric(
                        horizontal: 4,
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        children: [
                          Flexible(
                            child: Text(
                              column
                                  .toString(),
                              overflow:
                              TextOverflow
                                  .ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          _sortIcon(
                            column,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        );
      },
    );
  }
}