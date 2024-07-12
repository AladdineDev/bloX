import 'package:blox/core/router/router.dart';
import 'package:blox/features/auth/widgets/x_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum LoginStep {
  login,
  password,
}

class LoginScreen extends StatefulWidget {
  final LoginStep step;

  const LoginScreen({super.key, required this.step});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isMainBtnEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            XHeader(),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            children: [
              Text(
                widget.step == LoginStep.login
                    ? "To get started, first enter your phone, email or @username"
                    : "Enter your password",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _loginController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.blue,
                  ),
                  labelText: 'Phone, email or username',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                onChanged: _onLoginChanged,
              ),
              const SizedBox(height: 24,),
              Visibility(
                visible: widget.step == LoginStep.password,
                child: TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.blue,
                    ),
                    labelText: 'Password',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  onChanged: _onPasswordChanged,
                ),
              ),
              const Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // forgot password route
                    },
                    child: const Text('Forgot password?',
                        style: TextStyle(color: Colors.white)),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          isMainBtnEnabled ? Colors.white : Colors.grey),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: _onMainBtnPressed,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLoginChanged(String text) {
    if (text.isEmpty) {
      if (isMainBtnEnabled) {
        setState(() {
          isMainBtnEnabled = false;
        });
      }
      return;
    }
    if (_passwordController.text.isEmpty) return;

    setState(() {
      isMainBtnEnabled = true;
    });
  }

  void _onPasswordChanged(String text) {
    if (text.isEmpty) {
      if (isMainBtnEnabled) {
        setState(() {
          isMainBtnEnabled = false;
        });
      }
      return;
    }
    if (_loginController.text.isEmpty) return;

    setState(() {
      isMainBtnEnabled = true;
    });
  }

  void _onMainBtnPressed() {
    if (!isMainBtnEnabled) return;
    const LoginScreenRoute(step: LoginStep.password).pushReplacement(context);
  }
}
