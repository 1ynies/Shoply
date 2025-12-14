import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubmitLikeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const SubmitLikeButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 100 ,
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            100,
          ), // High radius for pill shape
          boxShadow: [
            BoxShadow(
              // Simulating the shadow seen in the image (appears dark, offset below)
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 5), // Shadow drops downwards
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff9AE600),
            foregroundColor: Colors.black, // Text color
            elevation:
                0, // Disable default elevation to control shadow manually
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                100,
              ), // Matches the decoration radius
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          ),
          child: Text(title ,style: GoogleFonts.manrope(textStyle: TextStyle(fontSize: 20 , fontWeight: FontWeight.w500)), ),
        ),
      ),
    );
  }
}





