import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/pages/Chat/Common_widget/UserTile.dart';
import 'package:demo/pages/Chat/Screen/CallPage.dart';
import 'package:demo/pages/Chat/Screen/ChatPage.dart';
import 'package:demo/pages/Chat/Screen/LoginPage.dart';
import 'package:demo/pages/Chat/Services/auth.dart';
import 'package:demo/pages/Chat/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: DatabaseService().chats,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            _currentIndex == 0
                ? "Chats"
                : _currentIndex == 1
                    ? "Calls"
                    : _currentIndex == 2
                        ? "Explore"
                        : "Profile & Setting",
            style: const TextStyle(letterSpacing: 1, wordSpacing: 1),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await AuthService().signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Column(
          children: [
            if (_currentIndex == 0) ChatScreen(),
            if (_currentIndex == 1) CallScreen(),
          ],
        ),
        bottomNavigationBar: SalomonBottomBar(
          duration: const Duration(seconds: 2),
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              activeIcon: const Icon(Icons.forum_rounded),
              icon: const Icon(Icons.forum_outlined),
              title: const Text("Chats"),
            ),
            SalomonBottomBarItem(
              activeIcon: const Icon(Icons.call),
              icon: const Icon(Icons.call_outlined),
              title: const Text("Calls"),
            ),
            SalomonBottomBarItem(
              activeIcon: const Icon(Icons.widgets),
              icon: const Icon(Icons.widgets_outlined),
              title: const Text("Explore"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.more_horiz),
              activeIcon: const Icon(Icons.more_horiz_outlined),
              title: const Text("More"),
            ),
          ],
        ),
      ),
    );
  }
}
