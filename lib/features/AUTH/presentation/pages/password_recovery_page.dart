// == PACKAGES IMPORTS =======================
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart'; 
// ===========================================

// == FILES IMPORTS ==========================
import 'package:shoplyapp/features/AUTH/presentation/pages/loginpage.dart';
// UPDATED IMPORT
import 'package:shoplyapp/core/common_widgets/round_navigation_button.dart';
import 'package:shoplyapp/core/common_widgets/submit_like_button.dart';
import 'package:shoplyapp/features/AUTH/presentation/bloc/auth_bloc.dart';
import 'package:shoplyapp/features/AUTH/presentation/widgets/auth_textfield.dart';
import 'package:shoplyapp/features/AUTH/presentation/widgets/round_circle%20_with_lock_inside.dart';
// ===========================================



class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({super.key});

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthPasswordResetSent) {
            // Success: Show the Alert Dialog
            _showCheckEmailDialog(context);
          }
          if (state is AuthError) {
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(state.message), backgroundColor: Colors.red),
             );
          }
        },
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // --- Header ---
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     RoundNavigationButton(
                      onTap: () => Navigator.of(context).pop(),
                      Iconpath: 'assets/svg/arrow_left.svg',
                      iconwidth: 24,
                      iconheight: 24,
                    ),
                  ],
                ),
              ),

              // --- Content ---
              Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        const RoundCircleWithLockInside(),
                        const SizedBox(height: 16),
                        Text(
                          'Password recovery',
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Enter your email to recover your password',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.manrope(
                              textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                          child: AuthTextfield(
                            controller: _emailController,
                            autofocus: true,
                            label: 'Enter your email',
                            prefixicon: 'assets/svg/envelope.svg',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // --- Button ---
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          return SubmitLikeButton(
                            onPressed: () {
                               if (_emailController.text.trim().isEmpty) {
                                 ScaffoldMessenger.of(context).showSnackBar(
                                   const SnackBar(content: Text("Please enter your email")),
                                 );
                                 return;
                               }
                               // Trigger Bloc Event
                               context.read<AuthBloc>().add(
                                 AuthResetPasswordEvent(_emailController.text.trim())
                               );
                            },
                            title: 'Recover password',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widget Function for Alert Dialog ---
  void _showCheckEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // User must interact with buttons
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Column(
            children: [
              Icon(Icons.mark_email_read, size: 50, color: Color(0xFFADF50F)),
              SizedBox(height: 10),
              Text("Check your email", textAlign: TextAlign.center),
            ],
          ),
          content: Text(
            "We have sent a recovery link to ${_emailController.text}.\nPlease check your inbox.",
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(fontSize: 14),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsOverflowDirection: VerticalDirection.down, 
          actions: [
            // 1. Open Email App Button (UPDATED to use url_launcher)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFADF50F),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                minimumSize: const Size(double.infinity, 45), 
              ),
              onPressed: () async {
                // Creates a 'mailto:' URI which the OS handles by opening the default email app
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: '', 
                );

                try {
                  if (await canLaunchUrl(emailLaunchUri)) {
                    await launchUrl(emailLaunchUri);
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Could not launch email app")),
                      );
                    }
                  }
                } catch (e) {
                   if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Could not launch email app")),
                      );
                   }
                }
              },
              child: const Text("Open emails app"),
            ),
            
            const SizedBox(height: 10),

            // 2. Back to Login Button
            TextButton(
              onPressed: () {
                // Navigate back to Login Page and clear stack
                 Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
              },
              child: Text(
                "Back to Login",
                style: GoogleFonts.manrope(color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }
}