import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/pages/MusicPlayer/Model/songData.dart';
import 'package:demo/pages/MusicPlayer/Screens/FavoriteScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileScreen extends StatefulWidget {
  final Function(int) foryouSelectIndex;
  final Function(SongData) songdata;
  const ProfileScreen(
      {Key? key, required this.foryouSelectIndex, required this.songdata})
      : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool activeStatus = true;
  bool likeProfile = false;
  FToast fToast = FToast();
  var _currentIndex = 0;
  SongData? _songData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Hey Tasvir Limbani,\nWelcome To Music Player\n2022.",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  letterSpacing: 1,
                  wordSpacing: 2,
                  color: Colors.black87),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: 380,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: -120,
                    right: 0,
                    left: 0,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blueGrey),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://freepngimg.com/save/22654-man/594x600"))),
                    ),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text(
              "Tasvir Limbani",
              style: TextStyle(
                  fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.w600),
            ),
            subtitle: Row(
              children: [
                Text(activeStatus ? "Active Now" : "Active Status Off"),
                Transform.scale(
                  scale: 0.7,
                  child: SizedBox(
                    height: 10,
                    child: Switch(
                        value: activeStatus,
                        onChanged: (e) {
                          setState(() {
                            activeStatus = e;
                          });
                        }),
                  ),
                )
              ],
            ),
            trailing: Transform.scale(
              scale: 0.7,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    likeProfile = !likeProfile;
                  });
                },
                child: Icon(
                  Icons.favorite,
                  color: likeProfile ? Colors.tealAccent : Colors.white,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            height: settingData.length * 40,
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: settingData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (index == 1) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FavoritePage(
                                  foryouSelectIndex: widget.foryouSelectIndex,
                                  songdata: widget.songdata,
                                )));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blueGrey.shade200,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(settingData[index].icon),
                          Text(settingData[index].name),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}

class setting {
  IconData icon;
  String name;
  setting({required this.name, required this.icon});
}

List<setting> settingData = [
  setting(name: "Download Songs", icon: Icons.download),
  setting(name: "Favorite Songs", icon: Icons.favorite),
  setting(name: "Personal Settings", icon: Icons.person),
  setting(name: "Account Settings", icon: Icons.settings),
];
