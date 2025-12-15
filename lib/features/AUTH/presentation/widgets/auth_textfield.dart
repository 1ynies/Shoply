import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextfield extends StatelessWidget {
  final String label;
  final String prefixicon;
  final bool autofocus;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AuthTextfield({
    super.key,
    required this.label,
    required this.prefixicon,
    required this.autofocus,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        //-- Validator --
        validator: validator,
        // -- Controller  -- 
        controller: controller,
        autofocus: autofocus,
        maxLines: 1,
        cursorColor: Colors.black87,
        // Apply Manrope font styling
        style: GoogleFonts.manrope(
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        decoration: InputDecoration(
          // --- Prefix Icon ---
          prefixIcon: Padding(
            padding: .all(10),
            child: SvgPicture.asset(prefixicon, width: 10, height: 10),
          ),

          // --- Focused Border ---
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black87, width: 1),
          ),

          hintText: label,
          // -- NORMAL BORDER -- 
          border: const OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.all(Radius.circular(20)),
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
