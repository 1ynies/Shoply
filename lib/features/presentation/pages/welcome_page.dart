import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/features/presentation/widget/shoply_text&logo.dart';
import 'package:shoplyapp/features/presentation/widget/submit_like_button.dart';

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

              Image.asset('lib/assets/images/girl_shopping_alone.png'),

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
                    child: SubmitLikeButton(onPressed: () {}, title: 'Sign in'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SubmitLikeButtonwhite(onPressed: () {}, title: 'Sign up'),
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
}
