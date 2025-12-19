// === PACKAGES IMPORTS ===
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
//=========================

// === FILE IMPORTS ======= 
import 'package:shoplyapp/core/Shared/presentation/Widgets/shoply_text&logo.dart';
import 'package:shoplyapp/core/Shared/presentation/Widgets/submit_like_button.dart';
import 'package:shoplyapp/core/di/injection_container.dart';
import 'package:shoplyapp/features/AUTH/data/datasources/auth_local_data_source.dart.dart';
import 'package:shoplyapp/features/INTRO/presentation/widgets/onboarding_indicator_widget.dart';
// ========================


// -- The StatefulWidget is used to hold and potentially modify the local state variables, like _currentStep , that determine the progress indicator's appearance. --
class OnBoarding2 extends StatefulWidget {
  const OnBoarding2({super.key});

  @override
  State<OnBoarding2> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding2> {
  final int _currentStep = 1; // Starts at 1
  final int _totalSteps = 2; // Total number of steps

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:const  EdgeInsets.all(16),
          child: Column(
            // -- to Align the widget so they will take all the space available and leave equal spaces between them  --
            mainAxisAlignment: .spaceBetween,
            children: [
              // -- pre-made widget --
              const ShoplyTextlogo(),
              // === IMAGE === 
              Image.asset('assets/images/girl_opening_package.png'),

              Column(
                crossAxisAlignment: .start,
                children: [
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
                        TextSpan(text: 'Fast '),
                        TextSpan(
                          text: 'delivery ',
                          style: const  TextStyle(color: Color(0xFF9AE600)),
                        ),
                        TextSpan(text: 'to Home, Style Arrives Sooner'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // -- This code instantiates the ProgressStepper widget, which visually represents the user's current position within the multi-step onboarding process, using the local state variables _totalSteps (total indicators needed) and _currentStep (which indicator is currently active). --
                  ProgressStepper(
                    currentStep: _currentStep,
                    totalSteps: _totalSteps,
                  ),
                ],
              ),

              // -- this is the next button , put inside the row then expanded because the SubmitLikeButton have no width and i had to make it take all the width available horizentally --
              Row(
                children: [
                  Expanded(
                    child: SubmitLikeButton(
                      onPressed: () {
                        // -- This line gives the user some feedback with slight vibration  --
                        HapticFeedback.lightImpact();
                        // -- Navigation to WelcomePage --
                        sl<AuthLocalDataSource>().setOnboardingSeen();
                        context.go('/welcome');
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
