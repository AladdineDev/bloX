import 'package:blox/core/common/widgets/button.dart';
import 'package:blox/core/common/widgets/divider.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/features/auth/widgets/x_header.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:'

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Button(
                    "Continue with Google",
                    leading: Image.asset(
                      './assets/images/google.png',
                      height: 20,
                    ),
                  ),
                  const TextDivider("or"),
                  const Button("Create account"),
                  const SizedBox(height: 24),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.grey),
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
                                      uri:
                                          Uri.parse('https://x.com/fr/privacy'))
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
                  const SizedBox(height: 24),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.grey),
                      children: <TextSpan>[
                        const TextSpan(text: "Have an account already? "),
                        TextSpan(
                          text: "Log in",
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.push('/login');
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
    );
  }
}
