import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/bloc/post_bloc.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/bloc/post_event.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/bloc/post_state.dart';

import '/injection_container.dart' as di;
import '../../../../core/utils/strings.dart';
import '../../../../core/widgets/snackbar.dart';
import '../widgets/like_comment_widget.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => di.sl<PostBloc>(),
        child: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {
            if (state.error != "") {
              SnackBarMessage()
                  .showErrorSnackBar(message: state.error, context: context);
            }
          },
          builder: (context, state) {
            return BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(
                          image: AssetImage(Assets.flutterIcon),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                LikeCommentWidget(
                                    icon: state.postLikedSuccess
                                        ? Assets.redHeartIcon
                                        : Assets.blankHeartIcon,
                                    text: 'Like',
                                    onTap: () {
                                      likePost(context);
                                    }),
                                LikeCommentWidget(
                                  icon: Assets.commentIcon,
                                  text: 'Comment',
                                  onTap: () {},
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}

void likePost(BuildContext context) {
  BlocProvider.of<PostBloc>(context)
      .add(const LikePostEvent(serviceId: Strings.serviceId));
}

void localLike(BuildContext context) {
  BlocProvider.of<PostBloc>(context).add(LocalLike());
}
