import 'package:blox/core/common/widgets/spinner.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/features/tweet/views/tweet_post_screen.dart';
import 'package:flutter/material.dart';

class TweetPostLengthIndicator extends StatelessWidget {
  const TweetPostLengthIndicator({
    super.key,
    required this.textEditingController,
    required this.maxLength,
    required this.maxLengthBeforeWarning,
  });

  final TextEditingController textEditingController;
  final int maxLength;
  final int maxLengthBeforeWarning;

  @override
  Widget build(BuildContext context) {
    final counter = maxLength - textEditingController.text.length;
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
    switch (textEditingController.text.length) {
      case >= TweetPostScreen.postMaxLength:
        return Spinner.small(
          dimension: 28,
          strokeWidth: 3,
          value: textEditingController.text.length / maxLength,
          color: context.colorScheme.error,
          backgroundColor: context.colorScheme.onSurface,
        );
      case >= TweetPostScreen.postMaxLengthBeforeWarning:
        return Spinner.small(
          dimension: 28,
          strokeWidth: 3,
          value: textEditingController.text.length / maxLength,
          color: context.colorScheme.errorContainer,
          backgroundColor: context.colorScheme.onSurface,
        );
      default:
        return Spinner.small(
          dimension: 24,
          value: textEditingController.text.length / maxLength,
          color: context.colorScheme.primary,
          backgroundColor: context.colorScheme.onSurface,
        );
    }
  }

  Widget _getText(
    BuildContext context, {
    required int counter,
  }) {
    switch (textEditingController.text.length) {
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
