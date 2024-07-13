import 'package:blox/core/common/widgets/spinner.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/features/tweet/views/tweet_post_screen.dart';
import 'package:flutter/material.dart';

class TweetPostLengthIndicator extends StatelessWidget {
  const TweetPostLengthIndicator({
    super.key,
    required this.postController,
  });

  final TextEditingController postController;

  @override
  Widget build(BuildContext context) {
    final counter = TweetPostScreen.postMaxLength - postController.text.length;
    final hideSpinner = counter <= -10;
    return IconButton(
      onPressed: null,
      icon: Stack(
        alignment: Alignment.center,
        children: [
          if (!hideSpinner) _getSpinner(context),
          _getText(context, counter: counter)
        ],
      ),
    );
  }

  Widget _getSpinner(BuildContext context) {
    final spinnerValue =
        postController.text.length / TweetPostScreen.postMaxLength;
    switch (postController.text.length) {
      case >= TweetPostScreen.postMaxLength:
        return Spinner.small(
          dimension: 28,
          strokeWidth: 3,
          value: spinnerValue,
          color: context.colorScheme.error,
          backgroundColor: context.colorScheme.onSurface,
        );
      case >= TweetPostScreen.postMaxLengthBeforeWarning:
        return Spinner.small(
          dimension: 28,
          strokeWidth: 3,
          value: spinnerValue,
          color: context.colorScheme.errorContainer,
          backgroundColor: context.colorScheme.onSurface,
        );
      default:
        return Spinner.small(
          dimension: 24,
          value: spinnerValue,
          color: context.colorScheme.primary,
          backgroundColor: context.colorScheme.onSurface,
        );
    }
  }

  Widget _getText(
    BuildContext context, {
    required int counter,
  }) {
    switch (postController.text.length) {
      case >= TweetPostScreen.postMaxLength:
        return Text(
          '$counter',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.error,
          ),
        );
      case >= TweetPostScreen.postMaxLengthBeforeWarning:
        return Text(
          '$counter',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurface,
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
