// == PACKAGES IMPORTS =======================
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
// ===========================================

// == FILES IMPORTS ==========================
import 'package:shoplyapp/features/AUTH/presentation/pages/loginpage.dart';
import 'package:shoplyapp/features/AUTH/presentation/pages/password_recovery_page.dart';
import 'package:shoplyapp/features/AUTH/presentation/pages/registerpage.dart';
//============================================

class AppRouter {
  // == =========   THIS CODE BLOC IS TO MAKE THE USER LOGGED IN TO THE APP WHEN THEY CLOSES IT AND COME BACK 
  // UNCOMMENT IT WHEN U'RE READY TO USE THIS FEATURE
  // intructions : please replace the router function bellow all these comment with the router function commented 


  // late final GoRouter router = GoRouter(
  //   initialLocation: '/login',
  //   debugLogDiagnostics: true,
    
  //   // 1. LISTEN TO BLOC: This refreshes the route every time AuthState changes
  //   refreshListenable: GoRouterRefreshStream(authBloc.stream),

  //   // 2. REDIRECT LOGIC: This runs on every refresh
  //   redirect: (context, state) {
  //     final authState = authBloc.state;
      
  //     // Are we logged in? (Check both Authenticated and Success states)
  //     final isLoggedIn = authState is AuthAuthenticated || authState is AuthSuccess;

  //     // Where are we trying to go?
  //     final isLoggingIn = state.uri.toString() == '/login';
  //     final isRegistering = state.uri.toString() == '/register';
  //     final isRecovering = state.uri.toString() == '/forgot-password';

  //     // SCENARIO A: Not logged in, but trying to access a private page
  //     if (!isLoggedIn && !isLoggingIn && !isRegistering && !isRecovering) {
  //       return '/login';
  //     }

  //     // SCENARIO B: Logged in, but trying to access login/register pages
  //     if (isLoggedIn && (isLoggingIn || isRegistering || isRecovering)) {
  //       return '/home';
  //     }

  //     // SCENARIO C: Everything is fine, don't interfere
  //     return null;
  //   },



  
  //================================================ 

  static final GoRouter router = GoRouter(
    initialLocation: '/login', // Start at Login
    routes: [
      // --- Auth Routes ---
      
      // 1. Login Page
      GoRoute(
        path: '/login',
        name: 'login', // Adding names makes navigation easier/safer
        builder: (context, state) => const LoginPage(),
      ),

      // 2. Register Page
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),

      // 3. Password Recovery Page
      // (Handles email entry & shows the "Check Email" dialog)
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const PasswordRecoveryPage(),
      ),
      
      // --- Home Route (Placeholder) ---
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text("Welcome Home!")),
        ),
      ),
    ],
    
    // Optional: Add a redirect logic here if you want to 
    // auto-redirect users who are already logged in.
    /*
    redirect: (context, state) {
      // You would check your Bloc state here
      return null; 
    },
    */
  );
}