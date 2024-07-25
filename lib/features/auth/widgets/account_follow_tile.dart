import 'package:blox/features/auth/models/app_user.dart';
import 'package:flutter/material.dart';

class AccountFollowTile extends StatelessWidget {
  final AppUser user; // Assume TwitterAccount is a class that holds account details

  const AccountFollowTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: _buildProfilePicture().image,
      ),
      title: Text(user.displayName ?? 'Unknown name'),
      subtitle: Text('@${user.username}'),
      trailing: ElevatedButton(
        onPressed: () {
          // TODO: Trigger follow action
        },
        child: const Text('Follow'),
      ),
    );
  }

  Image _buildProfilePicture() {
    if (user.photoURL != null || user.profileImageUrl != null) {
      return Image.network((user.photoURL ?? user.profileImageUrl)!);
    }
    return Image.asset('assets/images/pp-fallback.png');
  }

}
