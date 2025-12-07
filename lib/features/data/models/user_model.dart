// UserModel extends the UserEntity and adds persistence methods.
import 'package:shoplyapp/config/enums.dart';
import 'package:shoplyapp/features/domain/entities/User_entity.dart';

class UserModel extends UserEntity {
  final String passwordHash;

  UserModel({
    required super.userID,
    required super.fullName,
    required super.email,
    required this.passwordHash,
    required super.authType,
    required super.createdAt,
    required super.lastLogin,
  }) ;

  // Constructor to map from Firestore data
  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      userID: id,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      passwordHash: json['passwordHash'] as String,
      authType: AuthType.values.byName(json['authType'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLogin: DateTime.parse(json['lastLogin'] as String),
    );
  }

  // Method to map to Firestore data
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'passwordHash': passwordHash,
      'authType': authType.name,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin.toIso8601String(),
    };
  }
}
