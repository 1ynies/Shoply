import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/features/presentation/pages/on_boarding2.dart';
import 'package:shoplyapp/features/presentation/widget/onboarding_indicator_widget.dart';
import 'package:shoplyapp/features/presentation/widget/shoply_text&logo.dart';
import 'package:shoplyapp/features/presentation/widget/submit_like_button.dart';

class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({super.key});

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  int _currentStep = 0; // Starts at 0
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
              Image.asset(
                'lib/assets/images/person_pushing_another_in_a_cart.png',
              ),

              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'New fashion collection',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.manrope(
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
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
                        TextSpan(text: 'Shop smartly , Faster With'),
                        TextSpan(
                          text: 'Shoply',
                          style: TextStyle(color: Color(0xFF9AE600)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ProgressStepper(
                    totalSteps: _totalSteps,
                    currentStep: _currentStep,
                  ),
                ],
              ),

              SubmitLikeButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OnBoarding2(),

                      
                    ),
                  );
                },
                title: 'Next',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
