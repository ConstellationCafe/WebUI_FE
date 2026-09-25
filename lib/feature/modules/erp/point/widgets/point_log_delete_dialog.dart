import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/point_strings.dart';
import '../constants/point_tokens.dart';
import '../domain/model/point_log.dart';
import '../domain/model/point_member.dart';

part 'point_log_delete_dialog_state.dart';

class PointLogDeleteDialog extends StatefulWidget {
  final PointMember member;
  final PointLog log;
  final Future<bool> Function() onSubmit;

  const PointLogDeleteDialog({
    super.key,
    required this.member,
    required this.log,
    required this.onSubmit,
  });

  @override
  State<PointLogDeleteDialog> createState() => _PointLogDeleteDialogState();
}
