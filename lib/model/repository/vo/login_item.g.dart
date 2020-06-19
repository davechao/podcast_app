// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginItem _$LoginItemFromJson(Map<String, dynamic> json) {
  return LoginItem(
    json['accessToken'] as String,
    json['expiresIn'] as int,
    json['refreshExpiresIn'] as int,
    json['refreshToken'] as String,
  );
}

Map<String, dynamic> _$LoginItemToJson(LoginItem instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'expiresIn': instance.expiresIn,
      'refreshExpiresIn': instance.refreshExpiresIn,
      'refreshToken': instance.refreshToken,
    };
