// == PACKAGES IMPORTS =======================
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
// ===========================================

// == FILES IMPORTS ==========================
import 'package:shoplyapp/core/common_widgets/shoply_text&logo.dart';
import 'package:shoplyapp/core/common_widgets/submit_like_button.dart';
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
  bool isChecked = false;

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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // -- NAVIGATE TO HOME PAGE IF AUTH IS SUCCESSFUL --
            Navigator.of(context).pushReplacementNamed('/home');
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
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
                      child: Column(
                        children: [
                          const ShoplyTextlogo(),

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
                          Text(
                            'Create an account',
                            style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),

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
                              ),
                            ],
                          ),

                          // Remember Me Checkbox
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,

                                onChanged: (bool? newValue) {
                                  setState(() {
                                    isChecked = newValue ?? false;
                                  });
                                },
                                activeColor: const Color(0xFF9AE600),
                                checkColor: Colors.white,
                                splashRadius: 20,
                              ),
                              Text(
                                'Remember me',
                                style: GoogleFonts.manrope(
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // -- SIGN UP BUTTON --
                          Row(
                            children: [
                              Expanded(
                                child: BlocConsumer<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    if (state is AuthSuccess) {
                                      // Navigate to Home Page and remove back button history
                                      context.go('/home');
                                    }
                                    if (state is AuthFailure) {
                                      // Optional: Show error snackbar
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text(state.message)),
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
                                        HapticFeedback.mediumImpact();
                                        if (_passwordController.text !=
                                            _rePasswordController.text) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Passwords do not match",
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        context.read<AuthBloc>().add(
                                          AuthRegisterEvent(
                                            fullName: _nameController.text
                                                .trim(),
                                            email: _emailController.text.trim(),
                                            password: _passwordController.text
                                                .trim(),
                                          ),
                                        );
                                      },
                                      title: 'Sign up',
                                    );
                                  },
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
              );
            },
          ),
        ),
      ),
    );
  }
}
