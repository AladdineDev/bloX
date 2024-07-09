import 'package:blox/core/common/widgets/profile_picture.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: ProfilePicture(
          image: const NetworkImage(
            "https://abs.twimg.com/sticky/default_profile_images/default_profile.png",
          ),
          onPressed: Scaffold.of(context).openDrawer,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      title: const Text("X"),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
    );
  }
}
