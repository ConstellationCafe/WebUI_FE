import 'package:flutter/material.dart';

import '../constants/notification_strings.dart';
import '../constants/notification_tokens.dart';
import '../domain/model/notification_draft.dart';
import '../domain/model/notification_publish_failure.dart';
import '../domain/model/notification_request_id.dart';
import '../domain/type/notification_category.dart';
import '../domain/type/notification_target_type.dart';
import 'notification_tile.dart';

/// 관리자 알림 작성 폼. 입력값과 컨트롤러는 이 위젯의 생명주기와 함께한다.
///
/// 요청 ID는 발행을 누를 때 한 번 만들고, 결과를 알 수 없는 실패 뒤 다시 누르면
/// 같은 ID를 재사용해 중복 발행을 막는다. 입력이 바뀌거나 발행에 성공하면 새로 만든다.
class AdminNotificationForm extends StatefulWidget {
  final bool isSubmitting;
  final Future<NotificationPublishFailure?> Function(NotificationDraft) submit;

  const AdminNotificationForm({
    super.key,
    required this.isSubmitting,
    required this.submit,
  });

  @override
  State<AdminNotificationForm> createState() => _AdminNotificationFormState();
}

class _AdminNotificationFormState extends State<AdminNotificationForm> {
  static final _discordId = RegExp(r'^[0-9]{1,20}$');
  static final _internalLink = RegExp(r'^/(?!/)[A-Za-z0-9\-._~/?=&%]*$');

  final _formKey = GlobalKey<FormState>();
  final _discordIdController = TextEditingController();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _linkController = TextEditingController();
  NotificationTargetType _targetType = NotificationTargetType.guild;
  NotificationCategory _category = NotificationCategory.announcement;
  String? _requestId;
  String? _failureMessage;

  @override
  void initState() {
    super.initState();
    for (final controller in _controllers) {
      controller.addListener(_resetRequest);
    }
  }

  List<TextEditingController> get _controllers => [
    _discordIdController,
    _titleController,
    _bodyController,
    _linkController,
  ];

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _resetRequest() {
    _requestId = null;
  }

  @override
  Widget build(BuildContext context) {
    final enabled = !widget.isSubmitting;
    final isUserTarget = _targetType == NotificationTargetType.user;
    final failure = _failureMessage;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<NotificationTargetType>(
            initialValue: _targetType,
            decoration: const InputDecoration(
              labelText: NotificationStrings.targetLabel,
            ),
            items: const [
              DropdownMenuItem(
                value: NotificationTargetType.guild,
                child: Text(NotificationStrings.targetGuild),
              ),
              DropdownMenuItem(
                value: NotificationTargetType.user,
                child: Text(NotificationStrings.targetUser),
              ),
            ],
            onChanged: enabled ? _changeTarget : null,
          ),
          if (isUserTarget) ...[
            const SizedBox(height: NotificationTokens.fieldGap),
            TextFormField(
              controller: _discordIdController,
              enabled: enabled,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: NotificationStrings.targetDiscordId,
              ),
              validator: _validateDiscordId,
            ),
          ],
          const SizedBox(height: NotificationTokens.fieldGap),
          DropdownButtonFormField<NotificationCategory>(
            initialValue: _category,
            decoration: const InputDecoration(
              labelText: NotificationStrings.categoryLabel,
            ),
            items: [
              for (final category in NotificationCategory.values)
                DropdownMenuItem(
                  value: category,
                  child: Text(notificationCategoryLabel(category)),
                ),
            ],
            onChanged: enabled ? _changeCategory : null,
          ),
          const SizedBox(height: NotificationTokens.fieldGap),
          TextFormField(
            controller: _titleController,
            enabled: enabled,
            maxLength: 100,
            decoration: const InputDecoration(
              labelText: NotificationStrings.titleLabel,
            ),
            validator: _validateTitle,
          ),
          const SizedBox(height: NotificationTokens.fieldGap),
          TextFormField(
            controller: _bodyController,
            enabled: enabled,
            maxLength: 1000,
            minLines: 3,
            maxLines: NotificationTokens.bodyMaxLines,
            decoration: const InputDecoration(
              labelText: NotificationStrings.bodyLabel,
              alignLabelWithHint: true,
            ),
            validator: _validateBody,
          ),
          const SizedBox(height: NotificationTokens.fieldGap),
          TextFormField(
            controller: _linkController,
            enabled: enabled,
            maxLength: 255,
            decoration: const InputDecoration(
              labelText: NotificationStrings.linkLabel,
              helperText: NotificationStrings.linkHelper,
              helperMaxLines: 2,
            ),
            validator: _validateLink,
          ),
          if (failure != null) ...[
            const SizedBox(height: NotificationTokens.fieldGap),
            Text(
              failure,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          const SizedBox(height: NotificationTokens.sectionGap),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: enabled ? _submit : null,
              child: widget.isSubmitting
                  ? SizedBox.square(
                      dimension: NotificationTokens.progressSize,
                      child: CircularProgressIndicator(
                        strokeWidth: NotificationTokens.progressStroke,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    )
                  : const Text(NotificationStrings.publish),
            ),
          ),
        ],
      ),
    );
  }

  void _changeTarget(NotificationTargetType? value) {
    if (value == null) return;
    setState(() {
      _targetType = value;
      _requestId = null;
    });
  }

  void _changeCategory(NotificationCategory? value) {
    if (value == null) return;
    setState(() {
      _category = value;
      _requestId = null;
    });
  }

  String? _validateDiscordId(String? value) {
    final text = value?.trim() ?? '';
    if (!_discordId.hasMatch(text)) return NotificationStrings.discordIdInvalid;
    return null;
  }

  String? _validateTitle(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return NotificationStrings.titleRequired;
    if (text.length > 100) return NotificationStrings.titleTooLong;
    return null;
  }

  String? _validateBody(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return NotificationStrings.bodyRequired;
    if (text.length > 1000) return NotificationStrings.bodyTooLong;
    return null;
  }

  String? _validateLink(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    if (!_internalLink.hasMatch(text)) return NotificationStrings.linkInvalid;
    return null;
  }

  Future<void> _submit() async {
    if (widget.isSubmitting) return;
    if (!_formKey.currentState!.validate()) return;
    final requestId = _requestId ??= newNotificationRequestId();
    final isUserTarget = _targetType == NotificationTargetType.user;
    final link = _linkController.text.trim();
    final draft = NotificationDraft(
      requestId: requestId,
      targetType: _targetType,
      targetDiscordId: isUserTarget ? _discordIdController.text.trim() : null,
      category: _category,
      title: _titleController.text.trim(),
      body: _bodyController.text.trim(),
      link: link.isEmpty ? null : link,
    );
    setState(() => _failureMessage = null);
    final failure = await widget.submit(draft);
    if (!mounted) return;
    if (failure == null) {
      _completeSuccess();
      return;
    }
    setState(() => _failureMessage = _failureText(failure));
  }

  void _completeSuccess() {
    _formKey.currentState?.reset();
    for (final controller in _controllers) {
      controller.clear();
    }
    _requestId = null;
    final messenger = ScaffoldMessenger.maybeOf(context);
    const snackBar = SnackBar(content: Text(NotificationStrings.published));
    messenger?.showSnackBar(snackBar);
  }

  String _failureText(NotificationPublishFailure failure) {
    return switch (failure) {
      NotificationPublishFailure.notMember => NotificationStrings.notMember,
      NotificationPublishFailure.conflict => NotificationStrings.conflict,
      NotificationPublishFailure.invalid => NotificationStrings.invalid,
      NotificationPublishFailure.unknown => NotificationStrings.publishUnknown,
    };
  }
}
