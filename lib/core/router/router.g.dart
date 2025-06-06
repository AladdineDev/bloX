// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $onboardingScreenRoute,
      $signupScreenRoute,
      $tweetListScreenRoute,
      $tweetDetailScreenRoute,
      $profileScreenRoute,
      $editeProfileScreenRoute,
      $loginScreenRoute,
      $webviewScreenRoute,
      $tweetPostScreenRoute,
      $tweetPostImageViewerScreenRoute,
      $tweetPostVideoViewerScreenRoute,
    ];

RouteBase get $onboardingScreenRoute => GoRouteData.$route(
      path: '/onboarding',
      factory: $OnboardingScreenRouteExtension._fromState,
    );

extension $OnboardingScreenRouteExtension on OnboardingScreenRoute {
  static OnboardingScreenRoute _fromState(GoRouterState state) =>
      OnboardingScreenRoute();

  String get location => GoRouteData.$location(
        '/onboarding',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signupScreenRoute => GoRouteData.$route(
      path: '/sign-up',
      factory: $SignupScreenRouteExtension._fromState,
    );

extension $SignupScreenRouteExtension on SignupScreenRoute {
  static SignupScreenRoute _fromState(GoRouterState state) => SignupScreenRoute(
        step:
            _$SignupStepEnumMap._$fromName(state.uri.queryParameters['step']!),
      );

  String get location => GoRouteData.$location(
        '/sign-up',
        queryParams: {
          'step': _$SignupStepEnumMap[step],
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

const _$SignupStepEnumMap = {
  SignupStep.form: 'form',
  SignupStep.otp: 'otp',
  SignupStep.profilePicture: 'profile-picture',
  SignupStep.username: 'username',
  SignupStep.notifications: 'notifications',
  SignupStep.followAccounts: 'follow-accounts',
};

extension<T extends Enum> on Map<T, String> {
  T _$fromName(String value) =>
      entries.singleWhere((element) => element.value == value).key;
}

RouteBase get $tweetListScreenRoute => GoRouteData.$route(
      path: '/tweets',
      factory: $TweetListScreenRouteExtension._fromState,
    );

extension $TweetListScreenRouteExtension on TweetListScreenRoute {
  static TweetListScreenRoute _fromState(GoRouterState state) =>
      TweetListScreenRoute();

  String get location => GoRouteData.$location(
        '/tweets',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $tweetDetailScreenRoute => GoRouteData.$route(
      path: '/tweet-detail/:postId',
      factory: $TweetDetailScreenRouteExtension._fromState,
    );

extension $TweetDetailScreenRouteExtension on TweetDetailScreenRoute {
  static TweetDetailScreenRoute _fromState(GoRouterState state) =>
      TweetDetailScreenRoute(
        postId: state.pathParameters['postId']!,
      );

  String get location => GoRouteData.$location(
        '/tweet-detail/${Uri.encodeComponent(postId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $profileScreenRoute => GoRouteData.$route(
      path: '/profile',
      factory: $ProfileScreenRouteExtension._fromState,
    );

extension $ProfileScreenRouteExtension on ProfileScreenRoute {
  static ProfileScreenRoute _fromState(GoRouterState state) =>
      ProfileScreenRoute();

  String get location => GoRouteData.$location(
        '/profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $editeProfileScreenRoute => GoRouteData.$route(
      path: '/edite',
      factory: $EditeProfileScreenRouteExtension._fromState,
    );

extension $EditeProfileScreenRouteExtension on EditeProfileScreenRoute {
  static EditeProfileScreenRoute _fromState(GoRouterState state) =>
      EditeProfileScreenRoute();

  String get location => GoRouteData.$location(
        '/edite',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginScreenRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginScreenRouteExtension._fromState,
    );

extension $LoginScreenRouteExtension on LoginScreenRoute {
  static LoginScreenRoute _fromState(GoRouterState state) => LoginScreenRoute(
        step: _$LoginStepEnumMap._$fromName(state.uri.queryParameters['step']!),
        login: state.uri.queryParameters['login'],
      );

  String get location => GoRouteData.$location(
        '/login',
        queryParams: {
          'step': _$LoginStepEnumMap[step],
          if (login != null) 'login': login,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

const _$LoginStepEnumMap = {
  LoginStep.login: 'login',
  LoginStep.password: 'password',
};

RouteBase get $webviewScreenRoute => GoRouteData.$route(
      path: '/webview:uri',
      factory: $WebviewScreenRouteExtension._fromState,
    );

extension $WebviewScreenRouteExtension on WebviewScreenRoute {
  static WebviewScreenRoute _fromState(GoRouterState state) =>
      WebviewScreenRoute(
        uri: Uri.parse(state.pathParameters['uri']!),
      );

  String get location => GoRouteData.$location(
        '/webview${Uri.encodeComponent(uri.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $tweetPostScreenRoute => GoRouteData.$route(
      path: '/new-tweet',
      factory: $TweetPostScreenRouteExtension._fromState,
    );

extension $TweetPostScreenRouteExtension on TweetPostScreenRoute {
  static TweetPostScreenRoute _fromState(GoRouterState state) =>
      TweetPostScreenRoute(
        parentPostId: state.uri.queryParameters['parent-post-id'],
      );

  String get location => GoRouteData.$location(
        '/new-tweet',
        queryParams: {
          if (parentPostId != null) 'parent-post-id': parentPostId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $tweetPostImageViewerScreenRoute => GoRouteData.$route(
      path: '/tweet-post-image-viewer',
      factory: $TweetPostImageViewerScreenRouteExtension._fromState,
    );

extension $TweetPostImageViewerScreenRouteExtension
    on TweetPostImageViewerScreenRoute {
  static TweetPostImageViewerScreenRoute _fromState(GoRouterState state) =>
      TweetPostImageViewerScreenRoute(
        mediaPath: state.uri.queryParameters['media-path']!,
      );

  String get location => GoRouteData.$location(
        '/tweet-post-image-viewer',
        queryParams: {
          'media-path': mediaPath,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $tweetPostVideoViewerScreenRoute => GoRouteData.$route(
      path: '/tweet-post-video-viewer',
      factory: $TweetPostVideoViewerScreenRouteExtension._fromState,
    );

extension $TweetPostVideoViewerScreenRouteExtension
    on TweetPostVideoViewerScreenRoute {
  static TweetPostVideoViewerScreenRoute _fromState(GoRouterState state) =>
      TweetPostVideoViewerScreenRoute(
        mediaPath: state.uri.queryParameters['media-path']!,
      );

  String get location => GoRouteData.$location(
        '/tweet-post-video-viewer',
        queryParams: {
          'media-path': mediaPath,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
