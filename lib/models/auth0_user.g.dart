// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth0_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth0User _$Auth0UserFromJson(Map<String, dynamic> json) => Auth0User(
      sub: json['sub'] as String,
      nickname: json['nickname'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      picture: json['picture'] as String,
      updatedAt: json['updated_at'] as String,
      emailVerified: json['email_verified'] as bool,
      chatStreamUserToken:
          json['https://getstream.mscoffee.app/user_token'] as String?,
      roles: (json['https://users.mscoffee.app/roles'] as List<dynamic>?)
              ?.map((e) => Auth0Role.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      permissions: (json['https://users.mscoffee.app/permissions']
                  as List<dynamic>?)
              ?.map((e) => Auth0Permission.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$Auth0UserToJson(Auth0User instance) => <String, dynamic>{
      'sub': instance.sub,
      'nickname': instance.nickname,
      'name': instance.name,
      'email': instance.email,
      'picture': instance.picture,
      'updated_at': instance.updatedAt,
      'email_verified': instance.emailVerified,
      'https://getstream.mscoffee.app/user_token': instance.chatStreamUserToken,
      'https://users.mscoffee.app/roles': instance.roles,
      'https://users.mscoffee.app/permissions': instance.permissions,
    };
