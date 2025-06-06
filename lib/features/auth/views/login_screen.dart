import 'package:blox/core/router/router.dart';
import 'package:blox/features/auth/widgets/x_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum LoginStep {
  login,
  password,
}

class LoginScreen extends StatefulWidget {
  final LoginStep step;
  final String? login;

  const LoginScreen({super.key, required this.step, this.login});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isMainBtnEnabled = false;

  @override
  void initState() {
    super.initState();
    print('login: ${widget.login}');
    if (widget.login != null) {
      _loginController.value =
          _loginController.value.copyWith(text: widget.login!);
    }
  }

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
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
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
              const SizedBox(
                height: 24,
              ),
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
                      // TODO: forgot password route
                    },
                    child: Text('Forgot password?',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          isMainBtnEnabled ? Colors.white : Colors.grey),
                    ),
                    onPressed: _onMainBtnPressed,
                    child: Text(
                      widget.step == LoginStep.login ? 'Next' : 'Log in',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              isMainBtnEnabled ? Colors.black : Colors.black54,
                          fontWeight: FontWeight.w700),
                    ),
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
    if (widget.step == LoginStep.password && _passwordController.text.isEmpty) {
      return;
    }

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

  void _onMainBtnPressed() async {
    if (!isMainBtnEnabled) return;
    if (widget.step == LoginStep.login) {
      LoginScreenRoute(step: LoginStep.password, login: _loginController.text)
          .pushReplacement(context);
      return;
    }

    try {
      final credentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginController.text,
        password: _passwordController.text,
      );

      Fluttertoast.showToast(
        msg: "Login successful!",
        backgroundColor: Colors.blueGrey,
        textColor: Colors.white,
      );

      print('credentials: $credentials');
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.code == 'wrong-password' ? 'Wrong password!' : 'Login failed!',
        backgroundColor: Colors.blueGrey,
        textColor: Colors.white,
      );
    }
  }
}
