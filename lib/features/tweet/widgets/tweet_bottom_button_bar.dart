import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/features/profil/bloc/app_user_detail_bloc/app_user_bloc.dart';
import 'package:blox/features/tweet/bloc/post_bloc/post_bloc.dart';
import 'package:blox/features/tweet/models/post.dart';
import 'package:blox/features/tweet/widgets/tweet_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TweetBottomButtonsBar extends StatelessWidget {
  const TweetBottomButtonsBar({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final postRepliesNumber = post.replies?.length ?? 0;
    final postRepostsNumber = post.reposts?.length ?? 0;
    final postLikesNumber = post.likes?.length ?? 0;
    final postViewsNumber = post.views?.length ?? 0;
    final appUserId = context.appUserBloc.state.appUser?.id;
    final postLikes = post.likes ?? [];
    bool isLikedByUser = postLikes.contains(appUserId);

    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TweetBottomButton(
                  onTap: () {
                    //TODO: implement this function
                  },
                  icon: Icons.chat_bubble_outline_rounded,
                  number: postRepliesNumber,
                ),
              ),
              Expanded(
                child: TweetBottomButton(
                  onTap: () {
                    //TODO: implement this function
                  },
                  icon: Icons.repeat_rounded,
                  number: postRepostsNumber,
                ),
              ),
              Expanded(
                child: TweetBottomButton(
                  onTap: () {
                    if (isLikedByUser) {
                      context.read<PostBloc>().add(
                            UpdatePost(
                              post.copyWith(
                                likes: postLikes..remove(appUserId),
                              ),
                            ),
                          );
                    } else {
                      if (appUserId != null) {
                        context.read<PostBloc>().add(
                              UpdatePost(
                                post.copyWith(
                                  likes: postLikes..add(appUserId),
                                ),
                              ),
                            );
                      }
                    }
                  },
                  icon: isLikedByUser
                      ? Icons.favorite
                      : Icons.favorite_outline_rounded,
                  iconColor: isLikedByUser ? Colors.red : null,
                  number: postLikesNumber,
                ),
              ),
              Expanded(
                child: TweetBottomButton(
                  onTap: () {
                    //TODO: implement this function
                  },
                  icon: Icons.bar_chart_outlined,
                  number: postViewsNumber,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: TweetBottomButton(
                  onTap: () {
                    //TODO: implement this function
                  },
                  icon: Icons.bookmark_outline_rounded,
                ),
              ),
              Expanded(
                child: TweetBottomButton(
                  onTap: () {
                    //TODO: implement this function
                  },
                  icon: Icons.share_outlined,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
