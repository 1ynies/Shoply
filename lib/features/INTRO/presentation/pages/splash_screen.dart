import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Bloc
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/core/di/injection_container.dart';
import 'package:shoplyapp/features/AUTH/data/datasources/auth_local_data_source.dart.dart';
import 'package:shoplyapp/features/AUTH/presentation/bloc/auth_bloc.dart';

 // Import your Service Locator (sl)

class ShoplySplashScreen extends StatefulWidget {
  const ShoplySplashScreen({super.key});

  @override
  State<ShoplySplashScreen> createState() => _ShoplySplashScreenState();
}

class _ShoplySplashScreenState extends State<ShoplySplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAppFlow();
  }

  // == THE NEW SMART LOGIC ==
  void _checkAppFlow() async {
    // 1. Trigger Auth Check 
    // (If logged in, AppRouter will instantly redirect to /home)
    context.read<AuthBloc>().add(AuthCheckStatus());

    // 2. Keep your 2-second delay for the animation
    await Future.delayed(const Duration(seconds: 2));
    
    // Check if widget is still mounted before using context
    if (!mounted) return;

    // 3. Check if user has seen Onboarding before
    final hasSeenOnboarding = await sl<AuthLocalDataSource>().isOnboardingSeen();

    // 4. Navigate based on the flag
    // Note: If the user IS logged in, the AppRouter would have already sent them to /home by now.
    // If we are still here, it means they are NOT logged in.
    if (hasSeenOnboarding) {
      // User has seen intro before -> Go to Welcome Page (Login/Register buttons)
      context.go('/welcome'); 
    } else {
      // First time user -> Go to Onboarding Sequence
      context.go('/onboarding1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffD8F999), Color(0xffCBF778), Color(0xFFBBF451)],
            stops: [0.18, 0.56, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        // -- This is the main content of the splash screen --
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // -- The logo --
              // Note: Ensure your path is correct (remove 'lib/' if defined in pubspec)
              SvgPicture.asset(
                'assets/svg/app_logo.svg', 
                width: 70,
                height: 88,
              ),
              // -- The text --
              Text(
                'Shoply',
                style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Shop smarter',
                style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              // -- Spacing --
              const SizedBox(height: 200),

              // -- The Loading Indicator --
              const CircularProgressIndicator(
                color: Color(0xFF192E03),
                backgroundColor: Color(0xFFF7FEE7),
                strokeWidth: 4.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}