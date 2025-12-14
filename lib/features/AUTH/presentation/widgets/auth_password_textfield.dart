import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextfieldPassword extends StatefulWidget {
  final String label;
  final String prefixIcon;
  final TextEditingController controller;
  
  // A controller can optionally be passed from the parent widget if needed
  // final TextEditingController? controller;

  const AuthTextfieldPassword({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.controller,
  });

  @override
  State<AuthTextfieldPassword> createState() => _AuthTextfieldPasswordState();
}

class _AuthTextfieldPasswordState extends State<AuthTextfieldPassword> {
  // 1. State variable to track visibility
  bool _isPasswordVisible = false;

  // 2. Internal controller, which should be disposed
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // 3. Dispose the internal controller when the widget is removed
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
      
        controller: widget.controller,
        
        // --- A. Obscure Text with Asterisks ---
        // Obscure text if _isPasswordVisible is false
        obscureText: !_isPasswordVisible,
        obscuringCharacter: '•',
        maxLines: 1,

        cursorColor: Colors.indigo,
        
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
                    ? 'lib/assets/svg/eye_slash.svg' // The open eye icon path
                    : 'lib/assets/svg/eye.svg',      // The closed eye icon path
                height: 24,
                width: 24,
              ),
            ),
            color: Colors.grey.shade700,
          ),

          // --- Styling (Kept from original) ---
          floatingLabelStyle: GoogleFonts.manrope(
            textStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          
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
          
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
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