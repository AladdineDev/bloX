import 'package:blox/core/common/widgets/drawer_divider.dart';
import 'package:blox/core/common/widgets/drawer_number_of_follow.dart';
import 'package:blox/core/common/widgets/drawer_profile_name_and_username.dart';
import 'package:blox/core/common/widgets/profile_picture.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:blox/features/auth/models/app_user.dart';
import 'package:blox/features/profil/bloc/app_user_detail_bloc/app_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.theme.listTileTheme.contentPadding ??
        const EdgeInsets.symmetric(horizontal: 20.0);
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: padding,
                child: BlocBuilder<AppUserBloc, AppUserState>(
                  builder: (context, state) {
                    final user = state.appUser;
                    final followersNumber = user?.followers?.length ?? 0;
                    final followingNumber = user?.following?.length ?? 0;
                    final photoURL = user?.photoURL ??
                        "https://abs.twimg.com/sticky/default_profile_images/default_profile.png";
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProfilePicture.medium(
                          image: NetworkImage(photoURL),
                          onPressed: () => ProfileScreenRoute().push(context),
                        ),
                        const SizedBox(height: 12),
                        DrawerProfileNameAndUsername(
                          onTap: () {
                            //TODO: implement this function
                          },
                        ),
                        const SizedBox(height: 12),
                        OverflowBar(
                          spacing: 8,
                          children: [
                            DrawerNumberOfFollowText(
                              number: followersNumber,
                              text: "Following",
                              onTap: () {
                                //TODO: implement this function
                              },
                            ),
                            DrawerNumberOfFollowText(
                              number: followingNumber,
                              text: "Followers",
                              onTap: () {
                                //TODO: implement this function
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              DrawerDivider(padding: padding),
              ListTile(
                onTap: () => ProfileScreenRoute().push(context),
                leading: const Icon(Icons.person_outline),
                title: const Text("Profile"),
              ),
              ListTile(
                onTap: () {
                  //TODO: implement this function
                },
                leading: const Icon(Icons.bookmark_outline),
                title: const Text("Bookmarks"),
              ),
              DrawerDivider(padding: padding),
              IconTheme(
                data: context.theme.iconTheme.copyWith(size: 20),
                child: ListTileTheme(
                  data: context.theme.listTileTheme.copyWith(
                    minTileHeight: 44,
                    titleTextStyle: TextStyle(
                      fontSize: context.textTheme.bodyMedium?.fontSize,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      "Settings & Support",
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      ListTile(
                        onTap: () {
                          //TODO: implement this function
                        },
                        leading: const Icon(Icons.settings_outlined),
                        title: const Text("Settings and privacy"),
                      ),
                      ListTile(
                        onTap: () {
                          //TODO: implement this function
                        },
                        leading: const Icon(Icons.help_outline),
                        title: const Text("Help Center"),
                      ),
                      ListTile(
                        onTap: () {
                          context.authBloc.add(const AuthSignOut());
                        },
                        leading: Icon(
                          Icons.exit_to_app_outlined,
                          color: context.colorScheme.error,
                        ),
                        title: Text(
                          "Log out",
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
