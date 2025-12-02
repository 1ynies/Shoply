import 'package:flutter/material.dart';

// -- This widget is the Sign in with google button to be found in welcome screen & Auth screens --

class GoogleSignInButton extends StatelessWidget {
  /// The function to call when the button is pressed.
  final VoidCallback onPressed;

  const GoogleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // You'll typically use the theme's colors or custom branding colors here.
    const Color buttonBackgroundColor = Colors.white;
    const Color buttonTextColor = Colors.black87;
    const double logoHeight = 24.0;

    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // Set the background color to white
          backgroundColor: buttonBackgroundColor,
          // Remove shadow for a cleaner look
          elevation: 0,
          // Define padding and shape
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: const BorderSide(
              color: Colors.grey,
              width: 0.5,
            ), // Subtle border
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Keep the Row tight to its children
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('lib/assets/images/google_icon.png', height: logoHeight),
      
            const SizedBox(width: 24.0), // Spacing between logo and text
            // 2. Button Text
            const Text(
              'Sign in with Google',
              style: TextStyle(
                color: buttonTextColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//