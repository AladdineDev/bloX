import 'package:blox/app.dart';
import 'package:blox/core/common/services/NotificationService.dart';
import 'package:blox/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // NotificationService.instance.initNotifications();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(const MyApp());
}
