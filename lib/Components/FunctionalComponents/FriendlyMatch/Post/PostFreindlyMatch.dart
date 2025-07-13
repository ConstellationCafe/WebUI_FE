import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostFriendlyMatch extends ConsumerStatefulWidget {
  const PostFriendlyMatch({super.key});

  @override
  ConsumerState<PostFriendlyMatch> createState() => _PostFriendlyMatchState();
}

class _PostFriendlyMatchState extends ConsumerState<PostFriendlyMatch> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String _selectedVersion = 'S1';
  String _selectedMode = 'rotation';
  String _selectedBo = 'bo1';

  final List<String> _versions = ['S1', 'S2'];
  final List<String> _s1Modes = ['rotation', 'unlimited', 'twopick', 'timeslep rotation'];
  final List<String> _s2Modes = ['rotation', 'unlimited', 'timeslep rotation'];
  final List<String> _s1BoOptions = ['bo1', 'bo3' 'bo3 1ban' 'bo5', 'bo5 2ban'];
  final List<String> _s2BoOptions = ['bo1', 'bo3', 'bo5', '2덱 bo1'];

  @override
  void dispose() {
    _roomController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  List<String> get _currentModeOptions {
    return _selectedVersion == 'S1' ? _s1Modes : _s2Modes;
  }

  List<String> get _currentBoOptions {
    return _selectedVersion == 'S1' ? _s1BoOptions : _s2BoOptions;
  }

  void _onVersionChanged(String? value) {
    if (value != null) {
      setState(() {
        _selectedVersion = value;
        // 버전 변경 시 모드와 bo를 첫 번째 옵션으로 리셋
        _selectedMode = _currentModeOptions.first;
        _selectedBo = _currentBoOptions.first;
      });
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
            DropdownButtonFormField<String>(
              value: _selectedVersion,
              items: _versions
                  .map((version) => DropdownMenuItem(
                        value: version,
                        child: Text(
                          version,
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
            DropdownButtonFormField<String>(
              value: _selectedMode,
              items: _currentModeOptions
                  .map((mode) => DropdownMenuItem(
                        value: mode,
                        child: Text(
                          mode,
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
            DropdownButtonFormField<String>(
              value: _selectedBo,
              items: _currentBoOptions
                  .map((bo) => DropdownMenuItem(
                        value: bo,
                        child: Text(
                          bo,
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
