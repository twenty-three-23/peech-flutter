import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_device_uuid_storage.dart';
import 'package:swm_peech_flutter/features/common/dio/auth_dio_factory.dart';
import 'package:swm_peech_flutter/features/common/platform/platform_device_info/platform_device_info.dart';
import 'package:swm_peech_flutter/firebase_messaging/data_source/remote_remove_fcm_token.dart';
import 'package:swm_peech_flutter/firebase_messaging/data_source/remote_save_fcm_token.dart';
import 'package:swm_peech_flutter/firebase_messaging/model/notification_data.dart';
import 'package:swm_peech_flutter/firebase_messaging/model/save_token_request_model.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('[FCM] onBackgroundMessage = ${message.data.toString()}');
}

class FirebaseMessagingManager {
  static Future<void> initialize() async {
    if (kIsWeb) return;
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    print('FCM token = ${await FirebaseMessaging.instance.getToken()}');
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      print('onTokenRefresh = $fcmToken');
      putFcmToken(fcmToken: fcmToken);
    }).onError((err) {
      print('onTokenRefresh error = $err');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('[Foreground Message] title: ${message.notification?.title}, body: ${message.notification?.body}, deepLink: ${message.data['deepLink']}');

      // 알림이 있다면 로컬 알림으로 표시
      LocalNotificationManager.showNotification({
        'title': message.notification?.title ?? '',
        'body': message.notification?.body ?? '',
        'deepLink': message.data['deepLink'] ?? '',
      });
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await LocalNotificationManager.initialize();
  }

  static Future<NotificationData?> getInitialMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage == null) return null;

    return NotificationData(
      title: initialMessage.notification?.title,
      body: initialMessage.notification?.body,
      deepLink: initialMessage.data['deepLink']?.toString() ?? '',
    );
  }

  static Future<String?> getToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      print('getToken failed = $e');
    }
    return null;
  }

  static void onNotificationOpened() {
    print('onNotificationOpened');
    // AnalyticsManager.sendEvent(AnalyticsEvent.openPushClick);
  }

  static void putFcmToken({String? fcmToken = null}) async {
    if (fcmToken == null) fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
    print('[putFcmToken] fcmToken = $fcmToken');
    RemoteSaveFcmToken remoteSaveFcmToken = RemoteSaveFcmToken(AuthDioFactory().dio);
    remoteSaveFcmToken.putFcmToken(SaveTokenRequestModel(
      deviceId: await LocalDeviceUuidStorage().getDeviceUuid() ?? 'unknown',
      fcmToken: fcmToken,
    ));
  }

  static Future<void> deleteFcmToken() async {
    print('[deleteFcmToken] deviceUuid = ${await LocalDeviceUuidStorage().getDeviceUuid() ?? 'unknown'}');
    RemoteRemoveFcmToken remoteRemoveFcmToken = RemoteRemoveFcmToken(AuthDioFactory().dio);
    remoteRemoveFcmToken.deleteFcmToken(await LocalDeviceUuidStorage().getDeviceUuid() ?? 'unknown');
  }
}

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

class LocalNotificationManager {
  static const defaultNotificationChannelId = 'default_notification_channel';
  static const chatNotificationChannelId = 'chat_notification_channel';

  static Future<void> initialize() async {
    await requestLocalNotificationPermission();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin?.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(
          const AndroidNotificationChannel(
            defaultNotificationChannelId,
            'Default Notifications',
            importance: Importance.max,
          ),
        );
    flutterLocalNotificationsPlugin?.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(
          const AndroidNotificationChannel(
            chatNotificationChannelId,
            'Chat Notifications',
            importance: Importance.max,
            groupId: 'chat_notification_group',
          ),
        );

    await flutterLocalNotificationsPlugin?.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: _onDidReceiveLocalNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: _onDidReceiveLocalNotificationResponse,
    );
  }

  static Future<bool?> requestLocalNotificationPermission() async {
    if (PlatformDeviceInfo.isIOS()) {
      return await flutterLocalNotificationsPlugin?.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else {
      // android
      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      return flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    }
  }

  static Future<void> showNotification(Map<String, dynamic> data) async {
    if (flutterLocalNotificationsPlugin == null) {
      await initialize();
    }

    final notificationData = NotificationData(
      title: data['title']?.toString(),
      body: data['body']?.toString(),
      deepLink: data['deepLink']?.toString(),
    );

    if (notificationData.title == null && notificationData.body == null) {
      // Sentry.captureException(
      //   Exception('Notification title and body cannot be null or empty'),
      //   stackTrace: StackTrace.current,
      // );
      return;
    }

    flutterLocalNotificationsPlugin?.show(
      data.hashCode,
      notificationData.title,
      notificationData.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          defaultNotificationChannelId,
          'High Importance Notifications',
        ),
      ),
      payload: jsonEncode(notificationData.toMap()),
    );
  }

  static Future<void> clearNotification() async {
    print('clearNotification');
    flutterLocalNotificationsPlugin ??= FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin?.cancelAll();
  }

  static Future<void> cancelNotification(int id) async {
    print('cancelNotification = $id');
    flutterLocalNotificationsPlugin ??= FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin?.cancel(id);
  }

  static void _onDidReceiveLocalNotificationResponse(NotificationResponse notification) {
    FirebaseMessagingManager.onNotificationOpened();
    print(
      'didReceiveLocalNotificationResponse = ${notification.notificationResponseType}, ${notification.id}, ${notification.actionId}, ${notification.input}, ${notification.payload}',
    );

    if (notification.payload == null) return;

    NotificationData data = NotificationData.fromMap(
      jsonDecode(notification.payload!) as Map<String, dynamic>,
    );

    // DeepLinkManager.handleUrl(data);
  }
}
