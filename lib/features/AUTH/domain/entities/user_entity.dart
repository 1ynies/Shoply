import 'package:equatable/equatable.dart';

/// The pure Business Object representing a User.
/// Does not contain password for security reasons.
class UserEntity extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String? imagePath;
  final DateTime? createdAt;
  final DateTime? lastLogin;
  final String authType; // e.g., 'email', 'google'

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    this.imagePath,
    this.createdAt,
    this.lastLogin,
    required this.authType,
  });

  @override
  List<Object?> get props => [id, fullName, email, imagePath, createdAt, lastLogin, authType];
}