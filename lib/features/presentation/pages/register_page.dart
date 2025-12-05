import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/features/presentation/pages/login_page.dart';
import 'package:shoplyapp/features/presentation/widget/Sign_in_with_google_button.dart';
import 'package:shoplyapp/features/presentation/widget/auth_password_textfield.dart';
import 'package:shoplyapp/features/presentation/widget/auth_textfield.dart';
import 'package:shoplyapp/features/presentation/widget/shoply_text&logo.dart';
import 'package:shoplyapp/features/presentation/widget/submit_like_button.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: .all(16),
            child: Column(
              children: [
                ShoplyTextlogo(),
                Text(
                  'Hi ! Welcome ',
                  style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  'Create an account',
                  style: GoogleFonts.manrope(
                    textStyle: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'Fullname',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    AuthTextfield(
                      label: 'Enter your fullname',
                      prefixicon: 'lib/assets/svg/user_outline.svg',
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text('Email', style: Theme.of(context).textTheme.bodySmall),
                    AuthTextfield(
                      label: 'Enter your email',
                      prefixicon: 'lib/assets/svg/envelope.svg',
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    AuthTextfieldPassword(
                      label: 'Enter password',
                      prefixIcon: 'lib/assets/svg/lock_closed.svg',
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'Re-type password',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    AuthTextfieldPassword(
                      label: 'Re-type password',
                      prefixIcon: 'lib/assets/svg/lock_opened.svg',
                    ),
                  ],
                ),

                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? newValue) {
                        isChecked = newValue!;
                      },
                      activeColor: Color(0xFF9AE600),
                      checkColor: Colors.white,
                      splashRadius: 20,
                    ),
                    Text(
                      'Remember me',
                      style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: SubmitLikeButton(
                        onPressed: () {
                          // Trigger a medium impact haptic effect
                          HapticFeedback.mediumImpact();

                          // Add your button's main logic here
                          // print('Button Pressed');
                        },
                        title: 'Sign up',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                        endIndent: 10.0, // Adds space before the text
                      ),
                    ),
                    const Text(
                      "Or Sign up with",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0,
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                        indent: 10.0, // Adds space after the text
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: GoogleSignInButton(
                        onPressed: () {
                          // Trigger a medium impact haptic effect
                          HapticFeedback.mediumImpact();

                          // Add your button's main logic here
                          // print('Button Pressed');
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      'Already have an account ? ',
                      style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Log in',
                        style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xFF9AE600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
