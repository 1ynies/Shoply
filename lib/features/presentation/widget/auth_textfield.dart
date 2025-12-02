import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextfield extends StatelessWidget {
  final String label;
  final String prefixicon;

  const AuthTextfield({
    super.key,
    required this.label,
    required this.prefixicon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        maxLines: 1,
        cursorColor: Colors.black87,
        style: GoogleFonts.manrope(
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        decoration: InputDecoration(
          
          prefixIcon: Padding(
            padding: .all(10),
            child: SvgPicture.asset(prefixicon, width: 10, height: 10),
          ),
          floatingLabelStyle: const TextStyle(
            color: Colors.black87,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black87,
              width: 1,
            ), // Border when focused
          ),
          labelText: label,
          border: const OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.all(Radius.circular(20)),
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


