// ignore_for_file: file_names
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingAPI {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Function to initialize notifications
  Future<void> initializeNotifications() async {
    try {
      // Check if permission has already been granted
      NotificationSettings settings = await _firebaseMessaging.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        final fcmToken = await _firebaseMessaging.getToken();
        print('Token: $fcmToken');
      } else {
        print('Permission denied by user');
      }
    } catch (e) {
      print('Error requesting permission: $e');
    }
  }
}
