import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/features/presentation/widget/round_circle%20_with_lock_inside.dart';
import 'package:shoplyapp/features/presentation/widget/round_navigation_button.dart';
import 'package:shoplyapp/features/presentation/widget/submit_like_button.dart';

class EnterOtpPage extends StatefulWidget {
  const EnterOtpPage({super.key});

  @override
  State<EnterOtpPage> createState() => _EnterOtpPageState();
}

class _EnterOtpPageState extends State<EnterOtpPage> {
  final FocusNode _field1Focus = FocusNode();
  final FocusNode _field2Focus = FocusNode();
  final FocusNode _field3Focus = FocusNode();
  final FocusNode _field4Focus = FocusNode();

  // 2. Optional: Controllers to get the final value
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();

  @override
  void dispose() {
    _field1Focus.dispose();
    _field2Focus.dispose();
    _field3Focus.dispose();
    _field4Focus.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left : 16,top: 16),
              child: Row(
                mainAxisAlignment: .start,
                children: [
                  const RoundNavigationButton(
                    Iconpath: 'lib/assets/svg/arrow_left.svg',
                    iconwidth: 24,
                    iconheight: 24,
                  ),
                ],
              ),
            ),
            Column (
              children: [
                Center(
                  child: Column(
                    children: [
                      RoundCircleWithLockInside(),
                      const SizedBox(height: 16),
                      Text(
                        'Check your email inbox',
                        style: GoogleFonts.manrope(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'We’ve sent the code to your emails inbox',
                        style: GoogleFonts.manrope(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      _otpTextFields(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SubmitLikeButton(
                          onPressed: () {},
                          title: 'Verify',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _tryAgainButton(
                          onPressed: () {},
                          title: 'Try again',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _tryAgainButton({
    required VoidCallback onPressed,
    required String title,
  }) {
    return SizedBox(
      // width: 100 ,
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 1.5, color: const Color(0xff0000000)),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xfffffffff),
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
          child: Text(
            title,
            style: GoogleFonts.manrope(
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  Padding _otpTextFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Field 1
          Expanded(
            child: _buildPinField(
              focusNode: _field1Focus,
              controller: _controller1,
              nextFocusNode: _field2Focus,
            ),
          ),
          const SizedBox(width: 12.0),
          // Field 2
          Expanded(
            child: _buildPinField(
              focusNode: _field2Focus,
              controller: _controller2,
              nextFocusNode: _field3Focus,
            ),
          ),
          const SizedBox(width: 12.0),
          // Field 3
          Expanded(
            child: _buildPinField(
              focusNode: _field3Focus,
              controller: _controller3,
              nextFocusNode: _field4Focus,
            ),
          ),
          const SizedBox(width: 12.0),
          // Field 4 (No nextFocusNode)
          Expanded(
            child: _buildPinField(
              focusNode: _field4Focus,
              controller: _controller4,
              nextFocusNode: null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPinField({
    required FocusNode focusNode,
    required TextEditingController controller,
    FocusNode? nextFocusNode,
  }) {
    return Container(
      // --- STYLING (Rounded Shadowed Card) ---
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(
          color: const Color(0xFF000000), // The color of the border
          width: 0.5, // The desired border width
        ),
      ),

      // --- INPUT FIELD ---
      child: TextField(
        controller: controller,
        focusNode: focusNode,

        // --- RESTRICTIONS ---
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        // Enforce the one-digit limit
        maxLength: 1,
        // Only allow digits
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],

        // --- FOCUS SHIFTING LOGIC ---
        onChanged: (value) {
          if (value.length == 1) {
            // Move to the next field if a character is entered
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            } else {
              // If it's the last field, close the keyboard
              focusNode.unfocus();
              // Optional: You can trigger a submission action here
              print('Pin entered: $completePin');
            }
          }
        },

        // --- DECORATION ---
        decoration: const InputDecoration(
          // Remove default border
          border: InputBorder.none,
          // Hide the 0/1 counter text
          counterText: "",
          contentPadding: const EdgeInsets.all(12.0),
        ),

        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  // -- This function is neccessary to be able to be able to recover the whole pin entered by the user --
  String get completePin {
    return _controller1.text +
        _controller2.text +
        _controller3.text +
        _controller4.text;
  }
}
