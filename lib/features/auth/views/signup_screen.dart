import 'dart:ui';

import 'package:blox/features/auth/widgets/x_header.dart';
import 'package:blox/widgets/Button.dart';
import 'package:blox/widgets/Divider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
                style: Theme.of(context).textTheme.displayMedium,
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
                  TextDivider("or"),
                  Button("Create account"),
                  const SizedBox(height: 24),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'By signing up, you agree to our '),
                        TextSpan(
                          text: 'Terms',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle Terms tap here
                            },
                        ),
                        const TextSpan(text: ', '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle Privacy Policy tap here
                            },
                        ),
                        const TextSpan(text: ', and '),
                        TextSpan(
                          text: 'Cookie Use',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle Cookie Use tap here
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Text(
                  //   "Have an account already? Log in",
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .bodyLarge
                  //       ?.copyWith(color: Colors.grey),
                  // )
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
                              // Handle Log in tap here
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

  void _onTermsTap() {

  }

  void _onPrivacyPolicyTap() {

  }

  void _onCookieUseTap() {

  }

  void _onLoginTap() {

  }

}
