// == PACKAGES IMPORTS =======================
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
// ===========================================

//== FILES IMPORTS ===========================
import 'package:shoplyapp/core/common_widgets/shoply_text&logo.dart';
import 'package:shoplyapp/core/common_widgets/submit_like_button.dart';
import 'package:shoplyapp/features/AUTH/presentation/bloc/auth_bloc.dart';
import 'package:shoplyapp/features/AUTH/presentation/pages/password_recovery_page.dart';
import 'package:shoplyapp/features/AUTH/presentation/pages/registerpage.dart';
import 'package:shoplyapp/features/AUTH/presentation/widgets/Sign_in_with_google_button.dart';
import 'package:shoplyapp/features/AUTH/presentation/widgets/auth_password_textfield.dart';
import 'package:shoplyapp/features/AUTH/presentation/widgets/auth_textfield.dart';
// ============================================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // -- CONTROLLERS --
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // -- FORM KEY --
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      // -- BLOC LISTENER FOR NAVIGATION AND ERRORS --
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Navigate to Home Page (Replace '/home' with your actual route or widget)
            Navigator.of(context).pushReplacementNamed('/home');
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Login Successful!")));
          }
          // if (state is AuthError) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text(state.message),
          //       backgroundColor: Colors.red,
          //     ),
          //   );
          // }
        },

        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        // -- asseign formkey to form --
                        key: _formKey,
                        child: Column(
                          children: [
                            const ShoplyTextlogo(),
                            const Gap(15),

                            Text(
                              'Hi ! Welcome back',
                              style: GoogleFonts.manrope(
                                textStyle: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              'Sign in to your account',
                              style: GoogleFonts.manrope(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            // -- EMAIL FIELD
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                AuthTextfield(
                                  label: 'Enter your email',
                                  prefixicon: 'assets/svg/envelope.svg',
                                  autofocus: false,
                                  controller: _emailController,
                                  // -- Validator logic --
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    return null; // Returns null if valid
                                  },
                                ),
                              ],
                            ),
                            // -- PASSWORD FIELD --
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Password',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                AuthTextfieldPassword(
                                  label: 'Enter password',
                                  prefixIcon: 'assets/svg/lock_closed.svg',
                                  controller: _passwordController,
                                  // -- Validation logic --
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    return null; // Returns null if valid
                                  },
                                ),
                              ],
                            ),
                            const Gap(16),
                            //--  FORGOT PASSWORD LINK --
                            Row(
                              children: [
                                
                                const Spacer(),
                                //--NAVIGATION TO PASSWORD RECOVERY PAGE--
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PasswordRecoveryPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Forgot password ?',
                                    style: GoogleFonts.manrope(
                                      textStyle: const TextStyle(
                                        color: Color(0xFF9AE600),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(20),
                            // -- LOGIN BUTTON --
                            Row(
                              children: [
                                Expanded(
                                  child: BlocConsumer<AuthBloc, AuthState>(
                                    listener: (context, state) {
                                      if (state is AuthSuccess) {
                                        // Navigate to Home Page and remove back button history
                                        context.go('/home');
                                      }
                                      if (state is AuthError) {
                                        // Optional: Show error snackbar
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(state.message),
                                          ),
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is AuthLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return SubmitLikeButton(
                                        onPressed: () {
                                          //  Trigger Validation on Click
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // Validation passed, proceed with logic
                                            // -- Gives user a feedback with a slight vibration --
                                            HapticFeedback.mediumImpact();
                                            // TRIGGER BLOC EVENT
                                            context.read<AuthBloc>().add(
                                              AuthLoginEvent(
                                                email: _emailController.text
                                                    .trim(),
                                                password: _passwordController
                                                    .text
                                                    .trim(),
                                              ),
                                            );
                                          }
                                          // If validation fails, the UI updates automatically to red
                                        },
                                        title: 'Login',
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),

                            // -- OR SIGN IN WITH DIVIDER --
                            Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1.0,
                                    endIndent: 10.0,
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
                                    indent: 10.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // -- SIGN UP WITH GOOGLE BUTTON --
                            Row(
                              children: [
                                Expanded(
                                  child: GoogleSignInButton(
                                    onPressed: () {
                                      HapticFeedback.mediumImpact();
                                      context.read<AuthBloc>().add(
                                        AuthGoogleSignInEvent(),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // -- REGISTER LINK --
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
                                // -- NAVIGATION TOREGISTER PAGE --
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage(),
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
            },
          ),
        ),
      ),
    );
  }
}
