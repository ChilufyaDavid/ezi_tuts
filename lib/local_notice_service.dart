import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> setup() async {
  // #1
  const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');

  // #2
  const initSettings = InitializationSettings(android: androidSetting);

  // #3
  await _localNotificationsPlugin.initialize(initSettings).then((_) {
    debugPrint('setupPlugin: setup success');
  }).catchError((Object error) {
    debugPrint('Error: $error');
  });
}
