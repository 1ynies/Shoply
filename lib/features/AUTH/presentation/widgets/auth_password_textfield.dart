import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextfieldPassword extends StatefulWidget {
  final String label;
  final String prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AuthTextfieldPassword({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.controller,
    this.validator,
  });

  @override
  State<AuthTextfieldPassword> createState() => _AuthTextfieldPasswordState();
}

class _AuthTextfieldPasswordState extends State<AuthTextfieldPassword> {
  //  State variable to track visibility
  bool _isPasswordVisible = false;

  //  Internal controller, which should be disposed
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    //  Dispose the internal controller when the widget is removed
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        // --- VALIDATOR ---
        validator: widget.validator,
      
        controller: widget.controller,
        
        // --- A. Obscure Text with Asterisks ---
        // Obscure text if _isPasswordVisible is false
        obscureText: !_isPasswordVisible,
        obscuringCharacter: '•',
        maxLines: 1,

        cursorColor: Colors.black87,
        
        // Apply Manrope font styling
        style: GoogleFonts.manrope(
          textStyle: const TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),

        decoration: InputDecoration(
          // --- Prefix Icon ---
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(widget.prefixIcon, width: 18, height: 18),
          ),

          // --- Suffix Icon Toggle Logic ---
          suffixIcon: IconButton(
            // Use setState to toggle the visibility state
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
            // Change the Icon based on the state
            icon: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(
                // Note: Ensure these paths are correct for your project structure
                _isPasswordVisible
                    ? 'assets/svg/eye_slash.svg' // The open eye icon path
                    : 'assets/svg/eye.svg',      // The closed eye icon path
                height: 24,
                width: 24,
              ),
            ),
            color: Colors.grey.shade700,
          ),

          
          // --- Focused Border ---
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
              color: Colors.black87,
              width: 1,
            ),
          ),
          
          hintText: widget.label, // Access properties via widget.
          // --- Normal Border ---
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          // --- ERROR BORDER (Red when invalid) ---
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.red, width: 1),
          ),
          // --- FOCUSED ERROR BORDER (Red when invalid and clicked) ---
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
          
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
        ),
      ),
    );
  }
}