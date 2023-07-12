import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/like_comment_widget.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
          color: const Color(0xFF023047),
          width: 1.5,
        ),

        ),
        padding: const EdgeInsets.all(10),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Image(
              image: AssetImage("assets/images/flutter_bird.png"),
              width: 100,
              height: 100,
            ),
            Column(
              children: [
                Divider(
                  thickness: 1,
                  color: Colors.grey.withOpacity(0.4),
                  indent: 5.0,
                  endIndent: 5.0,
                  height: 8.0, // Set height of divider
                ),
                 const SizedBox(height: 5),
                 const Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     LikeCommentWidget(icon: 'assets/icons/like_icon.svg', text: 'Like'),
                     LikeCommentWidget(icon: 'assets/icons/comment_icon.svg', text: 'Comment')
                   ],
                 )
              ],
            )
          ],
        ),
      ),
    );
  }
}
