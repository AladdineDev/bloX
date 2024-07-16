import 'package:blox/core/common/widgets/dot_separator.dart';
import 'package:blox/core/common/widgets/profile_picture.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/features/tweet/widgets/tweet_detail_bottom_button_bar.dart';
import 'package:blox/features/tweet/widgets/tweet_detail_statisctic_button.dart';
import 'package:flutter/material.dart';

class TweetDetail extends StatelessWidget {
  const TweetDetail({super.key});

  @override
  Widget build(BuildContext context) {
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
                  "Just wrapped up my first day as a superhero!"
                  "Absolutely amazing. Took down a ton of notes."
                  "Learned so many new techniques.\n\n"
                  "Ready to save the world!\n"
                  "Today was a massive victory overall.",
                  style: context.textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(
                '23:59',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              const DotSeparator(),
              Text(
                '16 Jul 24',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              const DotSeparator(),
              const TweetDetailStatiscticButton(
                title: "Views",
                number: 15,
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
                number: 133,
                onTap: () {},
              ),
              TweetDetailStatiscticButton(
                title: "Quotes",
                number: 12,
                onTap: () {},
              ),
              TweetDetailStatiscticButton(
                title: "Likes",
                number: 8790,
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
                number: 33,
                onTap: () {},
              ),
            ],
          ),
          const Divider(),
          const TweetDetailBottomButtonsBar(),
        ],
      ),
    );
  }
}
