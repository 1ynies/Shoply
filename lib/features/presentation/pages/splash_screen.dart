import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/features/presentation/pages/on_boarding1.dart';

class ShoplySplashScreen extends StatefulWidget {
  const ShoplySplashScreen({super.key});

  @override
  State<ShoplySplashScreen> createState() => _ShoplySplashScreenState();
}

class Onboardingpageview extends StatelessWidget {
  const Onboardingpageview({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(children: [OnBoarding1()]);
  }
}

class _ShoplySplashScreenState extends State<ShoplySplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Onboardingpageview()),
      );
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
        child: Center(
          // Use a Column to stack the logo, text, and loading indicator vertically.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'lib/assets/svg/app_logo.svg',
                width: 70,
                height: 88,
              ),
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

              // Add some spacing between the text and the loading indicator
              const SizedBox(height: 300),

              // --- 3. The Loading Indicator ---
              // A simple circular progress indicator.
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFF222B08),
                ), // Dark green color
                strokeWidth: 3.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
