// ===  PACKAGE IMPORTS ========================
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
// =============================================

// === FILE IMPORTS
import 'package:shoplyapp/core/common_widgets/shoply_text&logo.dart';
import 'package:shoplyapp/core/common_widgets/submit_like_button.dart';
import 'package:shoplyapp/features/INTRO/presentation/widgets/onboarding_indicator_widget.dart';
// =============================================

// -- The StatefulWidget is used to hold and potentially modify the local state variables, like _currentStep , that determine the progress indicator's appearance. --

class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({super.key});

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  final int _currentStep = 0; // Starts at 0
  final int _totalSteps = 2; // Total number of steps

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            // -- to Align the widget so they will take all the space available and leave equal spaces between them  --
            mainAxisAlignment: .spaceBetween,
            children: [
              const ShoplyTextlogo(),
              // === IMAGE ===
              Image.asset('assets/images/person_pushing_another_in_a_cart.png'),
              // === ON BOARDING TEXT ===
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'New fashion collection',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.manrope(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      style: GoogleFonts.manrope(
                        textStyle: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Shop smartly , Faster With'),
                        TextSpan(
                          text: ' Shoply',
                          style: const TextStyle(color: Color(0xFF9AE600)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // -- This code instantiates the ProgressStepper widget, which visually represents the user's current position within the multi-step onboarding process, using the local state variables _totalSteps (total indicators needed) and _currentStep (which indicator is currently active). --
                  // === PROGRESS STEPPER ===
                  ProgressStepper(
                    totalSteps: _totalSteps,
                    currentStep: _currentStep,
                  ),
                ],
              ),
              // -- this is the next button , put inside the row then expanded because the SubmitLikeButton have no width and i had to make it take all the width available horizentally -
              // == NEXT BUTTON ==
              Row(
                children: [
                  Expanded(
                    child: SubmitLikeButton(
                      onPressed: () {
                        // -- This line gives the user some feedback with slight vibration  --
                        HapticFeedback.lightImpact();
                        // -- Navigation to OnBoarding 2 --

                        context.go('/onboarding2');
                      },
                      title: 'Next',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
