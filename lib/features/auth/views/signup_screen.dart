import 'dart:async';
import 'dart:io';

import 'package:blox/core/common/services/NotificationService.dart';
import 'package:blox/core/common/widgets/input.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/features/auth/widgets/account_follow_tile.dart';
import 'package:blox/features/auth/widgets/x_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

enum SignupStep { form, otp, profilePicture, username, notifications }

class SignupScreen extends StatefulWidget {
  final SignupStep step;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final FocusNode _dateOfBirthFocusNode = FocusNode();

  SignupScreen({super.key, required this.step});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Timer? _verificationCheckTimer;

  bool isMainBtnEnabled = false;
  String? _emailError;
  DateTime? _selectedDate;
  XFile? _profileImage;
  bool isDatePickerVisible = false;
  String? _usernameError;

  @override
  void initState() {
    super.initState();

    switch (widget.step) {
      case SignupStep.form:
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
        break;
      case SignupStep.otp:
        _startVerificationCheck();
        break;
      case SignupStep.profilePicture:
        break;
      case SignupStep.username:
        widget._usernameController.addListener(checkFieldsAndSetButtonState);
        break;
      case SignupStep.notifications:
        NotificationService.instance.requestPermission();
        setState(() {
          isMainBtnEnabled = true;
        });
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    widget._nameController.removeListener(checkFieldsAndSetButtonState);
    widget._emailController.removeListener(checkFieldsAndSetButtonState);
    widget._dateOfBirthController.removeListener(checkFieldsAndSetButtonState);
    widget._usernameController.removeListener(checkFieldsAndSetButtonState);
    _verificationCheckTimer?.cancel();
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
              height: MediaQuery.of(context).size.height -
                  Scaffold.of(context).appBarMaxHeight!,
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    _buildCurrentStep(),
                    const Spacer(flex: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: _isStepSkippable(),
                          child: OutlinedButton(
                            style: ButtonStyle(
                              textStyle: WidgetStateProperty.all(
                                  const TextStyle(color: Colors.white)),
                            ),
                            onPressed: _skip,
                            child: Text(
                              'Skip for now',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ),
                        FilledButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                isMainBtnEnabled ? Colors.white : Colors.grey),
                          ),
                          onPressed: _onMainBtnPressed,
                          child: Text('Next',
                            style: Theme.of(context)
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
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void _skip() {
    SignupStep? nextStep = _getNextStep();
    if (nextStep == null) return;
    SignupScreenRoute(step: nextStep).push(context);
  }

  SignupStep? _getNextStep() {
    if (widget.step == SignupStep.values.last) {
      return null;
    }
    return SignupStep.values[widget.step.index + 1];
  }

  void checkFieldsAndSetButtonState() {
    if (widget.step == SignupStep.form) {
      final bool fieldsFilled = widget._nameController.text.isNotEmpty &&
          widget._emailController.text.isNotEmpty &&
          _emailError == null &&
          widget._dateOfBirthController.text.isNotEmpty;
      setState(() {
        isMainBtnEnabled = fieldsFilled;
      });
    }
  }

  void _startVerificationCheck() {
    _verificationCheckTimer =
        Timer.periodic(const Duration(seconds: 2), (timer) async {
      var user = FirebaseAuth.instance.currentUser;
      await user?.reload();
      user = FirebaseAuth.instance.currentUser;
      print('User verified : ${user?.emailVerified}');
      if (user?.emailVerified ?? false) {
        timer.cancel();
        setState(() {
          isMainBtnEnabled = true;
        });
        Fluttertoast.showToast(
          msg: "Email verified!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }
    });
  }

  bool _isStepSkippable() {
    switch (widget.step) {
      case SignupStep.profilePicture:
        return true;
      case SignupStep.username:
        return true;
      default:
        return false;
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

  void _onMainBtnPressed() async {
    if (!isMainBtnEnabled) return;

    if (widget.step == SignupStep.form) {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget._emailController.text,
        password: 'Password123!',
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'displayName': widget._nameController.text,
        'email': widget._emailController.text,
        'dateOfBirth': _selectedDate,
      });

      final user = userCredential.user;
      print('User: $user');
      if (user != null) {
        user.sendEmailVerification();
        user.updateDisplayName(widget._nameController.text);
      }
    }

    SignupStep? nextStep = _getNextStep();
    print('nextStep: $nextStep');
    if (nextStep == null) {
      TweetListScreenRoute().go(context);
      return;
    }
    SignupScreenRoute(step: nextStep).push(context);
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
      /*case SignupStep.followAccounts:
        return _buildFollowAccounts();*/
    }
  }

  Widget _buildForm() {
    return Column(
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
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildOtp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'We sent you a verification link',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          'Please check your email and click on the link to verify your account.',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildProfilePicture() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pick a profile picture title
        Text(
          'Pick a profile picture',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          'Have a favourite selfie? Upload it now.',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 40),
        Center(
          child: GestureDetector(
            onTap: _pickAndCropImage,
            child: _profileImage == null
                ? DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    padding: const EdgeInsets.all(6),
                    color: Colors.blue,
                    dashPattern: const [8, 4],
                    child: const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_outlined,
                                color: Colors.blue, size: 40),
                            SizedBox(height: 12),
                            Text(
                              'Upload',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.file(
                      File(_profileImage!.path),
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildUsername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What should we call you?',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          'Your @username is unique. You can always change it later.',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 20),
        Input(
          controller: widget._usernameController,
          labelText: "Username",
          keyboardType: TextInputType.text,
          showCheckMarkWhenValid: true,
          errorText: _usernameError,
          debouncedOnChanged: _validateUsername,
        ),
      ],
    );
  }

  Widget _buildNotifications() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Turn on notifications',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Get the most out of X by staying up to date with what's happening",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () => NotificationService.instance.openSettings(),
                child: const Text('Allow notifications'),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  _skip();
                },
                child: const Text('Skip for now', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowAccounts() {
    return Expanded(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Follow 1 or more accounts',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              "When you follow someone, you'll see their posts in your timeline. You'll also get more relevant recommendations.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                // TODO: Replace with actual recommended users
                itemCount: 0,
                itemBuilder: (context, index) {
                  // return AccountFollowTile(user: users[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
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

  void _validateUsername(String username) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    if (result.docs.isNotEmpty) {
      setState(() {
        _usernameError =
            "This username is already taken. Please try another one.";
      });
      return;
    }
    setState(() {
      isMainBtnEnabled = _usernameError == null;
      if (_usernameError != null) {
        _usernameError = null;
      }
    });
  }

  Future<void> _pickAndCropImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Move and scale',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
          ),
          IOSUiSettings(
            title: 'Move and scale',
          )
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _profileImage = XFile(croppedFile.path);
          isMainBtnEnabled = true;
        });

        // TODO: Use repository pattern to run this code
        String filePath = 'profilePictures/${DateTime.now().millisecondsSinceEpoch}_${croppedFile.path.split('/').last}';
        Reference ref = FirebaseStorage.instance.ref().child(filePath);
        UploadTask uploadTask = ref.putFile(File(croppedFile.path));
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        final user = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .set({'profileImageUrl': downloadUrl});

        // debug user id
        print('User id: ${user.uid}');
      }
    }
  }
}
