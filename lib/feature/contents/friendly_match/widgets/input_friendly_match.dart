// flutter
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// domain
import 'package:constellation_cafe/feature/contents/friendly_match/domain/version/game_version_type.dart';
// Provider
import 'package:constellation_cafe/feature/contents/friendly_match/domain/mode/s1/mode_type_s1.dart';
import 'package:constellation_cafe/feature/contents/friendly_match/domain/mode/s2/mode_type_s2.dart';
import 'package:constellation_cafe/feature/contents/friendly_match/domain/mode/type/mode_type.dart';
import 'package:constellation_cafe/feature/contents/friendly_match/domain/platform/s1/platform_type_s1.dart';
import 'package:constellation_cafe/feature/contents/friendly_match/domain/platform/s2/platform_type_s2.dart';
import 'package:constellation_cafe/feature/contents/friendly_match/domain/platform/type/platform_type.dart';
import 'package:constellation_cafe/feature/contents/friendly_match/notifier/friendly_match_notifier.dart';

// Const
import 'package:constellation_cafe/core/constants/ConstPadding.dart';
import 'package:constellation_cafe/core/constants/ConstSize.dart';

class InputFriendlyMatch extends ConsumerStatefulWidget {
  final double width;

  const InputFriendlyMatch({
    super.key,
    required this.width
  });

  @override
  ConsumerState<InputFriendlyMatch> createState() => _InputFriendlyMatchState();
}

class _InputFriendlyMatchState extends ConsumerState<InputFriendlyMatch> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // s1
  GameVersionType _selectedVersion = GameVersionType.values.first;
  // s1.timesleep_rotation
  FriendlyMatchModeType _selectedMode = FriendlyMatchS1ModeType.values.first;
  // s1.bo1
  FriendlyMatchPlatformType _selectedPlatform = FriendlyMatchS1PlatformType.values.first;

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
      ref.read(friendlyMatchProvider.notifier).update(
        version: _selectedVersion.typeToString(),
        mode: _selectedMode.typeToString(),
        platform: _selectedPlatform.typeToString(),
      );
    });
  }

  GameVersionType currentVersionType(String? value) {
    switch (value) {
      case "s1":
        return GameVersionType.S1;
      case "s2":
        return GameVersionType.S2;
      default:
        return GameVersionType.S1;
    }
  }

  void _onVersionChanged(GameVersionType? value) {
    if (value != null) {
      setState(() {
        _selectedVersion = value;
        // 버전 변경 시 모드와 bo를 첫 번째 옵션으로 리셋
        if (value == GameVersionType.S1) {
          _selectedMode = FriendlyMatchS1ModeType.values.first;
          _selectedPlatform = FriendlyMatchS1PlatformType.values.first;
        } else if (value == GameVersionType.S2) {
          _selectedMode = FriendlyMatchS2ModeType.values.first;
          _selectedPlatform = FriendlyMatchS2PlatformType.values.first;
        }
        // 버전 변경 시 mode와 platform도 초기화, 이후 roomNumber와 message 삭제
        ref.read(friendlyMatchProvider.notifier).update(
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
    if (_selectedVersion == GameVersionType.S1) {
      return FriendlyMatchS1ModeType.values;
    } else {
      return FriendlyMatchS2ModeType.values;
    }
  }

  // 현재 선택된 버전에 따라 BO 리스트 반환
  List<FriendlyMatchPlatformType> get _getCurrentPlatformList {
    if (_selectedVersion == GameVersionType.S1) {
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF000D27).withOpacity(0.12),  // rgba(0, 13, 39, 0.12)
              blurRadius: 24,                              // 24px 흐림
              offset: Offset(0, 8),                        // 0px x, 8px y
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Version 드롭다운
            SizedBox(
              height: 40,
              child: DropdownButtonFormField<GameVersionType>(
                initialValue: _selectedVersion,
                isExpanded: true,
                items: GameVersionType.values
                    .map((version) => DropdownMenuItem(
                  value: version,
                  child: Text(version.typeToString()),
                ))
                    .toList(),
                onChanged: _onVersionChanged,
                decoration: InputDecoration(
                  labelText: 'version',
                ),
                style: const TextStyle(fontSize: ConstSize.bigTextSize),
              ),
            ),
            const SizedBox(height: ConstSize.mediumHeight),

            // Mode 드롭다운
            SizedBox(
              height: 40,
              child: DropdownButtonFormField<FriendlyMatchModeType>(
                initialValue: _selectedMode,
                items: _getCurrentModeList.map((mode) =>
                    DropdownMenuItem(
                      value: mode,
                      child: Text(
                        mode.typeToString(),
                      ),
                    )).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedMode = value;
                      notifier.update(mode: _selectedMode.typeToString());
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: 'mode',
                ),
                style: const TextStyle(fontSize: ConstSize.bigTextSize),
              )
            ),
            const SizedBox(height: ConstSize.mediumHeight),

            // Platform 드롭다운
            SizedBox(
              height: 40,
              child: DropdownButtonFormField<FriendlyMatchPlatformType>(
                initialValue: _selectedPlatform,
                items: _getCurrentPlatformList.map((platform) =>
                    DropdownMenuItem(
                      value: platform,
                      child: Text(
                        platform.typeToString(),
                      ),
                    )).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedPlatform = value;
                      notifier.update(platform: _selectedPlatform.typeToString());
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: 'BoN',
                ),
                style: const TextStyle(fontSize: ConstSize.bigTextSize),
              )
            ),
            const SizedBox(height: ConstSize.mediumHeight),

            // Room 텍스트 입력
            SizedBox(
              height: 40,
              child: TextFormField(
                controller: _roomController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    labelText: 'Room',
                ),
                onChanged: (value) {
                  notifier.update(
                    roomNumber: value,
                  );
                },
              )
            ),
            const SizedBox(height: ConstSize.mediumHeight),

            // Message 텍스트 입력
            TextFormField(
              controller: _messageController,
              maxLines: 3,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                labelText: 'Message',
              ),
              onChanged: (value) {
                notifier.update(
                  message: value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
