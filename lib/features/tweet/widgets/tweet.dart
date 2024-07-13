import 'package:blox/core/common/widgets/profile_picture.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/features/tweet/widgets/tweet_bottom_button.dart';
import 'package:blox/features/tweet/widgets/tweet_bottom_button_bar.dart';
import 'package:flutter/material.dart';

class Tweet extends StatelessWidget {
  const Tweet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                      '1d',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text("Blablablabla bla blabla. " * 20)),
                  ],
                ),
                const SizedBox(height: 8),
                const TweetBottomButtonsBar(),
                const SizedBox(height: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
