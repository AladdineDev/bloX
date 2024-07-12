import 'package:blox/core/common/widgets/my_app_bar.dart';
import 'package:blox/core/common/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class TweetListScreen extends StatelessWidget {
  const TweetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: Center(
          child: Text("TweetListScreen"),
        ),
      ),
    );
  }
}
