import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/strings.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton(
      {Key? key,
      this.paddingLeft = 26,
      this.paddingTop = 10,
      this.popMessage = const []})
      : super(key: key);

  final double paddingLeft;
  final List<String?> popMessage;
  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(left: paddingLeft, top: paddingTop),
          child: SizedBox(
            width: 30.w,
            height: 30.h,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff27AABF)),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context, popMessage);
                },
                icon: ColorFiltered(
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  child: SvgPicture.asset(Assets.arrowBackIcon),
                ),
                alignment: Alignment.center,
              ),
            ),
          ),
        ));
  }
}
