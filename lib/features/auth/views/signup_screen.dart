import 'dart:async';

import 'package:blox/core/common/widgets/input.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/features/auth/widgets/x_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
import 'package:intl/intl.dart';

enum SignupStep { form, otp, profilePicture, username, notifications }

class SignupScreen extends StatefulWidget {
  final SignupStep step;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final FocusNode _dateOfBirthFocusNode = FocusNode();

  SignupScreen({super.key, required this.step});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? _emailError;
  DateTime? _selectedDate;
  XFile? _profileImage;
  bool isMainBtnEnabled = false;
  bool isDatePickerVisible = false;

  @override
  void initState() {
    super.initState();

    if (widget.step == SignupStep.otp) {
      // send otp with firebase
      // FirebaseAuth.instance.currentUser.sendEmailVerification();
    }

    widget._dateOfBirthFocusNode.addListener(() {
      if (widget._dateOfBirthFocusNode.hasFocus && !isDatePickerVisible) {
        setState(() {
          isDatePickerVisible = true;
        });
      }
    });

    widget._nameController.addListener(checkFieldsAndSetButtonState);
    widget._emailController.addListener(checkFieldsAndSetButtonState);
    widget._dateOfBirthController.addListener(checkFieldsAndSetButtonState);
  }

  @override
  void dispose() {
    widget._nameController.removeListener(checkFieldsAndSetButtonState);
    widget._emailController.removeListener(checkFieldsAndSetButtonState);
    widget._dateOfBirthController.removeListener(checkFieldsAndSetButtonState);
    super.dispose();
  }

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
      body: Builder(builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height -
                  Scaffold
                      .of(context)
                      .appBarMaxHeight!,
              child: IntrinsicHeight(
                child: _buildCurrentStep(),
              ),
            ),
          ),
        );
      }),
    );
  }

  void _skip() {
    SignupScreenRoute(step: _getNextStep()).push(context);
  }

  SignupStep _getNextStep() {
    return SignupStep.values[widget.step.index + 1];
  }

  void checkFieldsAndSetButtonState() {
    final bool fieldsFilled = widget._nameController.text.isNotEmpty &&
        widget._emailController.text.isNotEmpty &&
        widget._dateOfBirthController.text.isNotEmpty;
    final bool isFormStep = widget.step == SignupStep.form;

    setState(() {
      isMainBtnEnabled = fieldsFilled && isFormStep;
    });
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

  void _validateEmail(String? value) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: value)
        .get();

    if (result.docs.isNotEmpty) {
      setState(() {
        _emailError = 'Email is already in use';
      });
      return;
    }
    if (_emailError != null) {
      setState(() {
        _emailError = null;
      });
    }
  }

  void _onDateSelected(DateTime date) {
    // format date to 13 December 2021
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    widget._dateOfBirthController.value = widget._dateOfBirthController.value
        .copyWith(text: formatter.format(date));
    setState(() {
      _selectedDate = date;
    });
  }

  void _onMainBtnPressed() {
    if (!isMainBtnEnabled) return;

    if (widget.step == SignupStep.form) {
      // update firebase user data
    }

    if (widget.step != SignupStep.notifications) {
      SignupScreenRoute(step: _getNextStep()).push(context);
      return;
    }
    // else navigate to tweets
  }

  Widget _buildCurrentStep() {
    switch (widget.step) {
      case SignupStep.form:
        return _buildForm();
      case SignupStep.otp:
        return _buildOtp();
      case SignupStep.profilePicture:
        return _buildProfilePicture();
      case SignupStep.username:
        return _buildUsername();
      case SignupStep.notifications:
        return _buildNotifications();
    }
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create your account',
          style: Theme
              .of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 70),
        Input(
          controller: widget._nameController,
          labelText: "Name",
          maxLength: 50,
          keyboardType: TextInputType.name,
          showCheckMarkWhenValid: true,
        ),
        Input(
          controller: widget._emailController,
          labelText: "Email",
          keyboardType: TextInputType.emailAddress,
          errorText: _emailError,
          showCheckMarkWhenValid: true,
          debouncedOnChanged: _validateEmail,
        ),
        Input(
          controller: widget._dateOfBirthController,
          focusNode: widget._dateOfBirthFocusNode,
          labelText: "Date of birth",
          keyboardType: TextInputType.datetime,
          readOnly: true,
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
            style: Theme
                .of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.grey),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
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
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
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
                widget.step == SignupStep.notifications
                    ? 'Done'
                    : 'Next',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                    color: isMainBtnEnabled
                        ? Colors.black
                        : Colors.black54,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        Visibility(
          visible: isDatePickerVisible,
          child: ScrollWheelDatePicker(
            theme: FlatDatePickerTheme(
              backgroundColor: Colors.transparent,
              overlay: ScrollWheelDatePickerOverlay.holo,
              itemTextStyle: defaultItemTextStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
              overlayColor: Colors.white,
              overAndUnderCenterOpacity: 0.2,
              monthFormat: MonthFormat.threeLetters,
            ),
            lastDate: DateTime.now().add(const Duration(days: 1)),
            onSelectedItemChanged: _onDateSelected,
          ),
        ),
      ],
    );
  }

  Widget _buildOtp() {
    return const SizedBox();
  }

  Widget _buildProfilePicture() {
    return const SizedBox();
  }

  Widget _buildUsername() {
    return const SizedBox();
  }

  Widget _buildNotifications() {
    return const SizedBox();
  }
}
