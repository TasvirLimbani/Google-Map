// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationApi {
//   static final NotificationApi _notificationApi = NotificationApi._internal();
//   factory NotificationApi() {
//     return _notificationApi;
//   }
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   NotificationApi._internal();
//   Future<void> initNotification() async {
//     // final AndroidInitializationSettings initializationSettingsAndroid =
//     //     AndroidInitializationSettings();
//     final IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//     );
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       iOS: initializationSettingsIOS,
//       // android: initializationSettingsAndroid
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   Future<void> showNotification(data) async {
//     var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//         'com.danieltaverny.driversapp', 'UBER_DRIVERS_APP',
//         playSound: true,
//         // sound: RawResourceAndroidNotificationSound("music_notification"),
//         importance: Importance.high,
//         priority: Priority.high);
//     var iOSPlatformChannelSpecifics = new IOSNotificationDetails(
//         // sound: "music_notification.aiff",
//         );
//     var platformChannelSpecifics = new NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'New Post',
//       data,
//       platformChannelSpecifics,
//       payload: 'Custom_Sound',
//     );
//   }
//   // Future<void> showNotification(
//   //     int id, String title, String body, String payload) async {
//   //   await flutterLocalNotificationsPlugin.show(
//   //     id,
//   //     title,
//   //     body,
//   //     NotificationDetails(
//   //         android: AndroidNotificationDetails('com.example.demo', 'm',
//   //             // channelDescription: 'com.example.demo',
//   //             playSound: true,
//   //             importance: Importance.max),
//   //         iOS: IOSNotificationDetails(
//   //           presentAlert: true,
//   //           presentBadge: true,
//   //           presentSound: true,
//   //         )),
//   //     payload: payload,
//   //   );
//   // }
//
// }
//
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// //
// // class NotificationService {
// //   static final _notification = FlutterLocalNotificationsPlugin();
// //   static Future _notificationDetails() async {
// //     return NotificationDetails(
// //       android: AndroidNotificationDetails('channel id', 'channel name',
// //           importance: Importance.max),
// //       iOS: IOSNotificationDetails(),
// //     );
// //   }
// //
// //   static Future showNotification({
// //     int id = 0,
// //     String title = "",
// //     String body = "",
// //     String payload = "",
// //   }) async {
// //     _notification.show(id, title, body, await _notificationDetails(),
// //         payload: payload);
// //   }
// // }
