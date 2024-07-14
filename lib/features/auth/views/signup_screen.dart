import 'package:blox/core/common/widgets/input.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/features/auth/widgets/x_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

enum SignupStep { form, otp, profilePicture, username, notifications }

class SignupScreen extends StatefulWidget {
  final SignupStep step;

  const SignupScreen({super.key, required this.step});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  DateTime? _selectedDate;
  XFile? _profileImage;
  bool isMainBtnEnabled = false;
  bool isDatePickerVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create your account',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 70),
              Input(
                controller: _nameController,
                labelText: "Name",
                maxLength: 50,
                keyboardType: TextInputType.name,
              ),
              Input(
                controller: _nameController,
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              Input(
                controller: _dateOfBirthController,
                labelText: "Date of birth",
                keyboardType: TextInputType.datetime,
                onTap: () {
                  if (!isDatePickerVisible) {
                    setState(() {
                      isDatePickerVisible = true;
                    });
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 54),
                child: Text(
                  "This will not be shown publicly. Confirm your own age, even if this account is for a business, a pet, or something else.",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ),
              const Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: _isStepSkippable(),
                    child: OutlinedButton(
                      onPressed: _skip,
                      child: Text(
                        widget.step == SignupStep.notifications
                            ? 'Done'
                            : 'Next',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isMainBtnEnabled
                                ? Colors.black
                                : Colors.black54,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          isMainBtnEnabled ? Colors.white : Colors.grey),
                    ),
                    onPressed: _onMainBtnPressed,
                    child: Text(
                      widget.step == SignupStep.notifications ? 'Done' : 'Next',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              isMainBtnEnabled ? Colors.black : Colors.black54,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  // TODO: display date picker
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _skip() {
    SignupScreenRoute(step: _getNextStep()).push(context);
  }

  SignupStep _getNextStep() {
    return SignupStep.values[widget.step.index + 1];
  }

  bool _isStepSkippable() {
    switch (widget.step) {
      case SignupStep.form:
        return false;
      case SignupStep.otp:
        return false;
      case SignupStep.profilePicture:
        return true;
      case SignupStep.username:
        return true;
      case SignupStep.notifications:
        return false;
    }
  }

  void _onMainBtnPressed() {}
}
