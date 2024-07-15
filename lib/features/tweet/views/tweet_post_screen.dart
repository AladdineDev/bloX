import 'package:blox/core/common/widgets/profile_picture.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/core/extensions/x_file_extension.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/features/tweet/widgets/tweet_post_image.dart';
import 'package:blox/features/tweet/widgets/tweet_post_length_indicator.dart';
import 'package:blox/features/tweet/widgets/tweet_post_video.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class TweetPostScreen extends StatefulWidget {
  const TweetPostScreen({super.key});

  static const postMaxLength = 280;
  static const postMaxLengthBeforeWarning = 260;
  static const maxMediaPicked = 4;

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
    final mediaLimit = TweetPostScreen.maxMediaPicked - mediaList.length;
    final hasExceededMaxMedia =
        mediaList.length > TweetPostScreen.maxMediaPicked;
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
                                    autofocus: true,
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
                                    if (media.isImage) {
                                      return TweetPostImage(
                                        mediaPath: media.path,
                                        onTap: () {
                                          TweetPostImageViewerScreenRoute(
                                            mediaPath: media.path,
                                          ).push(context);
                                        },
                                        onDelete: () {
                                          setState(() {
                                            mediaList.remove(media);
                                          });
                                        },
                                      );
                                    } else if (media.isVideo) {
                                      return TweetPostVideo(
                                        mediaPath: media.path,
                                        onTap: () {
                                          TweetPostVideoViewerScreenRoute(
                                            mediaPath: media.path,
                                          ).push(context);
                                        },
                                        onDelete: () {
                                          setState(() {
                                            mediaList.remove(media);
                                          });
                                        },
                                      );
                                    }
                                    return const SizedBox.shrink();
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
                Row(
                  children: [
                    IconButton(
                      tooltip: "Pick media",
                      icon: const Icon(Icons.image_outlined),
                      color: context.colorScheme.primary,
                      onPressed: () async {
                        if (hasExceededMaxMedia) return _showMaxMediaSnackBar();
                        final List<XFile> pickedMedia;
                        if (mediaLimit < 2) {
                          pickedMedia =
                              [await picker.pickMedia()].nonNulls.toList();
                        } else {
                          pickedMedia = await picker.pickMultipleMedia(
                            limit: mediaLimit,
                          );
                        }
                        if (mediaList.length + pickedMedia.length >
                            TweetPostScreen.maxMediaPicked) {
                          return _showMaxMediaSnackBar();
                        }
                        setState(() {
                          mediaList.addAll(pickedMedia);
                        });
                      },
                    ),
                    IconButton(
                      tooltip: "Take picture",
                      icon: const Icon(Icons.camera_alt_outlined),
                      color: context.colorScheme.primary,
                      onPressed: () async {
                        if (hasExceededMaxMedia) return _showMaxMediaSnackBar();
                        final pickedMedia =
                            await picker.pickImage(source: ImageSource.camera);
                        if (pickedMedia == null) return;
                        setState(() {
                          mediaList.add(pickedMedia);
                        });
                      },
                    ),
                    IconButton(
                      tooltip: "Take video",
                      icon: const Icon(Icons.video_camera_back_outlined),
                      color: context.colorScheme.primary,
                      onPressed: () async {
                        if (hasExceededMaxMedia) return _showMaxMediaSnackBar();
                        final pickedMedia =
                            await picker.pickVideo(source: ImageSource.camera);
                        if (pickedMedia == null) return;
                        setState(() {
                          mediaList.add(pickedMedia);
                        });
                      },
                    ),
                  ],
                ),
                TweetPostLengthIndicator(postController: _postController),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showMaxMediaSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("4 media limit reached"),
      ),
    );
  }
}
