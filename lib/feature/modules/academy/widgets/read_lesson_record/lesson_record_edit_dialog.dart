import 'package:flutter/material.dart';

import 'package:constellation_cafe/shared/widgets/date_time/app_time_picker.dart';

import '../../constants/academy_constants.dart';
import '../../constants/academy_strings.dart';
import '../../domain/model/lesson_record/lesson_record_update.dart';
import '../../domain/model/lesson_record/lesson_record_view.dart';
import '../../domain/model/lesson_record/lesson_time_range.dart';

class LessonRecordEditDialog extends StatefulWidget {
  final LessonRecordView record;

  const LessonRecordEditDialog({super.key, required this.record});

  @override
  State<LessonRecordEditDialog> createState() => _LessonRecordEditDialogState();
}

class _LessonRecordEditDialogState extends State<LessonRecordEditDialog> {
  late final TextEditingController _subjectController;
  late final TextEditingController _descriptionController;
  late DateTime _educationDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;

  @override
  void initState() {
    super.initState();
    _subjectController = TextEditingController(text: widget.record.subjectName);
    _descriptionController = TextEditingController(
      text: widget.record.description,
    );
    _educationDate = widget.record.educationDate;
    _startTime = widget.record.startTime != null
        ? TimeOfDay.fromDateTime(widget.record.startTime!)
        : AcademyConstants.defaultLessonStartTime;
    _endTime = widget.record.endTime != null
        ? TimeOfDay.fromDateTime(widget.record.endTime!)
        : TimeOfDay(
            hour: (_startTime.hour + 1) % TimeOfDay.hoursPerDay,
            minute: _startTime.minute,
          );
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AcademyStrings.editLessonRecord),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: AcademyStrings.subject,
              ),
            ),
            const SizedBox(height: AcademyConstants.editDialogFieldGap),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(AcademyStrings.lessonDate),
              subtitle: Text(AcademyStrings.formatCompactDate(_educationDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: _selectDate,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(AcademyStrings.startTime),
              subtitle: Text(_startTime.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: _selectStartTime,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(AcademyStrings.endTime),
              subtitle: Text(_endTime.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: _selectEndTime,
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: AcademyStrings.lessonContent,
              ),
              minLines: AcademyConstants.editDescriptionMinLines,
              maxLines: AcademyConstants.editDescriptionMaxLines,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AcademyStrings.cancel),
        ),
        FilledButton(
          onPressed: _save,
          child: const Text(AcademyStrings.saveShort),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _educationDate,
      firstDate: AcademyConstants.firstEditableDate,
      lastDate: AcademyConstants.lastSelectableDate,
    );
    if (date != null) {
      setState(() => _educationDate = date);
    }
  }

  Future<void> _selectStartTime() async {
    final time = await showAppTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (time != null) {
      setState(() => _startTime = time);
    }
  }

  Future<void> _selectEndTime() async {
    final time = await showAppTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (time != null) {
      setState(() => _endTime = time);
    }
  }

  void _save() {
    final startMinutes =
        _startTime.hour * TimeOfDay.minutesPerHour + _startTime.minute;
    final endMinutes =
        _endTime.hour * TimeOfDay.minutesPerHour + _endTime.minute;
    // 종료가 시작보다 이르면 자정을 넘긴 수업으로 본다.
    if (_subjectController.text.trim().isEmpty ||
        !LessonTimeRange.isValidMinutes(startMinutes, endMinutes)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AcademyStrings.invalidLessonUpdate)),
      );
      return;
    }

    DateTime atTime(TimeOfDay time) => DateTime(
      _educationDate.year,
      _educationDate.month,
      _educationDate.day,
      time.hour,
      time.minute,
    );

    Navigator.of(context).pop(
      LessonRecordUpdate(
        subject: _subjectController.text.trim(),
        educationDate: _educationDate,
        startTime: atTime(_startTime),
        endTime: atTime(_endTime),
        description: _descriptionController.text.trim(),
      ),
    );
  }
}
