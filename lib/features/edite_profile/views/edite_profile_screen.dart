import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blox/features/edite_profile/edit_user_bloc/edit_user_bloc.dart';
import 'package:blox/features/profil/repositories/app_user_repository.dart';
import 'package:blox/features/profil/data_sources/remote_app_user_data_source.dart';
import 'package:blox/features/auth/models/app_user.dart';

import '../widgets/header_section.dart';
import '../widgets/profile_field.dart';
import '../widgets/visibility_toggle.dart';

class EditeProfileScreen extends StatelessWidget {
  const EditeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final bioController = TextEditingController();
    final userNameController = TextEditingController();
    final websiteController = TextEditingController();

    final currentUser = context.read<EditUserBloc>().state.user;

    return BlocProvider(
      create: (context) => EditUserBloc(AppUserRepository(remoteDataSource: RemoteAppUserDataSource())),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit profile'),
          actions: [
            TextButton(
              onPressed: () {
                final user = AppUser(
                  id: currentUser?.id ?? 'default-id', // Use the actual user ID
                  email: currentUser?.email ?? 'default@example.com', // Use the actual email
                  displayName: nameController.text,
                  bio: bioController.text,
                  username: userNameController.text,
                  profileImageUrl: websiteController.text,
                );
                context.read<EditUserBloc>().add(SaveUser(user));
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderSection(),
              const SizedBox(height: 40),
              ProfileField(
                label: 'Name',
                controller: nameController,
                initialValue: currentUser?.displayName ?? 'Aladdin',
              ),
              ProfileField(
                label: 'Bio',
                controller: bioController,
                initialValue: currentUser?.bio ?? '',
              ),
              ProfileField(
                label: 'Username',
                controller: userNameController,
                initialValue: currentUser?.username ?? '',
              ),
              ProfileField(
                label: 'Website',
                controller: websiteController,
                initialValue: currentUser?.profileImageUrl ?? '',
              ),
              const ProfileField(
                label: 'Birth date',
                initialValue: 'July 8, 1997',
                readOnly: true,
              ),
              const VisibilityToggle(
                label: 'Month and day: Only you\nYear: Only you',
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}