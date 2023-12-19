import 'package:eye_20_20/utils/common_utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();
  final _winNotifyPlugin = WindowsNotification(applicationId: "Eye 20 20");

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/eye_icon');

    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings();

    final InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings,
        macOS: darwinInitializationSettings);

    await _localNotificationService.initialize(
      settings,
    );
    await checkPermissionsAndRequest();
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);

    const iosNotificationDetails =
        DarwinNotificationDetails(presentAlert: true, presentSound: true);

    return const NotificationDetails(
        android: androidNotificationDetails,
        iOS: iosNotificationDetails,
        macOS: iosNotificationDetails);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    if (CommonUtils.isWindows()) {
      NotificationMessage message = NotificationMessage.fromPluginTemplate(
        id.toString(),
        title,
        body,
      );
      _winNotifyPlugin.showNotificationPluginTemplate(message);
    } else {
      final details = await _notificationDetails();
      await _localNotificationService.show(id, title, body, details);
    }
  }

  Future checkPermissionsAndRequest() async {
    final enabled = await _localNotificationService
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled();

    if (!(enabled ?? false)) {
      _localNotificationService
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
  }
}
