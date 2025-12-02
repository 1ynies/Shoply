import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplyapp/features/presentation/widget/buttom_navbar.dart';
import 'package:shoplyapp/features/presentation/widget/green_round_button.dart';
import 'package:shoplyapp/features/presentation/widget/round_navigation_button.dart';
import 'package:shoplyapp/features/presentation/widget/search_field.dart';
import 'package:shoplyapp/features/presentation/widget/shoply_text&logo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ButtomNavbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: .all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _topPart(),
                const SizedBox(height: 16),
                _searchSection(),
                const SizedBox(height: 16),

                _adCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

// -- this is the ad space -- 
  Container _adCard() {
    return Container(
      width: 100,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF030712),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'Get your special\nsale up to 50%',
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: .start,
                  children: [
                    Container(
                      width: 100,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xFF9AE600),
                        borderRadius: BorderRadius.circular(50),
                      ),

                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            'Shop now',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),
                    GreenRoundButton(
                      Iconpath: 'lib/assets/svg/arrow_up_right.svg',
                      iconwidth: 24,
                      iconheight: 24,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 16),
            Image.asset(
              'lib/assets/images/t-shirt_turning_right.png',
              width: 130,
              height: 130,
            ),
          ],
        ),
      ),
    );
  }

  Row _searchSection() {
    return Row(
      crossAxisAlignment: .center,
      children: [
        Expanded(child: SearchField()),
        const SizedBox(width: 16),
        GreenRoundButton(
          Iconpath: 'lib/assets/svg/filter.svg',
          iconwidth: 24,
          iconheight: 24,
        ),
      ],
    );
  }

  Row _topPart() {
    return Row(
      children: [
        ShoplyTextlogo(),
        const Spacer(),
        RoundNavigationButton(
          Iconpath: 'lib/assets/svg/cart.svg',
          iconwidth: 24,
          iconheight: 24,
        ),
        const SizedBox(width: 10),
        RoundNavigationButton(
          Iconpath: 'lib/assets/svg/bell.svg',
          iconheight: 30,
          iconwidth: 30,
        ),
      ],
    );
  }
}
