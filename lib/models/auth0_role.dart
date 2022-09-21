// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'auth0_role.g.dart';

enum Role{
  RMSRole,
  TWSRole,
  developer,
}

@JsonSerializable()
class Auth0Role {
  Auth0Role({
    required this.id,
    required this.name,
    required this.description,
  });

  final String id;
  final Role name;
  final String description;

  factory Auth0Role.fromJson(Map<String, dynamic> json) =>
      _$Auth0RoleFromJson(json);

  Map<String, dynamic> toJson() => _$Auth0RoleToJson(this);

  @override
  String toString() {
    return {
      'id': id,
      'name': name,
      'description': description,
    }.toString();
  }
}

