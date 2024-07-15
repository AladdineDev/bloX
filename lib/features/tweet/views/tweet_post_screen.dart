import 'package:blox/core/common/widgets/profile_picture.dart';
import 'package:blox/core/common/widgets/spinner.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/features/tweet/widgets/tweet_post_image.dart';
import 'package:blox/features/tweet/widgets/tweet_post_length_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class TweetPostScreen extends StatefulWidget {
  const TweetPostScreen({super.key});

  static const postMaxLength = 280;
  static const postMaxLengthBeforeWarning = 260;

  @override
  State<TweetPostScreen> createState() => _TweetPostScreenState();
}

class _TweetPostScreenState extends State<TweetPostScreen> {
  final _postController = TextEditingController();
  bool enablePostButton = false;
  final ImagePicker picker = ImagePicker();
  List<XFile> mediaList = [];

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.close),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FilledButton(
              onPressed: enablePostButton ? () {} : null,
              child: const Text('Post'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfilePicture.medium(
                            onPressed: () {},
                            image: const NetworkImage(
                              "https://abs.twimg.com/sticky/default_profile_images/default_profile.png",
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              children: [
                                const SizedBox(height: 2),
                                StatefulBuilder(builder: (context, setState) {
                                  return TextFormField(
                                    controller: _postController,
                                    onChanged: (value) {
                                      setState(() {
                                        enablePostButton =
                                            value.trim().isNotEmpty;
                                      });
                                    },
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration.collapsed(
                                      hintText: "What's happening?",
                                    ),
                                    maxLines: null,
                                    style: context.textTheme.titleMedium,
                                  );
                                }),
                                const SizedBox(height: 16),
                                GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: mediaList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 4,
                                  ),
                                  itemBuilder: (context, index) {
                                    final media = mediaList[index];
                                    return FutureBuilder(
                                      future: media.readAsBytes(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Spinner.medium();
                                        }
                                        final mediaBytes = snapshot.data;
                                        if (mediaBytes == null) {
                                          return const SizedBox.shrink();
                                        }
                                        return TweetPostImage(
                                          mediaBytes: mediaBytes,
                                          onTap: () {
                                            TweetPostImageViewerScreenRoute(
                                              imageBytes: mediaBytes,
                                            ).push(context);
                                          },
                                          onDelete: () {
                                            setState(() {
                                              mediaList.remove(media);
                                            });
                                          },
                                        );
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      // const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  color: context.colorScheme.primary,
                  onPressed: () async {
                    final pickedMedia =
                        await picker.pickMultipleMedia(limit: 4);
                    mediaList.addAll(pickedMedia);
                    setState(() {});
                  },
                  icon: const Icon(Icons.image_outlined),
                ),
                TweetPostLengthIndicator(postController: _postController),
              ],
            )
          ],
        ),
      ),
    );
  }
}
