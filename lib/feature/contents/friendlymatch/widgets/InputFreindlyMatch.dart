// flutter
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// domain
import '../../../../domain/Common/Version/GameVersionType.dart';
import '../../../../domain/FriendlyMatch/Mode/S1/ModeTypeS1.dart';
import '../../../../domain/FriendlyMatch/Mode/S2/ModeTypeS2.dart';
import '../../../../domain/FriendlyMatch/Mode/Type/ModeType.dart';
import '../../../../domain/FriendlyMatch/Platform/S1/PlatformTypeS1.dart';
import '../../../../domain/FriendlyMatch/Platform/S2/PlatformTypeS2.dart';
import '../../../../domain/FriendlyMatch/Platform/Type/PlatformType.dart';
// Provider
import '../state/Provider/StateProvider.dart';
// Const
import '../../../../core/constants/ConstPadding.dart';
import '../../../../core/constants/ConstSize.dart';

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

  // S1
  GameVersionType _selectedVersion = GameVersionType.values.first;
  // S1.timesleep_rotation
  FriendlyMatchModeType _selectedMode = FriendlyMatchS1ModeType.values.first;
  // S1.bo1
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
      case "S1":
        return GameVersionType.S1;
      case "S2":
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Version 드롭다운
          DropdownButtonFormField<GameVersionType>(
            value: _selectedVersion,
            items: GameVersionType.values
                .map((version) => DropdownMenuItem(
              value: version,
              child: Text(version.typeToString()),
            ))
                .toList(),
            onChanged: _onVersionChanged,
            decoration: InputDecoration(
              labelText: 'Version',
              contentPadding: ConstPadding.bigPaddingAll,
            ),
            style: const TextStyle(fontSize: ConstSize.bigTextSize),
          ),
          const SizedBox(height: 12),

          // Mode 드롭다운
          DropdownButtonFormField<FriendlyMatchModeType>(
            value: _selectedMode,
            items: _getCurrentModeList
                .map((mode) => DropdownMenuItem(
              value: mode,
              child: Text(
                mode.typeToString(),
              ),
            ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedMode = value;
                  notifier.update(mode: _selectedMode.typeToString());
                });
              }
            },
            decoration: InputDecoration(
              labelText: 'Mode',
              contentPadding: ConstPadding.bigPaddingAll,
            ),
            style: const TextStyle(fontSize: ConstSize.bigTextSize),
          ),
          const SizedBox(height: ConstSize.mediumHeight),

          // Platform 드롭다운
          DropdownButtonFormField<FriendlyMatchPlatformType>(
            value: _selectedPlatform,
            items: _getCurrentPlatformList
                .map((platform) => DropdownMenuItem(
              value: platform,
              child: Text(
                platform.typeToString(),
              ),
            ))
                .toList(),
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
              contentPadding: ConstPadding.bigPaddingAll,
            ),
            style: const TextStyle(fontSize: ConstSize.bigTextSize),
          ),
          const SizedBox(height: ConstSize.mediumHeight),

          // Room 텍스트 입력
          TextFormField(
            controller: _roomController,
            decoration: InputDecoration(
                labelText: 'Room'
            ),
            onChanged: (value) {
              notifier.update(
                roomNumber: value,
              );
            },
          ),
          const SizedBox(height: ConstSize.mediumHeight),

          // Message 텍스트 입력
          TextFormField(
            controller: _messageController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Message',
              contentPadding: ConstPadding.bigPaddingAll,
            ),
            onChanged: (value) {
              notifier.update(
                message: value,
              );
            },
          ),
        ],
      ),
    );
  }
}
