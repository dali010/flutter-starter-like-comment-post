import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_like_comment/core/utils/strings.dart';
import 'package:flutter_starter_like_comment/core/widgets/snackbar.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/bloc/post_bloc.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/bloc/post_state.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/widgets/comment_input.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/widgets/user_comment.dart';

import '/injection_container.dart' as di;
import '../../../../core/utils/keyboardListener.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/loading_widget.dart';
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
                          return UserComment(comment: state.comments[index]);
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
}
