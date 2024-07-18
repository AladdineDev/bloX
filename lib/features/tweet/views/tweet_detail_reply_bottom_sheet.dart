import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/features/tweet/widgets/tweet_post_bottom_row.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TweetDetailReplyBottomSheet extends StatefulWidget {
  const TweetDetailReplyBottomSheet({super.key});

  @override
  State<TweetDetailReplyBottomSheet> createState() =>
      _TweetDetailReplyBottomSheetState();
}

class _TweetDetailReplyBottomSheetState
    extends State<TweetDetailReplyBottomSheet> {
  final replyTextController = TextEditingController();
  final focusNode = FocusNode();
  bool enableReplyButton = false;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    replyTextController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (focusNode.hasFocus)
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Replying to ",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    TextSpan(
                      text: '@Bejita',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ]),
                ),
              TextFormField(
                focusNode: focusNode,
                controller: replyTextController,
                onChanged: (value) {
                  setState(() {
                    enableReplyButton = value.trim().isNotEmpty;
                  });
                },
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Post your Reply",
                  constraints: const BoxConstraints.tightFor(height: 44),
                  suffixIcon: IconButton(
                    onPressed: () {
                      TweetPostScreenRoute().push(context);
                    },
                    icon: Icon(
                      Icons.open_in_full_outlined,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  suffixIconConstraints: const BoxConstraints.tightFor(
                    height: 32,
                  ),
                ),
                maxLines: null,
                style: context.textTheme.bodyMedium,
              ),
              if (focusNode.hasFocus)
                Row(
                  children: [
                    Expanded(
                        child: TweetPostBottomRow(
                            postController: replyTextController)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: FilledButton(
                        onPressed: enableReplyButton ? () {} : null,
                        child: const Text('Post'),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
