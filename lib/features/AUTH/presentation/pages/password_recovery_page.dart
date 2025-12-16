// == PACKAGES IMPORTS =======================
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io'; // <--- NEW: Required to check if Platform.isAndroid
import 'package:android_intent_plus/android_intent.dart'; // <--- NEW: For opening Android Email App
import 'package:android_intent_plus/flag.dart';
// ===========================================

// == FILES IMPORTS ==========================
import 'package:shoplyapp/features/AUTH/presentation/pages/loginpage.dart';
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
  // -- FORM KEY --
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
            // -- UPGRADED SNACKBAR --
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  // state.message.isNotEmpty
                      // ? 
                      state.message
                      // : 'There might have been a problem, please try again'
                      ,
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // --- HEADER ---
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

                // --- TEXT & TEXT FIELD ---
                Center(
                  child: Column(
                    children: [
                      const RoundCircleWithLockInside(),
                      const SizedBox(height: 16),
                      Text(
                        'Password recovery',
                        style: GoogleFonts.manrope(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Enter your email to recover your password',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      // -- EMAIL TEXT FIELD -- 
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 20,
                        ),
                        child: AuthTextfield(
                          controller: _emailController,
                          autofocus: true,
                          label: 'Enter your email',
                          prefixicon: 'assets/svg/envelope.svg',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your email to recover password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // --- RECOVER PASSWORD BUTTON ---
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            
                            return SubmitLikeButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  HapticFeedback.mediumImpact();
                                  // Trigger Bloc Event
                                  context.read<AuthBloc>().add(
                                    AuthResetPasswordEvent(
                                      _emailController.text.trim(),
                                    ),
                                  );
                                }
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
      ),
    );
  }

  // --- ALERT DIALOG  ---
  void _showCheckEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Column(
            children: [
              Icon(Icons.mark_email_read, size: 50, color: Color(0xFf9AE600)),
              const Gap(10),
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
            // 1. Open Email App Button 
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9AE600),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(double.infinity, 45),
              ),

              onPressed: () async {
                try {
                  if (Platform.isAndroid) {
                    // ANDROID: Opens the specific "Inbox" activity
                    const intent = AndroidIntent(
                      action: 'android.intent.action.MAIN',
                      category: 'android.intent.category.APP_EMAIL',
                      flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
                    );
                    await intent.launch();
                  } else if (Platform.isIOS) {
                    // Try to open Apple Mail App specifically (Inbox view)
                    final Uri mailUrl = Uri.parse("message://");

                    if (await canLaunchUrl(mailUrl)) {
                      await launchUrl(mailUrl);
                    } else {
                      //  Fallback: If they deleted Apple Mail, open their default email app (Gmail/Outlook)
                      final Uri emailLaunchUri = Uri(scheme: 'mailto');
                      await launchUrl(
                        emailLaunchUri,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  }
                } catch (e) {
                  // -- SHOWS THE SNACKBAR WITH ERROR MESSAGE
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Could not launch email app"),
                        backgroundColor: Colors.red.shade400,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }
                }
              },

              child: Text(
                "Open emails app",
                style: GoogleFonts.manrope(
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // --  BACK TO LOGIN PAGE TEXT BUTTON -- 
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
