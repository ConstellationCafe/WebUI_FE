// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MembershipState _$MembershipStateFromJson(Map<String, dynamic> json) =>
    _MembershipState(
      isLoading: json['isLoading'] as bool? ?? true,
      username: json['username'] as String,
      uid1: json['uid1'] as String?,
      uid2: json['uid2'] as String?,
      role: json['role'] as String?,
      coin: json['coin'] as String? ?? "0",
      s1Data: json['s1Data'] as String?,
      s2Data: json['s2Data'] as String?,
      guild: json['guild'] as String?,
      joinAt: json['joinAt'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$MembershipStateToJson(_MembershipState instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'username': instance.username,
      'uid1': instance.uid1,
      'uid2': instance.uid2,
      'role': instance.role,
      'coin': instance.coin,
      's1Data': instance.s1Data,
      's2Data': instance.s2Data,
      'guild': instance.guild,
      'joinAt': instance.joinAt,
      'avatar': instance.avatar,
    };
