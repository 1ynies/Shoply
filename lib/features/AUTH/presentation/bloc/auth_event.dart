part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent(); // Add const constructor

  @override
  List<Object> get props => [];
}

class AuthCheckStatus extends AuthEvent {} 

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  // Changed to named parameters for better safety
  const AuthLoginEvent({
    required this.email, 
    required this.password, 
  }); 

  @override
  List<Object> get props => [email, password, ];
}

class AuthRegisterEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  const AuthRegisterEvent({
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [fullName, email, password, ];
}

class AuthGoogleSignInEvent extends AuthEvent {}

class AuthResetPasswordEvent extends AuthEvent {
  final String email;
  const AuthResetPasswordEvent(this.email);
}

class AuthLogoutEvent extends AuthEvent {}