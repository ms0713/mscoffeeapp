// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:mscoffeeapp/models/auth0_permission.dart';
import 'package:mscoffeeapp/models/auth0_role.dart';

part 'auth0_id_token.g.dart';

@JsonSerializable()
class Auth0IdToken {
  Auth0IdToken({
    required this.nickname,
    required this.name,
    required this.email,
    required this.picture,
    required this.updateAt,
    required this.iss,
    required this.sub,
    required this.aud,
    required this.iat,
    required this.exp,
    required this.chatStreamUserToken,
    required this.roles,
    required this.permissions,
    this.authTime,
  });

  final String nickname;
  final String name;
  final String email;
  final String picture;

  @JsonKey(name: 'updated_at')
  final String updateAt;

  final String iss;

  final String sub;
  String get userId => sub;

  final String aud;
  final int iat;
  final int exp;

  @JsonKey(name: 'auth_time')
  final int? authTime;

  @JsonKey(name: 'https://getstream.mscoffee.app/user_token')
  final String? chatStreamUserToken;

  @JsonKey(name: 'https://users.mscoffee.app/roles')
  final List<Auth0Role> roles;

  @JsonKey(name: 'https://users.mscoffee.app/permissions')
  final List<Auth0Permission> permissions;

  factory Auth0IdToken.fromJson(Map<String, dynamic> json) =>
      _$Auth0IdTokenFromJson(json);

  Map<String, dynamic> toJson() => _$Auth0IdTokenToJson(this);

  @override
  String toString() {
    return {
      'nickname': nickname,
      'name': name,
      'email': email,
      'picture': picture,
      'updateAt': updateAt,
      'iss': iss,
      'sub': sub,
      'aud': aud,
      'iat': iat,
      'exp': exp,
      'chatStreamUserToken': chatStreamUserToken,
      'roles': roles,
      'permissions': permissions,
      'authTime': authTime
    }.toString();
  }
}
