// == PACKAGES IMPORTS =======================
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:shoplyapp/core/router/go_router_refrech_stream.dart';
import 'package:shoplyapp/features/AUTH/presentation/bloc/auth_bloc.dart';
// ===========================================

// == FILES IMPORTS ==========================
import 'package:shoplyapp/features/AUTH/presentation/pages/loginpage.dart';
import 'package:shoplyapp/features/AUTH/presentation/pages/password_recovery_page.dart';
import 'package:shoplyapp/features/AUTH/presentation/pages/registerpage.dart';
import 'package:shoplyapp/features/INTRO/presentation/pages/on_boarding1.dart';
import 'package:shoplyapp/features/INTRO/presentation/pages/on_boarding2.dart';
import 'package:shoplyapp/features/INTRO/presentation/pages/splash_screen.dart';
import 'package:shoplyapp/features/INTRO/presentation/pages/welcome_page.dart';
import 'package:shoplyapp/features/PRODUCT/presentation/bloc/product_bloc.dart';
import 'package:shoplyapp/features/PRODUCT/presentation/bloc/product_event.dart';
import 'package:shoplyapp/features/PRODUCT/presentation/pages/product_details.dart';

//============================================

class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    

    initialLocation: '/splash', // 1. Always start at Splash
    debugLogDiagnostics: true,
    
    // 2. LISTEN TO BLOC: Refreshes route when AuthState changes
    refreshListenable: GoRouterRefreshStream(authBloc.stream),

    // 3. REDIRECT LOGIC: Guard the routes
    redirect: (context, state) {
      final authState = authBloc.state;
      
      // -- CHECK AUTH STATUS --
      // We check for AuthSuccess because that's what we emit on login
      final isLoggedIn = authState is AuthSuccess || authState is AuthAuthenticated;

      final isLoggingIn = state.uri.toString() == '/login';
      final isRegistering = state.uri.toString() == '/register';
      final isRecovering = state.uri.toString() == '/forgot-password';
      final isSplash = state.uri.toString() == '/splash';
      final isOnboarding = state.uri.toString() == '/onboarding';
      final isWelcome = state.uri.toString() == '/welcome';

      // -- RULE A: If Logged In, go to Home --
      // (Unless we are already at home)
      if (isLoggedIn) {
        // If user is trying to login/register or is at splash, send to home
        if (isLoggingIn || isRegistering || isRecovering || isSplash || isOnboarding || isWelcome) {
          return '/home';
        }
      }

      // -- RULE B: If Not Logged In --
      // We don't need to force them to login here, because the Splash Screen 
      // will handle the decision (Onboarding vs Welcome vs Login).
      // So we return null to let the navigation proceed as normal.
      return null;
    },

    routes: [

      
      // --- SPLASH SCREEN ---
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const ShoplySplashScreen(),
      ),

      // --- ONBOARDING SCREEN 1 ---
      GoRoute(
        path: '/onboarding1',
        name: 'onboarding1',
        // Replace with your First Onboarding Page widget
        builder: (context, state) => const OnBoarding1(), 
      ),

      // --- ONBOARDING SCREEN 2 ---
      GoRoute(
        path: '/onboarding2',
        name: 'onboarding2',
        // Replace with your First Onboarding Page widget
        builder: (context, state) => const OnBoarding2(), 
      ),


      // --- WELCOME SCREEN ---
      GoRoute(
        path: '/welcome',
        name: 'welcome',
        builder: (context, state) => const WelcomePage(), 
      ),

      // --- AUTH ROUTES ---
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const PasswordRecoveryPage(),
      ),
      
      // --- HOME SCREEN ---
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text("Welcome Home!")),
        ),
      ),

      
    ],
  );
}

