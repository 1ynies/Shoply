// == PACKAGES IMPORTS =======================
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
// ===========================================

// == FILES IMPORTS ==========================
import 'package:shoplyapp/core/Shared/presentation/Widgets/shoply_text&logo.dart';
import 'package:shoplyapp/core/Shared/presentation/Widgets/submit_like_button.dart';
import 'package:shoplyapp/features/AUTH/presentation/bloc/auth_bloc.dart';
import 'package:shoplyapp/features/AUTH/presentation/pages/loginpage.dart';
import 'package:shoplyapp/features/AUTH/presentation/widgets/Sign_in_with_google_button.dart';
import 'package:shoplyapp/features/AUTH/presentation/widgets/auth_password_textfield.dart';
import 'package:shoplyapp/features/AUTH/presentation/widgets/auth_textfield.dart';
// ===========================================

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // -- CONTROLLERS --
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  // -- FORM KEY --
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. ONE CENTRAL LISTENER FOR EVERYTHING
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // -- SUCCESS --
          if (state is AuthAuthenticated || state is AuthSuccess) {
             context.go('/home');
          }
          
          // -- ERROR (Custom SnackBar is here now) --
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                // Use state.message to show the real backend error, 
                // or hardcode text if you prefer generic messages.
                content: Text(
                  'There might have been a problem, please try again',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red.shade400,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
        },
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const ShoplyTextlogo(),
                            const Gap(15),
                            // Header Texts
                            Text(
                              'Hi ! Welcome ',
                              style: GoogleFonts.manrope(
                                textStyle: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Gap(15),
                            Text(
                              'Create an account',
                              style: GoogleFonts.manrope(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            const Gap(10),

                            // -- FULLNAME INPUT --
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fullname',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const Gap(4),
                                AuthTextfield(
                                  autofocus: false,
                                  controller: _nameController,
                                  label: 'Enter your fullname',
                                  prefixicon: 'assets/svg/user_outline.svg',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Fullname field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),

                            // -- EMAIL INPUT --
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const Gap(8),
                                AuthTextfield(
                                  controller: _emailController,
                                  label: 'Enter your email',
                                  prefixicon: 'assets/svg/envelope.svg',
                                  autofocus: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),

                            // -- PASSWORD INPUT --
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Password',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const Gap(4),
                                AuthTextfieldPassword(
                                  label: 'Enter password',
                                  prefixIcon: 'assets/svg/lock_closed.svg',
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),

                            // -- RETYPE PASSWORD INPUT --
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Re-type password',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const Gap(4),
                                AuthTextfieldPassword(
                                  label: 'Re-type password',
                                  prefixIcon: 'assets/svg/lock_opened.svg',
                                  controller: _rePasswordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please retype your password';
                                    }
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),

                            const Gap(16),

                            // -- SIGN UP BUTTON --
                            // 2. REMOVED BlocConsumer here. Logic is handled at the top.
                            Row(
                              children: [
                                Expanded(
                                  child: SubmitLikeButton(
                                    onPressed: () {
                                      // Trigger Validation on Click
                                      if (_formKey.currentState!.validate()) {
                                        HapticFeedback.mediumImpact();
                                        
                                        // // Extra check just in case
                                        // if (_passwordController.text != _rePasswordController.text) {
                                        //   ScaffoldMessenger.of(context).showSnackBar(
                                        //     const SnackBar(content: Text("Passwords do not match")),
                                        //   );
                                        //   return;
                                        // }

                                        context.read<AuthBloc>().add(
                                          AuthRegisterEvent(
                                            fullName: _nameController.text.trim(),
                                            email: _emailController.text.trim(),
                                            password: _passwordController.text.trim(),
                                          ),
                                        );
                                      }
                                    },
                                    title: 'Sign up',
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),

                            // Divider
                            Row(
                              children: const [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1.0,
                                    endIndent: 10.0,
                                  ),
                                ),
                                Text(
                                  "Or Sign up with",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1.0,
                                    indent: 10.0,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Google Button
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

                            const SizedBox(height: 20),

                            // Login Redirect
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account ? ',
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
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Log in',
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