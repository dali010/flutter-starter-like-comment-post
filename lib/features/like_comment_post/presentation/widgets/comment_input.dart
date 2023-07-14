import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/functions.dart';
import '../../../../core/utils/strings.dart';

class CommentInput extends StatefulWidget {
  const CommentInput(
      {Key? key, required this.onTap, required this.textEditingController, required this.isKeyboardVisible})
      : super(key: key);

  final VoidCallback onTap;
  final TextEditingController textEditingController;
  final bool isKeyboardVisible;

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  TextDirection textDirection = TextDirection.rtl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      width: 335.w,
      margin: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: widget.textEditingController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color(0xFFBFBFBF),
            ),
            borderRadius: BorderRadius.circular(50.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: widget.isKeyboardVisible ? Colors.lightBlue : const Color(0xFFBFBFBF),
            ),
            borderRadius: BorderRadius.circular(50.0),
          ),
          hintText: '... اكتب تعليقا',
          prefixIcon: IconButton(
            onPressed: widget.onTap,
            icon: SvgPicture.asset(
              Assets.sendCommentIcon,
              color: widget.textEditingController.text.length > 4
                  ? Colors.lightBlue
                  : Colors.grey,
              width: 17.w,
              height: 17.h,
            ),
          ),
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: Color(0xFFBFBFBF),
          ),
        ),
        // textAlign: TextAlign.end,
        onChanged: (String value) {
          setState(() {
            textDirection =
                isArabic(value) ? TextDirection.rtl : TextDirection.ltr;
          });
        },
        textDirection: textDirection,
      ),
    );
  }
}
