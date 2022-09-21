// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth0_id_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth0IdToken _$Auth0IdTokenFromJson(Map<String, dynamic> json) => Auth0IdToken(
      nickname: json['nickname'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      picture: json['picture'] as String,
      updateAt: json['updated_at'] as String,
      iss: json['iss'] as String,
      sub: json['sub'] as String,
      aud: json['aud'] as String,
      iat: json['iat'] as int,
      exp: json['exp'] as int,
      chatStreamUserToken:
          json['https://getstream.mscoffee.app/user_token'] as String?,
      roles: (json['https://users.mscoffee.app/roles'] as List<dynamic>)
          .map((e) => Auth0Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      permissions:
          (json['https://users.mscoffee.app/permissions'] as List<dynamic>)
              .map((e) => Auth0Permission.fromJson(e as Map<String, dynamic>))
              .toList(),
      authTime: json['auth_time'] as int?,
    );

Map<String, dynamic> _$Auth0IdTokenToJson(Auth0IdToken instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'name': instance.name,
      'email': instance.email,
      'picture': instance.picture,
      'updated_at': instance.updateAt,
      'iss': instance.iss,
      'sub': instance.sub,
      'aud': instance.aud,
      'iat': instance.iat,
      'exp': instance.exp,
      'auth_time': instance.authTime,
      'https://getstream.mscoffee.app/user_token': instance.chatStreamUserToken,
      'https://users.mscoffee.app/roles': instance.roles,
      'https://users.mscoffee.app/permissions': instance.permissions,
    };
