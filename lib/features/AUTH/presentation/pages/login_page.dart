import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // IMPORT BLOC
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:shoplyapp/core/common_widgets/shoply_text&logo.dart';
import 'package:shoplyapp/core/common_widgets/submit_like_button.dart';
import 'package:shoplyapp/features/AUTH/presentation/bloc/auth_bloc.dart'; // IMPORT BLOC FILE
import 'package:shoplyapp/features/AUTH/presentation/pages/password_recovery_page.dart';
import 'package:shoplyapp/features/AUTH/presentation/pages/register_page.dart';
import 'package:shoplyapp/features/AUTH/presentation/widgets/Sign_in_with_google_button.dart';
import 'package:shoplyapp/features/AUTH/presentation/widgets/auth_password_textfield.dart';
import 'package:shoplyapp/features/AUTH/presentation/widgets/auth_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ADDED CONTROLLERS
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isChecked = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ADDED BLOC LISTENER FOR NAVIGATION AND ERRORS
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Navigate to Home Page (Replace '/home' with your actual route or widget)
            // Navigator.of(context).pushReplacementNamed('/home'); 
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Successful!")));
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ShoplyTextlogo(),
                  Text(
                    'Hi ! Welcome back',
                    style: GoogleFonts.manrope(
                      textStyle: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    'Sign in to your account',
                    style: GoogleFonts.manrope(
                      textStyle: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email', style: Theme.of(context).textTheme.bodySmall),
                      AuthTextfield(
                        controller: _emailController, // CONNECT CONTROLLER
                        autofocus: false,
                        label: 'Enter your email',
                        prefixicon: 'assets/svg/envelope.svg',
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Password', style: Theme.of(context).textTheme.bodySmall),
                      AuthTextfieldPassword(
                        controller: _passwordController, // CONNECT CONTROLLER
                        label: 'Enter password',
                        prefixIcon: 'assets/svg/lock_closed.svg',
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
                              setState(() {
                                isChecked = newValue!;
                              });
                            },
                            activeColor: const Color(0xFF9AE600),
                            checkColor: Colors.white,
                            splashRadius: 20,
                          ),
                          Text(
                            'Remember me',
                            style: GoogleFonts.manrope(
                              textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const PasswordRecoveryPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot password ?',
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(color: Color(0xFF9AE600), fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            return SubmitLikeButton(
                              onPressed: () {
                                HapticFeedback.mediumImpact();
                                // TRIGGER BLOC EVENT
                                context.read<AuthBloc>().add(AuthLoginEvent(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                ));
                              },
                              title: 'Login',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // ... (Existing Google Sign In Code) ...
                  Row(
                    children: [
                       Expanded(
                        child: GoogleSignInButton(
                          onPressed: () {
                            HapticFeedback.mediumImpact();
                            context.read<AuthBloc>().add(AuthGoogleSignInEvent());
                          },
                        ),
                      ),
                    ],
                  ),
                  // ... (Existing Register Link Code) ...
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have account ? ',
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              // -- NAVIGATION TO REGISTER PAGE --
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Register',
                            style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
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
      ),
    );
  }
}