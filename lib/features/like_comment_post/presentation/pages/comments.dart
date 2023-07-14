import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_like_comment/core/utils/strings.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/data/models/user_id_model.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/bloc/post_bloc.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/bloc/post_state.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../data/models/comment_model.dart';
import '../bloc/post_event.dart';
import '/injection_container.dart' as di;


class CommentsPage extends StatefulWidget {
  final String serviceId;

  const CommentsPage(
      {Key? key, required this.serviceId})
      : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isKeyboardVisible = false;
  TextDirection textDirection = TextDirection.rtl;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_checkKeyboardVisibility);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _checkKeyboardVisibility() {
    final currentFocus = FocusScope.of(context);
    setState(() {
      _isKeyboardVisible = currentFocus.hasFocus;
    });
  }

  void _addComment(BuildContext context) {
    // Trigger the AddCommentEvent and pass the serviceId and comment text
    BlocProvider.of<PostBloc>(context).add(
      AddCommentEvent(
        serviceId: widget.serviceId,
        comment: _textEditingController.text,
      ),
    );
    setState(() {
      _textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<PostBloc>()
        ..add(GetAllCommentsEvent(serviceId: widget.serviceId)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: _buildBody(context)),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state.loading) {
        return const LoadingWidget();
      }

      return Stack(
        children: [
          state.comments.isNotEmpty
              ? Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: state.comments.length,
                  padding: EdgeInsets.symmetric(vertical: 67.h),
                  itemBuilder: (BuildContext context, int index) {
                    return commentWidget(context, state.comments[index],
                        Strings.userId);
                  },
                ),
              ),
              commentInput(context),
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "لا يوجد تعليقات بعد",
                  // Display message if no comments are available
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xffa0abc0),
                    fontFamily: "Cairo",
                  ),
                ),
              ),
              SizedBox(
                height: 286.h,
              ),
              commentInput(context),
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 24.h),
              child: CustomBackButton(popMessage: [state.comments.length.toString()]))
        ],
      );
    });
  }

  Widget commentSettingsBottomSheet(
      String id, BuildContext context, bool canDeleteComment) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
      height: canDeleteComment ? 210.h : 140.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (canDeleteComment)
            Column(
              children: [
                InkWell(
                  onTap: () {
                    // BlocProvider.of<PostBloc>(context)
                    //     .add(DeleteCommentEvent(commentId: id));
                    // Navigator.pop(context);
                  },
                  child: Container(
                    width: 316.w,
                    padding: EdgeInsets.symmetric(horizontal: 44.w, vertical: 19.h),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF3FBFC),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0x4573B8B8),
                              blurRadius: 2,
                              offset: Offset(0, 2)
                          )
                        ]
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/trash_icon.svg',
                          height: 30.h,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          'أقوم بمسح هذا التعليق',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF1A202C),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),
          InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => ReportWidget(
              //         reportId: id,
              //         reportType: 'Comment',
              //       )),
              // );
            },
            child: Container(
              width: 316.w,
              padding: EdgeInsets.symmetric(horizontal: 44.w, vertical: 19.h),
              decoration: BoxDecoration(
                  color: const Color(0xFFF3FBFC),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x4573B8B8),
                        blurRadius: 2,
                        offset: Offset(0, 2)
                    )
                  ]
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/icons/report.svg',
                    height: 30.h,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    "أقوم بالإبلاغ عن مشاركة مخالفة",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF1A202C),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget commentWidget(
      BuildContext context, CommentModel comment, String? currentUserId) {
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 3 Dots Button...
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        builder: (BuildContext newContext) {
                          return commentSettingsBottomSheet(comment.id, context,
                              currentUserId == comment.userId.id);
                        },
                      );
                    },
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.more_horiz,
                        color: Color(0xFFAEC5C8),
                      ),
                    ),
                  ),
                  Text(
                    '${comment.commentor.name} ${comment.commentor.lastname}',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF1A202C),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
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

  Widget commentInput(BuildContext context) {
    return Container(
      height: 46.h,
      width: 335.w,
      margin: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color(0xFFBFBFBF),
            ),
            borderRadius: BorderRadius.circular(50.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color(0xFFBFBFBF),
            ),
            borderRadius: BorderRadius.circular(50.0),
          ),
          hintText: '... اكتب تعليقا',
          prefixIcon: IconButton(
            onPressed: () {
              if (_textEditingController.text.length < 5){
                // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                //   showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return StateDialog(
                //           message: "يجب أن يحتوي التعليق على أكثر من 5 أحرف ", dialogType: DialogType.error);
                //     },
                //   );
                // });
              }else{
                _addComment(context);
              }
            },
            icon: SvgPicture.asset(
              'assets/icons/send_button.svg',
              color: _isKeyboardVisible ? Colors.lightBlue : Colors.grey,
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
          textDirection = isArabic(value)
              ? TextDirection.rtl
              : TextDirection.ltr;
        },
        textDirection: textDirection,
      ),
    );
  }
}
