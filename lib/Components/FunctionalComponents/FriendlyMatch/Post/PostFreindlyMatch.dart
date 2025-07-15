import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Data/Common/Version/GameVersionType.dart';
import '../../../../Data/FriendlyMatch/Bo/S1/BoTypeS1.dart';
import '../../../../Data/FriendlyMatch/Bo/S2/BoTypeS2.dart';
import '../../../../Data/FriendlyMatch/Bo/Type/BoType.dart';
import '../../../../Data/FriendlyMatch/Mode/S1/ModeTypeS1.dart';
import '../../../../Data/FriendlyMatch/Mode/S2/ModeTypeS2.dart';
import '../../../../Data/FriendlyMatch/Mode/Type/ModeType.dart';

class PostFriendlyMatch extends ConsumerStatefulWidget {
  const PostFriendlyMatch({super.key});

  @override
  ConsumerState<PostFriendlyMatch> createState() => _PostFriendlyMatchState();
}

class _PostFriendlyMatchState extends ConsumerState<PostFriendlyMatch> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // S1
  GameVersionType _selectedVersion = GameVersionType.values.first;

  // S1.rotation
  FriendlyMatchModeType _selectedMode = FriendlyMatchS1ModeType.values.first;

  // S1.bo1
  FriendlyMatchBoType _selectedBo = FriendlyMatchS1BoType.values.first;

  @override
  void dispose() {
    _roomController.dispose();
    _messageController.dispose();
    super.dispose();
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
          _selectedBo = FriendlyMatchS1BoType.values.first;
        } else if (value == GameVersionType.S2) {
          _selectedMode = FriendlyMatchS2ModeType.values.first;
          _selectedBo = FriendlyMatchS2BoType.values.first;
        }
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
  List<FriendlyMatchBoType> get _getCurrentBoList {
    if (_selectedVersion == GameVersionType.S1) {
      return FriendlyMatchS1BoType.values;
    } else {
      return FriendlyMatchS2BoType.values;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "version": _selectedVersion,
      "mode": _selectedMode,
      "bo": _selectedBo,
      "room": _roomController.text,
      "message": _messageController.text,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Version 드롭다운
            DropdownButtonFormField<GameVersionType>(
              value: _selectedVersion,
              items: GameVersionType.values
                  .map((version) => DropdownMenuItem(
                        value: version,
                        child: Text(
                          GameVersionType.typeToString(version),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))
                  .toList(),
              onChanged: _onVersionChanged,
              dropdownColor: const Color(0xFF2A2A2A),
              decoration: InputDecoration(
                labelText: 'Version',
                labelStyle: const TextStyle(color: Colors.white70),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                filled: true,
                fillColor: const Color(0xFF2A2A2A),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFF555555)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFF888888)),
                ),
              ),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),

            // Mode 드롭다운
            DropdownButtonFormField<FriendlyMatchModeType>(
              value: _selectedMode,
              items: _getCurrentModeList
                  .map((mode) => DropdownMenuItem(
                        value: mode,
                        child: Text(
                          _selectedVersion == GameVersionType.S1
                              ? FriendlyMatchS1ModeType.typeToString(mode as FriendlyMatchS1ModeType)
                              : FriendlyMatchS2ModeType.typeToString(mode as FriendlyMatchS2ModeType),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedMode = value);
                }
              },
              dropdownColor: const Color(0xFF2A2A2A),
              decoration: InputDecoration(
                labelText: 'Mode',
                labelStyle: const TextStyle(color: Colors.white70),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                filled: true,
                fillColor: const Color(0xFF2A2A2A),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFF555555)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFF888888)),
                ),
              ),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),

            // BO 드롭다운
            DropdownButtonFormField<FriendlyMatchBoType>(
              value: _selectedBo,
              items: _getCurrentBoList
                  .map((bo) => DropdownMenuItem(
                        value: bo,
                        child: Text(
                          _selectedVersion == GameVersionType.S1
                              ? FriendlyMatchS1BoType.typeToString(bo as FriendlyMatchS1BoType)
                              : FriendlyMatchS2BoType.typeToString(bo as FriendlyMatchS2BoType),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedBo = value);
                }
              },
              dropdownColor: const Color(0xFF2A2A2A),
              decoration: InputDecoration(
                labelText: 'BO',
                labelStyle: const TextStyle(color: Colors.white70),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                filled: true,
                fillColor: const Color(0xFF2A2A2A),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFF555555)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFF888888)),
                ),
              ),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),

            // Room 텍스트 입력
            TextFormField(
              controller: _roomController,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                labelText: 'Room',
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFF2A2A2A),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFF555555)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFF555555)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFF888888)),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Message 텍스트 입력
            TextFormField(
              controller: _messageController,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Message',
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFF2A2A2A),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFF555555)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFF555555)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFF888888)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 제출 버튼 (선택사항)
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final json = toJson();
                  print('Form Data: $json');
                  // 여기서 실제 제출 로직을 구현하세요
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF444444),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text('제출'),
            ),
          ],
        ),
      ),
    );
  }
}
