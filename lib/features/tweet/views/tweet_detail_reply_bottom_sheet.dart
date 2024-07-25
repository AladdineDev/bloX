import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/features/tweet/models/post.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TweetDetailReplyBottomSheet extends StatefulWidget {
  const TweetDetailReplyBottomSheet({super.key, required this.postId});

  final PostId postId;

  @override
  State<TweetDetailReplyBottomSheet> createState() =>
      _TweetDetailReplyBottomSheetState();
}

class _TweetDetailReplyBottomSheetState
    extends State<TweetDetailReplyBottomSheet> {
  final ImagePicker picker = ImagePicker();

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
              // RichText(
              //   text: TextSpan(children: [
              //     TextSpan(
              //       text: "Replying to ",
              //       style: context.textTheme.bodyMedium?.copyWith(
              //         color: context.colorScheme.onSurface,
              //       ),
              //     ),
              //     TextSpan(
              //       text: '@Bejita',
              //       style: context.textTheme.bodyMedium?.copyWith(
              //         color: context.colorScheme.primary,
              //       ),
              //     ),
              //   ]),
              // ),
              TextFormField(
                onTap: () => TweetPostScreenRoute(parentPostId: widget.postId)
                    .push(context),
                readOnly: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Post your reply",
                  constraints: const BoxConstraints.tightFor(height: 44),
                  suffixIcon: IconButton(
                    onPressed: () {
                      TweetPostScreenRoute(parentPostId: widget.postId)
                          .push(context);
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
              // if (focusNode.hasFocus)
              //   Row(
              //     children: [
              //       Expanded(
              //           child: TweetPostBottomRow(
              //               postController: replyTextController)),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 8),
              //         child: FilledButton(
              //           onPressed: enableReplyButton ? () {} : null,
              //           child: const Text('Post'),
              //         ),
              //       ),
              //     ],
              //   ),
            ],
          ),
        );
      },
    );
  }
}
