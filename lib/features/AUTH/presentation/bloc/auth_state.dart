part of 'auth_bloc.dart';



abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;
   AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthFailure extends AuthState {
  final String message;
   AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {
  final UserEntity user;
  AuthAuthenticated(this.user);
}
class AuthUnauthenticated extends AuthState {}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
class AuthPasswordResetSent extends AuthState {} // Success state for forgot password


