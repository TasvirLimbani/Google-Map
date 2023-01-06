import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as image;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final BehaviorSubject<ReceivedNotification>
      didReceiveLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();

  final BehaviorSubject<String?> selectNotificationSubject =
      BehaviorSubject<String?>();

  MethodChannel platform =
      const MethodChannel('dexterx.dev/flutter_local_notifications_example');

  String? selectedNotificationPayload;

  Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  Future<void> _showLinuxNotificationWithBodyMarkup() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      'notification with body markup',
      'bold text\n'
          '<i>italic text</i>\n'
          '<u>underline text</u>\n'
          'https://example.com\n'
          '<a href="https://example.com">example.com</a>',
      null,
    );
  }

  Future<void> _showLinuxNotificationWithCategory() async {
    final LinuxNotificationDetails linuxPlatformChannelSpecifics =
        LinuxNotificationDetails(
      category: LinuxNotificationCategory.emailArrived(),
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      linux: linuxPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'notification with category',
      null,
      platformChannelSpecifics,
    );
  }

  Future<void> _showLinuxNotificationWithByteDataIcon() async {
    final ByteData assetIcon = await rootBundle.load(
      'icons/app_icon_density.png',
    );
    final image.Image? iconData = image.decodePng(
      assetIcon.buffer.asUint8List().toList(),
    );
    final Uint8List iconBytes = iconData!.getBytes();
    final LinuxNotificationDetails linuxPlatformChannelSpecifics =
        LinuxNotificationDetails(
      icon: ByteDataLinuxIcon(
        LinuxRawIconData(
          data: iconBytes,
          width: iconData.width,
          height: iconData.height,
          channels: 4, // The icon has an alpha channel
          hasAlpha: true,
        ),
      ),
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      linux: linuxPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'notification with byte data icon',
      null,
      platformChannelSpecifics,
    );
  }

  Future<void> _showLinuxNotificationWithPathIcon(String path) async {
    final LinuxNotificationDetails linuxPlatformChannelSpecifics =
        LinuxNotificationDetails(icon: FilePathLinuxIcon(path));
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      linux: linuxPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'notification with file path icon',
      null,
      platformChannelSpecifics,
    );
  }

  Future<void> _showLinuxNotificationWithThemeIcon() async {
    final LinuxNotificationDetails linuxPlatformChannelSpecifics =
        LinuxNotificationDetails(
      icon: ThemeLinuxIcon('media-eject'),
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      linux: linuxPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'notification with theme icon',
      null,
      platformChannelSpecifics,
    );
  }

  Future<void> _showLinuxNotificationWithThemeSound() async {
    final LinuxNotificationDetails linuxPlatformChannelSpecifics =
        LinuxNotificationDetails(
      sound: ThemeLinuxSound('message-new-email'),
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      linux: linuxPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'notification with theme sound',
      null,
      platformChannelSpecifics,
    );
  }

  Future<void> _showLinuxNotificationWithCriticalUrgency() async {
    const LinuxNotificationDetails linuxPlatformChannelSpecifics =
        LinuxNotificationDetails(
      urgency: LinuxNotificationUrgency.critical,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      linux: linuxPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'notification with critical urgency',
      null,
      platformChannelSpecifics,
    );
  }

  Future<void> _showLinuxNotificationWithTimeout() async {
    final LinuxNotificationDetails linuxPlatformChannelSpecifics =
        LinuxNotificationDetails(
      timeout: LinuxNotificationTimeout.fromDuration(
        const Duration(seconds: 1),
      ),
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      linux: linuxPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'notification with timeout',
      null,
      platformChannelSpecifics,
    );
  }

  Future<void> _showLinuxNotificationSuppressSound() async {
    const LinuxNotificationDetails linuxPlatformChannelSpecifics =
        LinuxNotificationDetails(
      suppressSound: true,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      linux: linuxPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'suppress notification sound',
      null,
      platformChannelSpecifics,
    );
  }

  Future<void> _showLinuxNotificationTransient() async {
    const LinuxNotificationDetails linuxPlatformChannelSpecifics =
        LinuxNotificationDetails(
      transient: true,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      linux: linuxPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'transient notification',
      null,
      platformChannelSpecifics,
    );
  }

  Future<void> _showLinuxNotificationResident() async {
    const LinuxNotificationDetails linuxPlatformChannelSpecifics =
        LinuxNotificationDetails(
      resident: true,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      linux: linuxPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'resident notification',
      null,
      platformChannelSpecifics,
    );
  }

  Future<void> _showLinuxNotificationDifferentLocation() async {
    const LinuxNotificationDetails linuxPlatformChannelSpecifics =
        LinuxNotificationDetails(location: LinuxNotificationLocation(10, 10));
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      linux: linuxPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'notification on different screen location',
      null,
      platformChannelSpecifics,
    );
  }

  Future<LinuxServerCapabilities> getLinuxCapabilities() =>
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              LinuxFlutterLocalNotificationsPlugin>()!
          .getCapabilities();
}
//
// class SecondPage extends StatefulWidget {
//   const SecondPage(
//     this.payload, {
//     Key? key,
//   }) : super(key: key);
//
//   static const String routeName = '/secondPage';
//
//   final String? payload;
//
//   @override
//   State<StatefulWidget> createState() => SecondPageState();
// }
//
// class SecondPageState extends State<SecondPage> {
//   String? _payload;
//
//   @override
//   void initState() {
//     super.initState();
//     _payload = widget.payload;
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: Text('Second Screen with payload: ${_payload ?? ''}'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('Go back!'),
//           ),
//         ),
//       );
// }
//
// class _InfoValueString extends StatelessWidget {
//   const _InfoValueString({
//     required this.title,
//     required this.value,
//     Key? key,
//   }) : super(key: key);
//
//   final String title;
//   final Object? value;
//
//   @override
//   Widget build(BuildContext context) => Padding(
//         padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
//         child: Text.rich(
//           TextSpan(
//             children: <InlineSpan>[
//               TextSpan(
//                 text: '$title ',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               TextSpan(
//                 text: '$value',
//               )
//             ],
//           ),
//         ),
//       );
// }
