// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GlobalState _$GlobalStateFromJson(Map<String, dynamic> json) => _GlobalState(
      userId: json['discordId'] as String,
      globalName: json['globalName'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      avatarUrl: json['avatar'] as String,
    );

Map<String, dynamic> _$GlobalStateToJson(_GlobalState instance) =>
    <String, dynamic>{
      'discordId': instance.userId,
      'globalName': instance.globalName,
      'roles': instance.roles,
      'avatar': instance.avatarUrl,
    };
