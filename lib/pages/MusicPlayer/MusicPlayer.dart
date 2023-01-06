import 'package:demo/pages/MusicPlayer/Model/firebaseData.dart';
import 'package:demo/pages/MusicPlayer/Model/songData.dart';
import 'package:demo/pages/MusicPlayer/Screens/PremiumScreen.dart';
import 'package:demo/pages/MusicPlayer/Screens/ProfileScreen.dart';
import 'package:flutter/cupertino.dart';

import 'Screens/ForYouScreen.dart';
import 'Screens/PlayScreen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  var _currentIndex = 0;
  SongData? _songData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Music Player",
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
        ),
        actions: [
          IconButton(
            tooltip: "Only Show",
            onPressed: () {},
            icon: const Icon(Icons.library_music),
          )
        ],
      ),
      body: StreamBuilder<List<SongData>>(
          stream: DatabaseService().songs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return Stack(
                children: [
                  if (_currentIndex == 0)
                    PlayScreen(
                      songs: _songData ?? data![0],
                    ),
                  if (_currentIndex == 1)
                    ForYou(
                      foryouSelectIndex: (c) {
                        setState(() {
                          _currentIndex = c;
                        });
                      },
                      songdata: (data) {
                        setState(() {
                          _songData = data;
                        });
                      },
                      songData: data,
                    ),
                  if (_currentIndex == 2)
                    ProfileScreen(
                      foryouSelectIndex: (c) {
                        setState(() {
                          _currentIndex = c;
                        });
                      },
                      songdata: (data) {
                        setState(() {
                          _songData = data;
                        });
                      },
                    ),
                  if (_currentIndex == 3) PremiumScreen(),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(
              child: Text("Loading"),
            );
          }),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(50)),
        child: SalomonBottomBar(
          duration: const Duration(seconds: 2),
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              activeIcon: const Icon(Icons.play_arrow),
              icon: const Icon(Icons.play_arrow_outlined),
              title: const Text("Play"),
            ),
            SalomonBottomBarItem(
              activeIcon: const Icon(Icons.headphones),
              icon: const Icon(Icons.headphones_outlined),
              title: const Text("For You"),
            ),
            SalomonBottomBarItem(
              activeIcon: const Icon(Icons.person),
              icon: const Icon(Icons.person_outlined),
              title: const Text("Me"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.rocket_launch_outlined),
              activeIcon: const Icon(Icons.rocket_launch),
              title: const Text("Premium"),
            ),
          ],
        ),
      ),
    );
  }
}
