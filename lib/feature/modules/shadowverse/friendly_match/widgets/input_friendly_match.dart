import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/const_size.dart';

import '../../constants/shadowverse_strings.dart';
import '../constants/friendly_match_constants.dart';
import '../domain/mode/s1/mode_type_s1.dart';
import '../domain/mode/s2/mode_type_s2.dart';
import '../domain/mode/type/mode_type.dart';
import '../domain/platform/s1/platform_type_s1.dart';
import '../domain/platform/s2/platform_type_s2.dart';
import '../domain/platform/type/platform_type.dart';
import '../domain/version/game_version_type.dart';
import '../notifier/friendly_match_notifier.dart';

class InputFriendlyMatch extends ConsumerStatefulWidget {
  final double width;

  const InputFriendlyMatch({super.key, required this.width});

  @override
  ConsumerState<InputFriendlyMatch> createState() => _InputFriendlyMatchState();
}

class _InputFriendlyMatchState extends ConsumerState<InputFriendlyMatch> {
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // s1
  GameVersionType _selectedVersion = GameVersionType.values.first;
  // s1.timesleep_rotation
  FriendlyMatchModeType _selectedMode = FriendlyMatchS1ModeType.values.first;
  // s1.bo1
  FriendlyMatchPlatformType _selectedPlatform =
      FriendlyMatchS1PlatformType.values.first;

  @override
  void dispose() {
    _roomController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(friendlyMatchProvider.notifier)
          .update(
            version: _selectedVersion.typeToString(),
            mode: _selectedMode.typeToString(),
            platform: _selectedPlatform.typeToString(),
          );
    });
  }

  void _onVersionChanged(GameVersionType? value) {
    if (value != null) {
      setState(() {
        _selectedVersion = value;
        // 버전 변경 시 모드와 bo를 첫 번째 옵션으로 리셋
        if (value == GameVersionType.s1) {
          _selectedMode = FriendlyMatchS1ModeType.values.first;
          _selectedPlatform = FriendlyMatchS1PlatformType.values.first;
        } else if (value == GameVersionType.s2) {
          _selectedMode = FriendlyMatchS2ModeType.values.first;
          _selectedPlatform = FriendlyMatchS2PlatformType.values.first;
        }
        // 버전 변경 시 mode와 platform도 초기화, 이후 roomNumber와 message 삭제
        ref
            .read(friendlyMatchProvider.notifier)
            .update(
              version: _selectedVersion.typeToString(),
              mode: _selectedMode.typeToString(),
              platform: _selectedPlatform.typeToString(),
            );
        _roomController.clear();
        _messageController.clear();
      });
    }
  }

  // 현재 선택된 버전에 따라 모드 리스트 반환
  List<FriendlyMatchModeType> get _getCurrentModeList {
    if (_selectedVersion == GameVersionType.s1) {
      return FriendlyMatchS1ModeType.values;
    } else {
      return FriendlyMatchS2ModeType.values;
    }
  }

  // 현재 선택된 버전에 따라 BO 리스트 반환
  List<FriendlyMatchPlatformType> get _getCurrentPlatformList {
    if (_selectedVersion == GameVersionType.s1) {
      return FriendlyMatchS1PlatformType.values;
    } else {
      return FriendlyMatchS2PlatformType.values;
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(friendlyMatchProvider.notifier);

    return SizedBox(
      width: widget.width,
      child: Container(
        padding: ConstPadding.largePaddingAll,
        decoration: FriendlyMatchConstants.cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Version 드롭다운
            SizedBox(
              height: FriendlyMatchConstants.fieldHeight,
              child: DropdownButtonFormField<GameVersionType>(
                initialValue: _selectedVersion,
                isExpanded: true,
                items: GameVersionType.values
                    .map(
                      (version) => DropdownMenuItem(
                        value: version,
                        child: Text(version.typeToString()),
                      ),
                    )
                    .toList(),
                onChanged: _onVersionChanged,
                decoration: const InputDecoration(
                  labelText: ShadowverseStrings.versionLabel,
                ),
                style: const TextStyle(fontSize: ConstSize.largeTextSize),
              ),
            ),
            const SizedBox(height: ConstSize.mediumSpacing),

            // Mode 드롭다운
            SizedBox(
              height: FriendlyMatchConstants.fieldHeight,
              child: DropdownButtonFormField<FriendlyMatchModeType>(
                initialValue: _selectedMode,
                items: _getCurrentModeList
                    .map(
                      (mode) => DropdownMenuItem(
                        value: mode,
                        child: Text(mode.typeToString()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedMode = value;
                      notifier.update(mode: _selectedMode.typeToString());
                    });
                  }
                },
                decoration: const InputDecoration(
                  labelText: ShadowverseStrings.modeLabel,
                ),
                style: const TextStyle(fontSize: ConstSize.largeTextSize),
              ),
            ),
            const SizedBox(height: ConstSize.mediumSpacing),

            // Platform 드롭다운
            SizedBox(
              height: FriendlyMatchConstants.fieldHeight,
              child: DropdownButtonFormField<FriendlyMatchPlatformType>(
                initialValue: _selectedPlatform,
                items: _getCurrentPlatformList
                    .map(
                      (platform) => DropdownMenuItem(
                        value: platform,
                        child: Text(platform.typeToString()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedPlatform = value;
                      notifier.update(
                        platform: _selectedPlatform.typeToString(),
                      );
                    });
                  }
                },
                decoration: const InputDecoration(
                  labelText: ShadowverseStrings.platformLabel,
                ),
                style: const TextStyle(fontSize: ConstSize.largeTextSize),
              ),
            ),
            const SizedBox(height: ConstSize.mediumSpacing),

            // Room 텍스트 입력
            SizedBox(
              height: FriendlyMatchConstants.fieldHeight,
              child: TextFormField(
                controller: _roomController,
                cursorColor: FriendlyMatchConstants.cursorColor,
                decoration: const InputDecoration(
                  labelText: ShadowverseStrings.roomLabel,
                ),
                onChanged: (value) {
                  notifier.update(roomNumber: value);
                },
              ),
            ),
            const SizedBox(height: ConstSize.mediumSpacing),

            // Message 텍스트 입력
            TextFormField(
              controller: _messageController,
              maxLines: FriendlyMatchConstants.messageLines,
              cursorColor: FriendlyMatchConstants.cursorColor,
              decoration: const InputDecoration(
                labelText: ShadowverseStrings.messageLabel,
              ),
              onChanged: (value) {
                notifier.update(message: value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
