import 'package:blox/core/common/widgets/profile_picture.dart';
import 'package:blox/core/extensions/x_file_extension.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/features/tweet/bloc/tweet_media_bloc/tweet_media_bloc.dart';
import 'package:blox/features/tweet/widgets/tweet_post_bottom_row.dart';
import 'package:blox/features/tweet/widgets/tweet_post_image.dart';
import 'package:blox/features/tweet/widgets/tweet_post_text_field.dart';
import 'package:blox/features/tweet/widgets/tweet_post_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TweetMediaBloc(),
      child: Scaffold(
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
                                  TweetPostTextField(
                                    controller: _postController,
                                    onChanged: (value) {
                                      setState(() {
                                        enablePostButton =
                                            value.trim().isNotEmpty;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  BlocBuilder<TweetMediaBloc, TweetMediaState>(
                                    builder: (context, state) {
                                      final mediaList = state.mediaList;
                                      return GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
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
              TweetPostBottomRow(
                postController: _postController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
