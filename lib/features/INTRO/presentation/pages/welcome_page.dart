import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/core/common_widgets/shoply_text&logo.dart';
import 'package:shoplyapp/core/common_widgets/submit_like_button.dart';
import 'package:shoplyapp/features/AUTH/presentation/pages/loginpage.dart';
import 'package:shoplyapp/features/AUTH/presentation/pages/registerpage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              ShoplyTextlogo(),

              Image.asset('assets/images/girl_shopping_alone.png'),

              Text(
                'Let’s explore Shoply',
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 32,
                  ),
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: SubmitLikeButton(
                      onPressed: () {
                        // -- I used context.pushNamed('login') because in your AppRouter you defined the route with name: 'login'. This is safer than typing the path strings manually every time! --
                        context.pushNamed('login');
                      },
                      title: 'Sign in',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: submitLikeButtonWhite(
                      onPressed: () {
                        // -- I used context.pushNamed('login') because in your AppRouter you defined the route with name: 'login'. This is safer than typing the path strings manually every time! --
                        context.pushNamed('register');
                        
                      },
                      title: 'Sign up',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget submitLikeButtonWhite({
    required VoidCallback onPressed,
    required String title,
  }) {
    return SizedBox(
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            100,
          ), // High radius for pill shape
          boxShadow: [
            BoxShadow(
              // Simulating the shadow seen in the image (appears dark, offset below)
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 5), // Shadow drops downwards
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black, // Text color
            elevation:
                0, // Disable default elevation to control shadow manually
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                100,
              ), // Matches the decoration radius
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          ),

          child: Text(
            title,
            style: GoogleFonts.manrope(
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
