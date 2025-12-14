import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoplyapp/features/AUTH/domain/usecases/logout_usecase.dart';
import '../../domain/entities/user_entity.dart';
// Import the UseCases

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Dependencies are now UseCases, not Repository
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
    // Using the Stream UseCase
    await emit.forEach(getAuthStatusUseCase(), onData: (user) {
      return user != null ? AuthAuthenticated(user) : AuthUnauthenticated();
    });
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signInUseCase(event.email, event.password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signUpUseCase(
        fullName: event.fullName,
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(user));
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