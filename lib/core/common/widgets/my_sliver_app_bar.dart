import 'package:blox/core/common/widgets/profile_picture.dart';
import 'package:flutter/material.dart';

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({super.key, this.bottom});

  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      centerTitle: true,
      leading: ProfilePicture(
        image: const NetworkImage(
          "https://abs.twimg.com/sticky/default_profile_images/default_profile.png",
        ),
        onPressed: Scaffold.of(context).openDrawer,
      ),
      title: Image.asset(
        "assets/images/x.png",
        width: 28,
      ),
      bottom: bottom,
    );
  }
}
