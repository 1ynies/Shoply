// === PACKAGES IMPORTS =====================
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoplyapp/features/AUTH/data/datasources/auth_local_data_source.dart.dart';
//===========================================

// == FILES IMPORTS =========================
import 'package:shoplyapp/features/AUTH/data/datasources/auth_remote_data_source.dart';
import 'package:shoplyapp/features/AUTH/data/repositories/auth_repository_impl.dart';
import 'package:shoplyapp/features/AUTH/domain/repositories/auth_repository.dart';
import 'package:shoplyapp/features/AUTH/domain/usecases/GetAuthStatusUseCase.dart';
import 'package:shoplyapp/features/AUTH/domain/usecases/ResetPasswordUseCase.dart';
import 'package:shoplyapp/features/AUTH/domain/usecases/SignInWithEmailUseCase.dart';
import 'package:shoplyapp/features/AUTH/domain/usecases/SignInWithGoogleUseCase.dart';
import 'package:shoplyapp/features/AUTH/domain/usecases/SignOutUseCase.dart';
import 'package:shoplyapp/features/AUTH/domain/usecases/SignUpWithEmailUseCase.dart';
import 'package:shoplyapp/features/AUTH/presentation/bloc/auth_bloc.dart';
//============================================

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // 1. External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn.instance);

  // -- NEW: REGISTER SHARED PREFERENCES --
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // 2. Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl(),sl()),

  );

  // -- NEW: REGISTER LOCAL DATA SOURCE --
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // 3. Repository
  // -- UPDATE: Inject BOTH remote and local data sources --
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(), 
      localDataSource: sl(), // Add this line!
    ),
  );

  // 4. Use Cases (New!)
  sl.registerLazySingleton(() => SignInWithEmailUseCase(sl()));
  sl.registerLazySingleton(() => SignUpWithEmailUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => GetAuthStatusUseCase(sl()));

  // 5. Bloc
  // Inject the UseCases instead of the Repository
  sl.registerFactory(
    () => AuthBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      googleSignInUseCase: sl(),
      resetPasswordUseCase: sl(),
      signOutUseCase: sl(),
      getAuthStatusUseCase: sl(),
    ),
  );
}
