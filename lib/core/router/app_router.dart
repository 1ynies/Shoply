import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:shoplyapp/features/AUTH/presentation/pages/login_page.dart';
import 'package:shoplyapp/features/AUTH/presentation/pages/password_recovery_page.dart';
import 'package:shoplyapp/features/AUTH/presentation/pages/register_page.dart';

class AppRouter {
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