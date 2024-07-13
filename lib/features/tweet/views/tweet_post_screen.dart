import 'package:blox/core/common/widgets/profile_picture.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TweetPostScreen extends StatefulWidget {
  const TweetPostScreen({super.key});

  @override
  State<TweetPostScreen> createState() => _TweetPostScreenState();
}

class _TweetPostScreenState extends State<TweetPostScreen> {
  final _postController = TextEditingController();
  static const _postMaxLength = 280;
  bool enablePostButton = false;

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
          FilledButton(
            onPressed: enablePostButton ? () {} : null,
            child: const Text('Post'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Expanded(
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
                                TextFormField(
                                  controller: _postController,
                                  onChanged: _onPostFieldChanged,
                                  keyboardType: TextInputType.multiline,
                                  decoration: const InputDecoration.collapsed(
                                    hintText: "What's happening?",
                                  ),
                                  maxLines: null,
                                  style: context.textTheme.titleMedium,
                                ),
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
            Row(
              children: [
                IconButton(
                  color: context.colorScheme.primary,
                  onPressed: () {},
                  icon: const Icon(Icons.image_outlined),
                ),
                Row(
                  children: [
                    CircularProgressIndicator(
                      value: _postController.text.length / _postMaxLength,
                      backgroundColor: context.colorScheme.onSurface,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onPostFieldChanged(String value) {
    if (value.isEmpty || value.trim() == '') {
      setState(() => enablePostButton = false);
    } else {
      setState(() => enablePostButton = true);
    }
  }
}
