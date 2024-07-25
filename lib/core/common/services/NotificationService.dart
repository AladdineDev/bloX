import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  static final NotificationService instance = NotificationService._internal();

  factory NotificationService() {
    return instance;
  }

  NotificationService._internal();

  Future<void> requestPermission() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      print('User declined or has not accepted permission');
      return;
    }

    print('User granted permission');
    final token = await FirebaseMessaging.instance.getToken();
    print('User FCM token: $token');

    final userId = FirebaseAuth.instance.currentUser?.uid;
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'notificationToken': token,
      });
    } catch (error) {
      print('Error writing on Firestore: $error');
    }
  }

  void initNotifications() {
    Future<void> _onBackgroundMessage(RemoteMessage message) async {
      print(
          '[onBackgroundMessage] We received a backgroundMessage: ${message.notification?.title}');
    }

    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      print('[onMessage] RemoteMessage: ${remoteMessage.notification?.title}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      final title = remoteMessage.notification?.title;
      final data = remoteMessage.data;

      print(
          '[onMessageOpenedApp] Got notification with title: $title and data: $data');
    });
  }

  void openSettings() async {
    await AwesomeNotifications().showNotificationConfigPage();

  }

}
