// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendly_match_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FriendlyMatchState _$FriendlyMatchStateFromJson(Map<String, dynamic> json) =>
    _FriendlyMatchState(
      version: json['version'] as String,
      mode: json['mode'] as String,
      platform: json['platform'] as String,
      roomNumber: json['roomNumber'] as String,
      message: json['message'] as String,
      sender: json['sender'] as String,
    );

Map<String, dynamic> _$FriendlyMatchStateToJson(_FriendlyMatchState instance) =>
    <String, dynamic>{
      'version': instance.version,
      'mode': instance.mode,
      'platform': instance.platform,
      'roomNumber': instance.roomNumber,
      'message': instance.message,
      'sender': instance.sender,
    };
