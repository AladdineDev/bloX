import 'package:flutter/material.dart';

class TweetListTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TweetListTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);

  @override
  Widget build(BuildContext context) {
    return TabBar(tabs: tabs);
  }
}
