import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoplyapp/features/AUTH/domain/usecases/GetAuthStatusUseCase.dart';
import 'package:shoplyapp/features/AUTH/domain/usecases/ResetPasswordUseCase.dart';
import 'package:shoplyapp/features/AUTH/domain/usecases/SignInWithEmailUseCase.dart';
import 'package:shoplyapp/features/AUTH/domain/usecases/SignInWithGoogleUseCase.dart';
import 'package:shoplyapp/features/AUTH/domain/usecases/SignOutUseCase.dart';
import 'package:shoplyapp/features/AUTH/domain/usecases/SignUpWithEmailUseCase.dart';
import '../../domain/entities/user_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmailUseCase signInUseCase;
  final SignUpWithEmailUseCase signUpUseCase;
  final SignInWithGoogleUseCase googleSignInUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final SignOutUseCase signOutUseCase;
  final GetAuthStatusUseCase getAuthStatusUseCase;

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.googleSignInUseCase,
    required this.resetPasswordUseCase,
    required this.signOutUseCase,
    required this.getAuthStatusUseCase,
  }) : super(AuthInitial()) {
    on<AuthCheckStatus>(_onCheckStatus);
    on<AuthLoginEvent>(_onLogin);
    on<AuthRegisterEvent>(_onRegister);
    on<AuthGoogleSignInEvent>(_onGoogleSignIn);
    on<AuthResetPasswordEvent>(_onResetPassword);
    on<AuthLogoutEvent>(_onLogout);
  }

  Future<void> _onCheckStatus(AuthCheckStatus event, Emitter<AuthState> emit) async {
    // emit.forEach automatically manages the stream subscription for you
    await emit.forEach(
      getAuthStatusUseCase(),
      onData: (user) {
        if (user != null) {
          // User is found in the stream -> Logged In
          return AuthSuccess(user); // Or AuthAuthenticated(user) depending on your state
        } else {
          // No user found -> Logged Out
          return AuthUnauthenticated();
        }
      },
      onError: (_, __) => AuthUnauthenticated(),
    );
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading(isGoogle: true));
    try {
      final user = await signInUseCase(
        email: event.email, 
        password: event.password,// This works now!
      );
      
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading(isGoogle: false));
    try {
      // We pass rememberMe here too
      final user = await signUpUseCase(
        fullName: event.fullName,
        email: event.email,
        password: event.password, // <--- Added this call
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onGoogleSignIn(AuthGoogleSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await googleSignInUseCase();
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onResetPassword(AuthResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await resetPasswordUseCase(event.email);
      emit(AuthPasswordResetSent());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    await signOutUseCase();
    emit(AuthUnauthenticated());
  }
}