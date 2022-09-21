import 'package:json_annotation/json_annotation.dart';

import 'auth0_permission.dart';
import 'auth0_role.dart';

part 'auth0_user.g.dart';

@JsonSerializable()
class Auth0User {
  Auth0User({
    required this.sub,
    required this.nickname,
    required this.name,
    required this.email,
    required this.picture,
    required this.updatedAt,
    required this.emailVerified,
    required this.chatStreamUserToken,
    required this.roles,
    required this.permissions,
  });

  bool can(String permission) => permissions
      .where(
        (p) => p.permissionName == permission,
      )
      .isNotEmpty;

  get isRMSUser => roles
      .where(
        (r) => r.name == Role.RMSRole,
      )
      .isNotEmpty;

  get isTWSUser => roles
      .where(
        (r) => r.name == Role.TWSRole,
      )
      .isNotEmpty;

  get isDeveloper => roles
      .where(
        (r) => r.name == Role.developer,
      )
      .isNotEmpty;

  //User Identifier
  final String sub;
  String get id => sub.split('|').join('');

  final String nickname;
  final String name;
  final String email;
  final String picture;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  @JsonKey(name: 'email_verified')
  final bool emailVerified;

  @JsonKey(name: 'https://getstream.mscoffee.app/user_token')
  final String? chatStreamUserToken;

  @JsonKey(name: 'https://users.mscoffee.app/roles', defaultValue: [])
  final List<Auth0Role> roles;

  @JsonKey(name: 'https://users.mscoffee.app/permissions', defaultValue: [])
  final List<Auth0Permission> permissions;

  factory Auth0User.fromJson(Map<String, dynamic> json) =>
      _$Auth0UserFromJson(json);

  Map<String, dynamic> toJson() => _$Auth0UserToJson(this);

  @override
  String toString() {
    return {
      'sub': sub,
      'nickname': nickname,
      'name': name,
      'email': email,
      'picture': picture,
      'emailVerified': emailVerified,
      'updatedAt': updatedAt,
      'chatStreamUserToken': chatStreamUserToken,
      'roles': roles,
      'permissions': permissions,
    }.toString();
  }
}
