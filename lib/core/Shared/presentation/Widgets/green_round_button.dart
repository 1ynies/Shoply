

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GreenRoundButton extends StatelessWidget {
  final String Iconpath;
  final double iconwidth;
  final double iconheight;

  const GreenRoundButton({
    super.key,
    required this.Iconpath,
    required this.iconwidth,
    required this.iconheight,
  });
  @override
  Widget build(BuildContext context) {
  

    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: Color(0xFF9AE600),
        shape: BoxShape.circle,
      ),
      // 2. Place the icon inside the container
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



  

