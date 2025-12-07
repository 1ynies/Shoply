import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/features/presentation/widget/round_navigation_button.dart';

class NotificationPage extends StatelessWidget {
  // final List<String> cardData = [];

  final List<String> cardData = ['Item A', 'Item B', 'Item C'];

  bool get _hasCards => cardData.isNotEmpty;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Row(
                mainAxisAlignment: .start,
                children: [
                  const RoundNavigationButton(
                    Iconpath: 'lib/assets/svg/arrow_left.svg',
                    iconwidth: 24,
                    iconheight: 24,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Notification ',
                    style: GoogleFonts.manrope(
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _hasCards 
            ? _filledScreen()
            :  Expanded(child: _emptyScreen())
             
          ],
        ),
      ),
    );
  }

  Widget _emptyScreen() {
    return 
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'lib/assets/images/guy_using _computer.png',
                width: 250,
                height: 250,
              ),
              const SizedBox(height: 16),
              Text(
                'No notifications',
                style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'You have no notifications at the moment',
                style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        
      
    );
  }

  Column _filledScreen() {
    return Column();
  }
}
