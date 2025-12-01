import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoplyTextlogo extends StatelessWidget {
  const ShoplyTextlogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('lib/assets/svg/app_logo.svg', width: 25,height: 30,),
          const SizedBox(width: 10),
          Text(
            'Shoply',
            style: GoogleFonts.manrope(
              textStyle: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
