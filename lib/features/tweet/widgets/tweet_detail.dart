import 'package:blox/core/common/widgets/dot_separator.dart';
import 'package:blox/core/common/widgets/profile_picture.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/features/tweet/bloc/post_bloc/post_bloc.dart';
import 'package:blox/features/tweet/widgets/tweet_detail_bottom_button_bar.dart';
import 'package:blox/features/tweet/widgets/tweet_detail_statisctic_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TweetDetail extends StatelessWidget {
  const TweetDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        final post = state.post;
        final postContent = post?.content ?? "";
        final postCommentsNumber = post?.comments?.length ?? 0;
        final postRepostsNumber = post?.reposts?.length ?? 0;
        final postQuotesNumber = post?.quotes?.length ?? 0;
        final postLikesNumber = post?.likes?.length ?? 0;
        final postViewsNumber = post?.views?.length ?? 0;
        final postBookmarksNumber = post?.bookmarks?.length ?? 0;
        final timestamp = post?.timestamp ?? DateTime.now();
        final formattedTime = DateFormat('HH:mm').format(timestamp);
        final formattedDate = DateFormat('d MMM yy').format(timestamp);

        return Padding(
          padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ProfilePicture.medium(
                        image: const NetworkImage(
                          'https://abs.twimg.com/sticky/default_profile_images/default_profile.png',
                        ),
                        onPressed: Scaffold.of(context).openDrawer,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gohan',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '@Great_Saiyaman',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: context.theme.elevatedButtonTheme.style?.copyWith(
                      minimumSize: const WidgetStatePropertyAll(Size(64, 24)),
                    ),
                    onPressed: () {
                      //TODO: implement this method
                    },
                    child: Text(
                      "Follow",
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onInverseSurface,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      postContent,
                      style: context.textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    formattedTime,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const DotSeparator(),
                  Text(
                    formattedDate,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const DotSeparator(),
                  TweetDetailStatiscticButton(
                    title: "Views",
                    number: postViewsNumber,
                    onTap: null,
                  ),
                ],
              ),
              const Divider(),
              OverflowBar(
                spacing: 16,
                alignment: MainAxisAlignment.start,
                children: [
                  TweetDetailStatiscticButton(
                    title: "Reposts",
                    number: postRepostsNumber,
                    onTap: () {},
                  ),
                  TweetDetailStatiscticButton(
                    title: "Quotes",
                    number: postQuotesNumber,
                    onTap: () {},
                  ),
                  TweetDetailStatiscticButton(
                    title: "Likes",
                    number: postLikesNumber,
                    onTap: () {},
                  ),
                ],
              ),
              const Divider(),
              OverflowBar(
                spacing: 16,
                alignment: MainAxisAlignment.start,
                children: [
                  TweetDetailStatiscticButton(
                    title: "Bookmarks",
                    number: postBookmarksNumber,
                    onTap: () {},
                  ),
                ],
              ),
              const Divider(),
              const TweetDetailBottomButtonsBar(),
            ],
          ),
        );
      },
    );
  }
}
