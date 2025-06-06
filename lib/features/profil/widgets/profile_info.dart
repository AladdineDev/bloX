import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blox/features/profil/bloc/app_user_detail_bloc/app_user_bloc.dart';
import 'package:blox/core/common/widgets/spinner.dart';
import '../../auth/models/app_user.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserBloc, AppUserState>(
      builder: (context, state) {
        if (state.status == AppUserStatus.progressFetchingAppUser) {
          return const Spinner.small();
        } else if (state.status == AppUserStatus.failureFetchingAppUser) {
          return const SizedBox();
        } else if (state.status == AppUserStatus.successFetchingAppUser) {
          final user = state.appUser;
          if (user == null) {
            return const SizedBox();
          }
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName ?? 'No Name',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "@${user.username ?? 'No Username'}",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Text(user.bio ?? ''),
                const SizedBox(height: 10),
                _buildFollowInfo(user),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildFollowInfo(AppUser user) {
    return Row(
      children: [
        Text('${user.following} Following', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 10),
        Text('${user.followers} Followers', style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}