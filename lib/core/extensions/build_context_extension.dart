import 'package:blox/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:blox/features/auth/repositories/auth_repository.dart';
import 'package:blox/features/profil/bloc/user_detail_bloc/app_user_bloc.dart';
import 'package:blox/features/profil/repositories/app_user_repository.dart';
import 'package:blox/features/tweet/bloc/post_bloc/post_bloc.dart';
import 'package:blox/features/tweet/bloc/post_detail_bloc/post_detail_bloc.dart';
import 'package:blox/features/tweet/bloc/tweet_media_bloc/tweet_media_bloc.dart';
import 'package:blox/features/tweet/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ThemeDataExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension ColorSchemeExtension on BuildContext {
  ColorScheme get colorScheme => theme.colorScheme;
}

extension TextExtension on BuildContext {
  TextTheme get textTheme => theme.textTheme;
}

extension BlocExtension on BuildContext {
  TweetMediaBloc get tweetMediaBloc => read<TweetMediaBloc>();
  PostBloc get postBloc => read<PostBloc>();
  AuthBloc get authBloc => read<AuthBloc>();
  AppUserBloc get appUserBloc => read<AppUserBloc>();
  PostDetailBloc get postDetailBloc => read<PostDetailBloc>();
  AuthRepository get authRepository => read<AuthRepository>();
  PostRepository get postRepository => read<PostRepository>();
  AppUserRepository get appUserRepository => read<AppUserRepository>();
}

extension DarkMode on BuildContext {
  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}
