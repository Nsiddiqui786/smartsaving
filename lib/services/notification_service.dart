import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  bool _isInitialized = false;

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  Future<void> initialize() async {
    if (_isInitialized) return;

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: android, iOS: iOS);

    await _flutterLocalNotificationsPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification response
      },
    );

    _isInitialized = true;
  }

  Future<void> showPriceDropNotification({
    required String productName,
    required String oldPrice,
    required String newPrice,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'price_drop_channel',
      'Price Drop Notifications',
      channelDescription: 'Notifications for product price drops',
      importance: Importance.defaultImportance,
      priority: Priority.high,
    );

    const iOSDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      id: DateTime.now().millisecond,
      title: 'Price Dropped! 🎉',
      body: '$productName: $oldPrice → $newPrice',
      notificationDetails: details,
      payload: 'price_drop',
    );
  }

  Future<void> showAlertTriggered({
    required String productName,
    required String targetPrice,
    required String currentPrice,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'price_alert_channel',
      'Price Alerts',
      channelDescription: 'Notifications for price alerts',
      importance: Importance.defaultImportance,
      priority: Priority.high,
    );

    const iOSDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      id: DateTime.now().millisecond,
      title: 'Alert Triggered! ✅',
      body: '$productName is now ₹$currentPrice (Target: ₹$targetPrice)',
      notificationDetails: details,
      payload: 'price_alert',
    );
  }

  Future<void> showGenericNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'generic_channel',
      'General Notifications',
      channelDescription: 'General app notifications',
      importance: Importance.defaultImportance,
    );

    const iOSDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      id: DateTime.now().millisecond,
      title: title,
      body: body,
      notificationDetails: details,
      payload: 'generic',
    );
  }
}

final notificationService = NotificationService();
