

part of 'auth_bloc.dart';


abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthCheckStatus extends AuthEvent {} // App start

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;
  AuthLoginEvent(this.email, this.password);
}
class AuthRegisterEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String password;
  AuthRegisterEvent({required this.fullName, required this.email, required this.password});
}
class AuthGoogleSignInEvent extends AuthEvent {}
class AuthResetPasswordEvent extends AuthEvent {
  final String email;
  AuthResetPasswordEvent(this.email);
}
class AuthLogoutEvent extends AuthEvent {}