import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/features/auth/views/login_screen.dart';
import 'package:blox/features/auth/views/onboarding_screen.dart';
import 'package:blox/features/auth/views/signup_screen.dart';
import 'package:blox/features/tweet/models/post.dart';
import 'package:blox/features/tweet/views/tweet_detail_screen.dart';
import 'package:blox/features/tweet/views/tweet_post_image_viewer.dart';
import 'package:blox/features/tweet/views/tweet_post_screen.dart';
import 'package:blox/features/tweet/views/tweet_list_screen.dart';
import 'package:blox/features/tweet/views/tweet_post_video_viewer.dart';
import 'package:blox/features/webview/views/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:blox/features/profil/views/profil_screen.dart';
import 'package:blox/features/edite_profile/views/edite_profile_screen.dart';

part 'router.g.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  AppRouter._internal();

  final router = GoRouter(
    routes: $appRoutes,
    initialLocation: '/onboarding',
    redirect: (context, state) async {
      final appUserStream = context.authRepository.getAppUser();
      final appUser = await appUserStream.first;
      print("Wesh: $appUser");
      if (appUser == null) {
        return '/onboarding';
      }
      return null;
    },
  );
}

@TypedGoRoute<OnboardingScreenRoute>(path: '/onboarding')
@immutable
class OnboardingScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OnBoardingScreen();
  }
}

@TypedGoRoute<SignupScreenRoute>(path: '/sign-up')
@immutable
class SignupScreenRoute extends GoRouteData {
  final SignupStep step;

  const SignupScreenRoute({required this.step});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SignupScreen(
      step: step,
    );
  }
}

@TypedGoRoute<TweetListScreenRoute>(path: '/tweets')
@immutable
class TweetListScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TweetListScreen();
  }
}

@TypedGoRoute<TweetDetailScreenRoute>(path: '/tweet-detail/:postId')
@immutable
class TweetDetailScreenRoute extends GoRouteData {
  const TweetDetailScreenRoute({required this.postId});

  final PostId postId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TweetDetailScreen(postId: postId);
  }
}

@TypedGoRoute<ProfileScreenRoute>(path: '/profile')
@immutable
class ProfileScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileScreen();
  }
}

@TypedGoRoute<EditeProfileScreenRoute>(path: '/edite-profile')
@immutable
class EditeProfileScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EditeProfileScreen();
  }
}

@TypedGoRoute<LoginScreenRoute>(path: '/login')
@immutable
class LoginScreenRoute extends GoRouteData {
  final LoginStep step;
  final String? login;

  const LoginScreenRoute({required this.step, this.login});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LoginScreen(step: step, login: login);
  }
}

@TypedGoRoute<WebviewScreenRoute>(path: '/webview:uri')
@immutable
class WebviewScreenRoute extends GoRouteData {
  final Uri uri;

  const WebviewScreenRoute({required this.uri});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return WebViewScreen(uri: uri);
  }
}

@TypedGoRoute<TweetPostScreenRoute>(path: '/new-tweet')
@immutable
class TweetPostScreenRoute extends GoRouteData {
  @override
  CustomTransitionPage buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        var curve = Curves.easeOut;
        var curveTween = CurveTween(curve: curve);
        final tween = Tween(begin: begin, end: end).chain(curveTween);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      child: const TweetPostScreen(),
    );
  }
}

@TypedGoRoute<TweetPostImageViewerScreenRoute>(path: '/tweet-post-image-viewer')
@immutable
class TweetPostImageViewerScreenRoute extends GoRouteData {
  const TweetPostImageViewerScreenRoute({required this.mediaPath});

  final String mediaPath;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TweetPostImageViewerScreen(mediaPath: mediaPath);
  }
}

@TypedGoRoute<TweetPostVideoViewerScreenRoute>(path: '/tweet-post-video-viewer')
@immutable
class TweetPostVideoViewerScreenRoute extends GoRouteData {
  const TweetPostVideoViewerScreenRoute({required this.mediaPath});

  final String mediaPath;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TweetPostVideoViewerScreen(mediaPath: mediaPath);
  }
}
