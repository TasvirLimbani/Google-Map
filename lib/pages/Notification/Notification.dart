import 'dart:io';

import 'package:demo/Screens/FirstPage.dart';
import 'package:demo/pages/Notification/NotificationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@drawable/app_icon.png');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(payload) async {
    debugPrint("payload : $payload");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => FirstPage()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Notification",
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
        ),
        actions: [
          IconButton(
            tooltip: "Only Show",
            onPressed: _showBigPictureNotification,
            icon: const Icon(Icons.notifications),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * .4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: InkWell(
                splashColor: Colors.green,
                onTap: _showNotificationWithDefaultSound,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey,
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: Offset(4, 4),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(-4, -4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.notifications),
                      Text(
                        "Simple Notification",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey,
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(4, 4),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(-4, -4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.notifications),
                    Text(
                      "Scheduled  Notification",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey,
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(4, 4),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(-4, -4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.notifications),
                    Text(
                      "Simple Notification",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> _showBigPictureNotification() async {
    final String largeIconPath = await _downloadAndSaveFile(
        'https://www.business2community.com/wp-content/uploads/2018/10/notification_1540708456.png',
        'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(
        'https://babich.biz/content/images/2016/03/1-c3cQvYJrVezv_Az0CoDcbA.jpeg',
        'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
            largeIcon: FilePathAndroidBitmap(largeIconPath),
            contentTitle: 'Simple Notification With Image',
            htmlFormatContentTitle: true,
            summaryText:
                'This Notification Is Simple Notification With Large And Small Image',
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('com.example.demo', 'demo',
            channelDescription: 'big text channel description',
            styleInformation: bigPictureStyleInformation);
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'big text title', 'silent body', platformChannelSpecifics);
  }

  Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'com.example.demo', 'demo',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Simple Notification',
      'This Notification Is Simple Notification',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
}
