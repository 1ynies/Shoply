import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundNavigationButton extends StatelessWidget {
  final String Iconpath;
  final double iconwidth;
  final double iconheight;

  const RoundNavigationButton({
    super.key,
    required this.Iconpath,
    required this.iconwidth,
    required this.iconheight,
  });

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Colors.black;
    const double borderWidth = 1;

    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: Color(0x00000000),
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
      ),

      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SvgPicture.asset(
            Iconpath,
            width: iconwidth,
            height: iconheight,
          ),
        ),
      ),
    );
  }
}
