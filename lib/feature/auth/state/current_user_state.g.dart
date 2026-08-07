// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrentUserState _$CurrentUserStateFromJson(Map<String, dynamic> json) =>
    _CurrentUserState(
      userId: json['discordId'] as String,
      globalName: json['globalName'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      avatarUrl: json['avatar'] as String,
    );

Map<String, dynamic> _$CurrentUserStateToJson(_CurrentUserState instance) =>
    <String, dynamic>{
      'discordId': instance.userId,
      'globalName': instance.globalName,
      'roles': instance.roles,
      'avatar': instance.avatarUrl,
    };
