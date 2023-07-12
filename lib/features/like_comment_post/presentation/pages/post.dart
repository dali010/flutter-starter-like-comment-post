import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        height: 300,
        width: MediaQuery.of(context).size.width /2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
          color: const Color(0xFF023047),
          width: 1.5,
        ),

        ),
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child:  Column(
          children: [
            const Image(
              image: AssetImage("assets/images/flutter_bird.png"),
              width: 100,
              height: 100,
            ),
            Column(
              children: [
                Divider(
                  color: Colors.grey[700],
                  indent: 55.0,
                  endIndent: 55.0,
                  height: 8.0, // Set height of divider
                ),
                 Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/like_icon.svg'
                    )
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
