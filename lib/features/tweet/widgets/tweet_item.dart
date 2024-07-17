import 'package:blox/core/common/widgets/profile_picture.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/features/tweet/models/post.dart';
import 'package:blox/features/tweet/widgets/tweet_bottom_button_bar.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class TweetItem extends StatelessWidget {
  const TweetItem({
    super.key,
    required this.post,
    required this.onTap,
  });

  final Post post;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final postContent = post.content ?? "";
    final timestamp = post.timestamp ?? DateTime.now();
    final timeAgo = timeago.format(timestamp);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfilePicture.medium(
              image: const NetworkImage(
                'https://abs.twimg.com/sticky/default_profile_images/default_profile.png',
              ),
              onPressed: Scaffold.of(context).openDrawer,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Gohan',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '@Great_Saiyaman',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '·',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        timeAgo,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text(postContent)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TweetBottomButtonsBar(post: post),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
