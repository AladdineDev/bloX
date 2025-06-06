import 'package:blox/core/common/widgets/spinner.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/features/profil/bloc/app_user_detail_bloc/app_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerProfileNameAndUsername extends StatelessWidget {
  const DrawerProfileNameAndUsername({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserBloc, AppUserState>(
      builder: (context, state) {
        final user = state.appUser;
        final displayName = user?.displayName;
        final username = user?.username;
        return switch (state.status) {
          AppUserStatus.progressFetchingAppUser => const Spinner.small(),
          AppUserStatus.failureFetchingAppUser => const SizedBox(),
          _ => InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (displayName != null)
                    Text(
                      displayName,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (username != null)
                    Text(
                      "@$username",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                ],
              ),
            ),
        };
      },
    );
  }
}
