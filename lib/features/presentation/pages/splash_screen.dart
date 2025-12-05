import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/features/presentation/pages/on_boarding1.dart';
import 'package:shoplyapp/features/presentation/pages/on_boarding2.dart';

// -- The ShoplySplashScreen needs to perform an action after a specific duration (2 seconds), which is the navigation to the onboarding screen. This behavior requires lifecycle management, which is only available in a StatefulWidget --

class ShoplySplashScreen extends StatefulWidget {
  const ShoplySplashScreen({super.key});

  @override
  State<ShoplySplashScreen> createState() => _ShoplySplashScreenState();
}

class Onboardingpageview extends StatelessWidget {
  const Onboardingpageview({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(children: [OnBoarding1(), OnBoarding2()]);
  }
}

class _ShoplySplashScreenState extends State<ShoplySplashScreen> {
  @override
  void initState() {
    super.initState();
    // -- This code snippet make sure that after 2 seconds , the navigation to OnBoarding1 screen will happen
    Timer(const Duration(seconds: 2), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => OnBoarding1()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
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
              // -- Tha logo --
              SvgPicture.asset(
                'lib/assets/svg/app_logo.svg',
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
              // -- SizedBox to insure the spacing between the logo&text and the circular progress indicator --
              const SizedBox(height: 200),

              // -- The Loading Indicator : A simple circular progress indicator--
              const CircularProgressIndicator(
                //  The color of the filled-in progress arc
                color: Color(0xFF192E03),

                //  The color of the unfilled track/background ring
                backgroundColor: Color(0xFFF7FEE7),

                // Optional: Set the thickness
                strokeWidth: 4.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
