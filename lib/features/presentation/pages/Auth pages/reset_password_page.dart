import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/features/presentation/widget/auth_textfield.dart';
import 'package:shoplyapp/features/presentation/widget/round_circle%20_with_lock_inside.dart';
import 'package:shoplyapp/features/presentation/widget/submit_like_button.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            const SizedBox(height: 80,),
            Center(
              child: Column(
                children: [
                  RoundCircleWithLockInside(),
                  const SizedBox(height: 16),
                  Text(
                    'Reset your password',
                    style: GoogleFonts.manrope(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Please enter your new password',
                    style: GoogleFonts.manrope(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: AuthTextfield(
                      autofocus: true,
                      label: 'Enter your email',
                      prefixicon: 'lib/assets/svg/envelope.svg',
                    ),
                  ),
                ],
              ),
            ),
          const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: SubmitLikeButton(
                      onPressed: () {},
                      title: 'Done',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
