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

    await _flutterLocalNotificationsPlugin.initialize(initSettings);

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
      DateTime.now().millisecond,
      'Price Dropped! 🎉',
      '$productName: $oldPrice → $newPrice',
      details,
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
      DateTime.now().millisecond,
      'Alert Triggered! ✅',
      '$productName is now ₹$currentPrice (Target: ₹$targetPrice)',
      details,
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
      DateTime.now().millisecond,
      title,
      body,
      details,
    );
  }
}

final notificationService = NotificationService();
