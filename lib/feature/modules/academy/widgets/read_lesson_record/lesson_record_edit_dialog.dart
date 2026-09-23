import 'package:flutter/material.dart';

import '../../domain/model/lesson_record_update.dart';
import '../../domain/model/lesson_record_view.dart';

class LessonRecordEditDialog extends StatefulWidget {
  final LessonRecordView record;

  const LessonRecordEditDialog({super.key, required this.record});

  @override
  State<LessonRecordEditDialog> createState() =>
      _LessonRecordEditDialogState();
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
        : const TimeOfDay(hour: 10, minute: 0);
    _endTime = widget.record.endTime != null
        ? TimeOfDay.fromDateTime(widget.record.endTime!)
        : TimeOfDay(
            hour: (_startTime.hour + 1) % 24,
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
      title: const Text('수업 기록 수정'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: '과목'),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('수업 날짜'),
              subtitle: Text(_formatDate(_educationDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: _selectDate,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('시작 시간'),
              subtitle: Text(_startTime.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: _selectStartTime,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('종료 시간'),
              subtitle: Text(_endTime.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: _selectEndTime,
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: '수업 내용'),
              minLines: 3,
              maxLines: 6,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('취소'),
        ),
        FilledButton(
          onPressed: _save,
          child: const Text('저장'),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _educationDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() => _educationDate = date);
    }
  }

  Future<void> _selectStartTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (time != null) {
      setState(() => _startTime = time);
    }
  }

  Future<void> _selectEndTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (time != null) {
      setState(() => _endTime = time);
    }
  }

  void _save() {
    final startMinutes = _startTime.hour * 60 + _startTime.minute;
    final endMinutes = _endTime.hour * 60 + _endTime.minute;
    if (_subjectController.text.trim().isEmpty ||
        endMinutes <= startMinutes) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('과목과 올바른 수업 시간 범위를 입력해주세요.')),
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

  String _formatDate(DateTime date) =>
      '${date.year}.${date.month.toString().padLeft(2, '0')}.'
      '${date.day.toString().padLeft(2, '0')}';
}
