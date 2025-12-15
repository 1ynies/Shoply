part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  final bool isGoogle; // You seem to use this in your code
  const AuthLoading({this.isGoogle = false});
}

// === FIX IS HERE ===
class AuthAuthenticated extends AuthState {
  final UserEntity? user; // 1. Add '?' to make it Nullable

  const AuthAuthenticated(this.user); // 2. Remove 'required' if it was there

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;
  const AuthSuccess(this.user);
  
  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthPasswordResetSent extends AuthState {}