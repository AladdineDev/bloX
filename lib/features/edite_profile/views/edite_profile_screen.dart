import 'package:flutter/material.dart';

import '../widgets/header_section.dart';
import '../widgets/profile_field.dart';
import '../widgets/visibility_toggle.dart';

class EditeProfileScreen extends StatelessWidget {
  const EditeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text('Edit profile'),
        actions: [
          TextButton(
            onPressed: () {
              // Save action
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: const SingleChildScrollView(
          child: Column(
            children: [
              HeaderSection(),
              SizedBox(height: 40),
              ProfileField(
                label: 'Name',
                initialValue: 'Aladdin',
              ),
              ProfileField(
                label: 'Bio',
                initialValue: '',
              ),
              ProfileField(
                label: 'Location',
                initialValue: '',
              ),
              ProfileField(
                label: 'Website',
                initialValue: '',
              ),
              ProfileField(
                label: 'Birth date',
                initialValue: 'July 8, 1997',
                readOnly: true,
              ),
              VisibilityToggle(
                label: 'Month and day: Only you\nYear: Only you',
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
            ],
          ),
        ),
    );
  }
}


