import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/data/models/comment_model.dart';

import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/custom_network_image.dart';

class UserComment extends StatelessWidget {
  const UserComment({Key? key, required this.comment}) : super(key: key);

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 295.w,
          padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 6.h),
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF3FBFC),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${comment.commentor.name} ${comment.commentor.lastname}',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF1A202C),
                  fontSize: 12.sp,
                ),
              ),
              const SizedBox(height: 4.0),
              // Add some spacing between the name and comment
              SizedBox(
                width: 244.w,
                child: Text(
                  comment.comment,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF131313),
                    fontSize: 12.sp,
                  ),
                  textDirection: isArabic(comment.comment)
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                ),
              ),
            ],
          ),
        ),
        // User Avatar....
        CustomNetworkImage(
          imageUrl: comment.commentor.profilePicUrl,
          size: Size(42.w, 42.w),
        ),
      ],
    );
  }
}
