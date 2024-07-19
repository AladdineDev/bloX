import 'package:blox/core/common/widgets/divider.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:blox/features/auth/views/login_screen.dart';
import 'package:blox/features/auth/views/signup_screen.dart';
import 'package:blox/features/auth/widgets/x_header.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current.appUser != null,
      listener: (context, state) => TweetListScreenRoute().go(context),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const XHeader(),
                Text(
                  "See what's happening in the world now.",
                  // display medium
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        context.authRepository.signInWithGoogle();
                      },
                      label: const Text("Continue with Google"),
                      icon: Image.asset(
                        './assets/images/google.png',
                        height: 20,
                      ),
                    ),
                    const TextDivider("or"),
                    ElevatedButton(
                      child: const Text("Create account"),
                      onPressed: () {
                        const SignupScreenRoute(step: SignupStep.form)
                            .push(context);
                      },
                    ),
                    const SizedBox(height: 24),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white54),
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'By signing up, you agree to our '),
                          TextSpan(
                            text: 'Terms',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                WebviewScreenRoute(
                                        uri: Uri.parse('https://x.com/fr/tos'))
                                    .push(context);
                              },
                          ),
                          const TextSpan(text: ', '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                WebviewScreenRoute(
                                        uri: Uri.parse(
                                            'https://x.com/fr/privacy'))
                                    .push(context);
                              },
                          ),
                          const TextSpan(text: ', and '),
                          TextSpan(
                            text: 'Cookie Use',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                WebviewScreenRoute(
                                  uri: Uri.parse(
                                      'https://help.x.com/fr/rules-and-policies/x-cookies'),
                                ).push(context);
                              },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 68),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white54),
                        children: <TextSpan>[
                          const TextSpan(text: "Have an account already? "),
                          TextSpan(
                            text: "Log in",
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                const LoginScreenRoute(step: LoginStep.login)
                                    .push(context);
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
