import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Initialize local notifications
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher'); // Use app icon
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    // Request permissions for notifications (iOS only)
    final NotificationSettings settings =
        await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else {}

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message); // Display local notification
      _handleNotification(message);
    });

    // Handle when the app is opened from a background notification
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotification);

    // Check if the app was opened from a terminated state
    final RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotification(initialMessage);
    }
  }

  void _handleNotification(RemoteMessage message) {
    // Process notification data
    if (message.notification != null) {}
    if (message.data.isNotEmpty) {}
  }

  void _showLocalNotification(RemoteMessage message) async {
    // Notification details for Android
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel', // Channel ID
      'High Importance Notifications', // Channel Name
      importance: Importance.max,
      priority: Priority.high,
    );

    // Notification details for iOS
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    // Show notification
    await _flutterLocalNotificationsPlugin.show(
      message.hashCode, // Unique notification ID
      message.notification?.title ?? 'Notification', // Notification title
      message.notification?.body ?? 'No message body', // Notification body
      platformChannelSpecifics,
      payload: message.data.toString(), // Optional: pass custom data
    );
  }

  Future<void> subscribeToTopic(String topicName) async {
    await _firebaseMessaging
        .subscribeToTopic(topicName)
        .then((_) {})
        .catchError((error) {});
  }

  Future<void> cancelSubscribitionTopic(String topicName) async {
    await _firebaseMessaging
        .unsubscribeFromTopic(topicName)
        .then((_) {})
        .catchError((error) {});
  }
}
