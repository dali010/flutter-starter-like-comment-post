import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_like_comment/core/utils/strings.dart';
import 'package:flutter_starter_like_comment/core/widgets/snackbar.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/bloc/post_bloc.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/bloc/post_state.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/widgets/comment_input.dart';

import '/injection_container.dart' as di;
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/keyboardListener.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../data/models/comment_model.dart';
import '../bloc/post_event.dart';

class CommentsPage extends StatefulWidget {
  final String serviceId;

  const CommentsPage({Key? key, required this.serviceId}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage>
    with WidgetsBindingObserver {
  final _scrollController = ScrollController();
  BuildContext? blocContext;

  final TextEditingController _textEditingController = TextEditingController();
  bool _isKeyboardVisible = false;
  TextDirection textDirection = TextDirection.rtl;
  bool keyboard = false;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addObserver(KeyboardListenerCheck(
      onKeyboardOpened: () {
        setState(() {
          keyboard = true;
        });
        // Perform any actions you need when the keyboard is opened
      },
      onKeyboardClosed: () {
        setState(() {
          keyboard = false;
        });
        // Perform any actions you need when the keyboard is closed
      },
      context: context,
    ));
    _textEditingController.addListener(_checkKeyboardVisibility);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9)) {
      loadNextComments(blocContext!);
    }
  }

  void loadNextComments(BuildContext context) {
    // context.read<PostBloc>().add(const LoadNextCommentsEvent(serviceId: Strings.serviceId));
    BlocProvider.of<PostBloc>(context)
        .add(const LoadNextCommentsEvent(serviceId: Strings.serviceId));
  }

  void _checkKeyboardVisibility() {
    final currentFocus = FocusScope.of(context);
    setState(() {
      _isKeyboardVisible = currentFocus.hasFocus;
    });
  }

  void _addComment(BuildContext context) {
    String comment = _textEditingController.text;
    if (comment.length < 5) {
      SnackBarMessage().showErrorSnackBar(
          message: "يجب أن يحتوي التعليق على أكثر من 4 أحرف", context: context);
    } else {
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<PostBloc>()
        ..add(GetAllCommentsEvent(serviceId: widget.serviceId)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(child: _buildBody(context))),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      blocContext = context;
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
                        controller: _scrollController,
                        itemCount: state.comments.length,
                        padding: EdgeInsets.symmetric(vertical: 67.h),
                        itemBuilder: (BuildContext context, int index) {
                          return commentWidget(
                              context, state.comments[index], Strings.userId);
                        },
                      ),
                    ),
                    CommentInput(
                        onTap: () {
                          _addComment(context);
                        },
                        textEditingController: _textEditingController,
                        isKeyboardVisible: keyboard)
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
                    CommentInput(
                      onTap: () {
                        _addComment(context);
                      },
                      textEditingController: _textEditingController,
                      isKeyboardVisible: keyboard,
                    )
                  ],
                ),
          Container(
              margin: EdgeInsets.only(top: 24.h),
              child: CustomBackButton(
                  popMessage: [state.comments.length.toString()]))
        ],
      );
    });
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
