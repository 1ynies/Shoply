import 'package:shoplyapp/config/enums.dart';

/// Pure entity, contains no knowledge of data persistence (no toJson/fromJson).
class UserEntity {
  final String userID;
  final String fullName;
  final String email;
  final AuthType authType;
  final DateTime createdAt;
  final DateTime lastLogin;

  UserEntity({
    required this.userID,
    required this.fullName,
    required this.email,
    required this.authType,
    required this.createdAt,
    required this.lastLogin,
  });
}