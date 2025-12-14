import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:shoplyapp/core/common_widgets/shoply_text&logo.dart';
import 'package:shoplyapp/core/common_widgets/submit_like_button.dart';
import 'package:shoplyapp/features/AUTH/presentation/bloc/auth_bloc.dart';
import 'package:shoplyapp/features/AUTH/presentation/widgets/auth_password_textfield.dart';
import 'package:shoplyapp/features/AUTH/presentation/widgets/auth_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // ADDED CONTROLLERS
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
             // Navigate to Home
             // Navigator.of(context).pushReplacementNamed('/home');
          }
          if (state is AuthError) {
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const ShoplyTextlogo(),
                  // ... (Headers) ...
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fullname', style: Theme.of(context).textTheme.bodySmall),
                      AuthTextfield(
                        controller: _nameController,
                        autofocus: false,
                        label: 'Enter your fullname',
                        prefixicon: 'lib/assets/svg/user_outline.svg',
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email', style: Theme.of(context).textTheme.bodySmall),
                      AuthTextfield(
                        controller: _emailController,
                        autofocus: false,
                        label: 'Enter your email',
                        prefixicon: 'lib/assets/svg/envelope.svg',
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Password', style: Theme.of(context).textTheme.bodySmall),
                      AuthTextfieldPassword(
                        controller: _passwordController,
                        label: 'Enter password',
                        prefixIcon: 'lib/assets/svg/lock_closed.svg',
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Re-type password', style: Theme.of(context).textTheme.bodySmall),
                      AuthTextfieldPassword(
                        controller: _rePasswordController,
                        label: 'Re-type password',
                        prefixIcon: 'lib/assets/svg/lock_opened.svg',
                      ),
                    ],
                  ),
                  // ... (Checkbox) ...
                  Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) return const Center(child: CircularProgressIndicator());
                            
                            return SubmitLikeButton(
                              onPressed: () {
                                HapticFeedback.mediumImpact();
                                if (_passwordController.text != _rePasswordController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
                                  return;
                                }
                                context.read<AuthBloc>().add(AuthRegisterEvent(
                                  fullName: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                ));
                              },
                              title: 'Sign up',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  // ... (Google Sign in & Login Link) ...
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}