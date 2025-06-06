import 'package:blox/core/common/widgets/profile_picture.dart';
import 'package:blox/features/profil/bloc/app_user_detail_bloc/app_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({super.key, this.bottom});

  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      centerTitle: true,
      leading: BlocBuilder<AppUserBloc, AppUserState>(
        builder: (context, state) {
          final user = state.appUser;
          final photoURL = user?.photoURL ??
              "https://abs.twimg.com/sticky/default_profile_images/default_profile.png";
          return ProfilePicture.small(
            image: NetworkImage(photoURL),
            onPressed: Scaffold.of(context).openDrawer,
          );
        },
      ),
      title: Image.asset(
        "assets/images/x.png",
        width: 28,
      ),
      bottom: bottom,
    );
  }
}
