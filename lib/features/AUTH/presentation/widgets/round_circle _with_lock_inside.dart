import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class RoundCircleWithLockInside extends StatelessWidget {
  const RoundCircleWithLockInside({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color(0xff9AE600),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(30),
        child: SvgPicture.asset(
          'assets/svg/lock_closed.svg',
          
        ),
      ),
    );
  }
}
