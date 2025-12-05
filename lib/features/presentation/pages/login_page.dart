import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/features/presentation/pages/register_page.dart';
import 'package:shoplyapp/features/presentation/widget/Sign_in_with_google_button.dart';
import 'package:shoplyapp/features/presentation/widget/auth_password_textfield.dart';
import 'package:shoplyapp/features/presentation/widget/auth_textfield.dart';
import 'package:shoplyapp/features/presentation/widget/shoply_text&logo.dart';
import 'package:shoplyapp/features/presentation/widget/submit_like_button.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: .all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShoplyTextlogo(),
                Text(
                  'Hi ! Welcome back',
                  style: GoogleFonts.manrope(
                    textStyle: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  'Sign in to your account',
                  style: GoogleFonts.manrope(
                    textStyle: TextStyle(fontWeight: FontWeight.w300),
                  ),
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
                Row(
                  children: [
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
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Forgot password ?',
                        style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                            color: Color(0xFF9AE600),
                            fontSize: 12,
                          ),
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
                        title: 'Login',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
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
                          "Or Sign in with",
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
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: GoogleSignInButton(
                            onPressed: () {
                              HapticFeedback.mediumImpact();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          'Don\'t have account ? ',
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
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Register',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
