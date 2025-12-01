import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/features/presentation/widget/onboarding_indicator_widget.dart';
import 'package:shoplyapp/features/presentation/widget/shoply_text&logo.dart';
import 'package:shoplyapp/features/presentation/widget/submit_like_button.dart';

class OnBoarding2 extends StatefulWidget {
  const OnBoarding2({super.key});

  @override
  State<OnBoarding2> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding2> {
  int _currentStep = 1; // Starts at 0
  final int _totalSteps = 2; // Total number of steps

  void _nextStep() {
    setState(() {
      if (_currentStep < _totalSteps - 1) {
        _currentStep++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            // crossAxisAlignment: .stretch,
            mainAxisAlignment: .spaceBetween,
            children: [
              ShoplyTextlogo(),
              Image.asset('lib/assets/images/girl_opening_package.png'),

              Column(
                crossAxisAlignment: .start,
                children: [
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Fast '),
                        TextSpan(
                          text: 'delivery ',
                          style: TextStyle(color: Color(0xFF9AE600)),
                        ),
                        TextSpan(text: 'to Home,Style Arrives Sooner'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ProgressStepper(
                    currentStep: _currentStep,
                    totalSteps: _totalSteps,
                  ),
                ],
              ),

              SubmitLikeButton(onPressed: () {}, title: 'Next'),
            ],
          ),
        ),
      ),
    );
  }
}
