import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LikeCommentWidget extends StatefulWidget {
  const LikeCommentWidget({Key? key, required this.icon, required this.text})
      : super(key: key);

  final String icon;
  final String text;

  @override
  State<LikeCommentWidget> createState() => _LikeCommentWidgetState();
}

class _LikeCommentWidgetState extends State<LikeCommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(widget.icon),
        const SizedBox(width: 5),
        Text(
          widget.text,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        )
      ],
    );
  }
}
