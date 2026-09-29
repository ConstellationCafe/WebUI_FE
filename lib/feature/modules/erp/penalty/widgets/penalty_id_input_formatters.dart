import 'package:flutter/services.dart';

import '../domain/penalty_input_rules.dart';

/// Discord ID·채널 ID 입력란에 쓰는 숫자 전용·길이 제한 formatter.
List<TextInputFormatter> penaltyIdInputFormatters() => [
  FilteringTextInputFormatter.digitsOnly,
  LengthLimitingTextInputFormatter(PenaltyInputRules.discordIdMaxLength),
];
