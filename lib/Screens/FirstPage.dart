import 'package:demo/pages/Chat/ChatPage.dart';
import 'package:demo/pages/GoogleMap/GoogleMap.dart';
import 'package:demo/pages/Indicator/Animation_Indicator.dart';
import 'package:demo/pages/MusicPlayer/MusicPlayer.dart';
import 'package:demo/pages/Notification/Notification.dart';

import '../pages/Stripe/StripPayment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Demo Pages",
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            //         leading:   Container(
            //   margin: EdgeInsets.only(right: 15),
            //   height: 40,
            //   width: 5,
            //   decoration: BoxDecoration(
            //       color: Colors.blueGrey,
            //       borderRadius: BorderRadius.circular(20)),
            // ),
            title: const Text("Stripe Payment"),
            // subtitle: Text("Stripe Payment Demo Click 👉"),
            trailing: OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const StripPaymentPage()));
              },
              child: const Text(
                "Strip Payment",
                style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            //         leading:   Container(
            //   margin: EdgeInsets.only(right: 15),
            //   height: 40,
            //   width: 5,
            //   decoration: BoxDecoration(
            //       color: Colors.blueGrey,
            //       borderRadius: BorderRadius.circular(20)),
            // ),
            title: const Text("Google Map"),
            // subtitle: Text("Google Map Demo Click 👉"),
            trailing: OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const GoogleMapPage()));
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => const Scaffold(
                //           body: Center(child: AnimationLoader()),
                //         )));
              },
              child: const Text(
                "Google Map",
                style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            //         leading:   Container(
            //   margin: EdgeInsets.only(right: 15),
            //   height: 40,
            //   width: 5,
            //   decoration: BoxDecoration(
            //       color: Colors.blueGrey,
            //       borderRadius: BorderRadius.circular(20)),
            // ),
            title: const Text("Local Notification"),
            // subtitle: Text("Google Map Demo Click 👉"),
            trailing: OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NotificationPage()));
              },
              child: const Text(
                "Notification",
                style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            //         leading:   Container(
            //   margin: EdgeInsets.only(right: 15),
            //   height: 40,
            //   width: 5,
            //   decoration: BoxDecoration(
            //       color: Colors.blueGrey,
            //       borderRadius: BorderRadius.circular(20)),
            // ),
            title: const Text("Music Player"),
            // subtitle: Text("Google Map Demo Click 👉"),
            trailing: OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MusicPlayer()));
              },
              child: const Text(
                "Music Player",
                style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            //         leading:   Container(
            //   margin: EdgeInsets.only(right: 15),
            //   height: 40,
            //   width: 5,
            //   decoration: BoxDecoration(
            //       color: Colors.blueGrey,
            //       borderRadius: BorderRadius.circular(20)),
            // ),
            title: const Text("Chat App"),
            // subtitle: Text("Google Map Demo Click 👉"),
            trailing: OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ChatPage()));
              },
              child: const Text(
                "Chat App",
                style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
