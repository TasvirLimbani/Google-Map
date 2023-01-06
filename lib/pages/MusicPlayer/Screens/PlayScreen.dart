import 'package:audioplayers/audioplayers.dart';
import 'package:demo/pages/MusicPlayer/Button.dart';
import 'package:demo/pages/MusicPlayer/Model/firebaseQuery.dart';
import 'package:demo/pages/MusicPlayer/Model/songData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayScreen extends StatefulWidget {
  SongData songs;
  PlayScreen({
    Key? key,
    required this.songs,
  }) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen>
    with SingleTickerProviderStateMixin {
  double value = 0;
  FToast fToast = FToast();
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  late AnimationController _animationController;
  bool isPaused = false;
  double currentvalue = 0;
  double totalvalue = 100;
  bool isLoaded = false;
  String td = "";
  String cd = "00:00";
  bool isMute = false;
  bool isLocal = true;
  bool isPlaying = true;
  List favoriteAdd = [];

  // void load() async {
  //   widget.songs.primaryArtist.isVerified
  //       ? audioPlayer = await audioCache.play(widget.songs.url)
  //       : audioPlayer.play(widget.songs.url);
  //   // audioPlayer = await audioCache.play(widget.songs.url);
  //   audioPlayer.play(widget.songs.url);
  //
  //   isLoaded = true;
  //   setState(() {});
  // }
  // play() {
  //   audioPlayer.play(widget.songs.song_url);
  // }

  void load() async {
    // widget.songs.is_verified
    //     ? audioPlayer =
    //         (await audioCache.load(widget.songs.song_url)) as AudioPlayer
    //     :
    audioPlayer.play(UrlSource(widget.songs.song_url));

    widget.songs.is_verified = true;
    setState(() {});
  }

  // _showToast({
  //   required String message,
  //   required Icon icon,
  //   required Color textColor,
  //   required Color backColor,
  // }) {
  //   Widget toast = Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(25.0),
  //       color: backColor,
  //     ),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         icon,
  //         const SizedBox(
  //           width: 12.0,
  //         ),
  //         Text(
  //           message,
  //           style: TextStyle(color: textColor),
  //         ),
  //       ],
  //     ),
  //   );
  //
  //   // Custom Toast Position
  //   fToast.showToast(
  //       child: toast,
  //       toastDuration: const Duration(milliseconds: 600),
  //       positionedToastBuilder: (context, child) {
  //         return Positioned(
  //           child: child,
  //           // top: 0.0,
  //           left: 0.0,
  //           right: 0.0,
  //           bottom: 85,
  //         );
  //       });
  // }

  bool songFav = false;
  visited() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool visit = preferences.getBool("songFav") ?? false;
    !visit ? songFav = false : songFav = true;
  }

  void initState() {
    // TODO: implement initState
    audioPlayer.stop();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );
    visited();
    super.initState();
    fToast.init(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: null,
        builder: (context, snapshot) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Container(
                        height: size.height * 0.35,
                        width: size.width * 0.65,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[200],
                            image: DecorationImage(
                                image: NetworkImage(
                                    widget.songs.thumbnail_image))),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      bottom: 0,
                      top: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                              icon: Icons.volume_up,
                              height: 45,
                              width: 45,
                              iconSize: 18),
                          SizedBox(
                            height: 40,
                          ),
                          CustomButton(
                              icon: Icons.volume_down,
                              height: 45,
                              width: 45,
                              iconSize: 18),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 15,
                      bottom: 0,
                      top: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                songFav = !songFav;
                              });
                              // favoriteAdd.clear();
                              songFav
                                  ? FirebaseQuery.firebaseQuery.updateSong(
                                      widget.songs.uid, {"is_verified": true})
                                  : FirebaseQuery.firebaseQuery.updateSong(
                                      widget.songs.uid, {"is_verified": false});
                              setState(() {});
                              favoriteAdd.contains(widget.songs.uid)
                                  ? null
                                  : FirebaseQuery.firebaseQuery.addSong({
                                      'image': widget.songs.image,
                                      'song_url': widget.songs.song_url,
                                      'thumbnail_image':
                                          widget.songs.thumbnail_image,
                                      'movie_name': widget.songs.movie_name,
                                      'song_name': widget.songs.song_name,
                                      'is_verified': widget.songs.is_verified,
                                      'song_id': widget.songs.song_id
                                    });
                              favoriteAdd.add(widget.songs.uid);
                              setState(() {});
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool("songFav", songFav);
                            },
                            child: CustomButton(
                                icon: widget.songs.is_verified
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                iconcolor: widget.songs.is_verified
                                    ? Colors.yellow
                                    : Colors.white,
                                height: 45,
                                width: 45,
                                iconSize: 18),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          CustomButton(
                              icon: Icons.download,
                              height: 45,
                              width: 45,
                              iconSize: 18),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  width: size.width * 0.55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                        icon: Icons.first_page,
                        height: 45,
                        width: 45,
                        iconSize: 18,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              isPaused = !isPaused;
                              isPaused
                                  ? _animationController.reverse()
                                  : _animationController.forward();
                            },
                          );
                          if (isPaused) {
                            audioPlayer.pause();
                          } else {
                            if (!isLoaded) {
                              load();
                            } else {
                              audioPlayer.resume();
                            }
                            setState(() {});
                          }
                          audioPlayer.onDurationChanged.listen((Duration d) {
                            setState(() {
                              td = d.toString().split('.')[0];
                              totalvalue = d.inSeconds.toDouble();
                            });
                          });
                          audioPlayer.onPositionChanged.listen(
                            (Duration d) {
                              setState(
                                () {
                                  cd = d.toString().split('.')[0];
                                  currentvalue = d.inSeconds.toDouble();
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 65,
                          width: 65,
                          decoration: const BoxDecoration(
                            color: Colors.blueGrey,
                            shape: BoxShape.circle,
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
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.white54,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blueGrey,
                                        offset: Offset(5, 10),
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                      ),
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(-3, -4),
                                        spreadRadius: -2,
                                        blurRadius: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Colors.blueGrey,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: AnimatedIcon(
                                      color: Colors.white,
                                      size: 22,
                                      icon: AnimatedIcons.play_pause,
                                      progress: _animationController,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const CustomButton(
                        icon: Icons.last_page,
                        height: 45,
                        width: 45,
                        iconSize: 18,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width * 0.75,
                  child: Slider(
                    onChangeStart: (val) {},
                    value: currentvalue,
                    activeColor: Colors.blueGrey,
                    inactiveColor: Colors.blueGrey[200],
                    max: totalvalue,
                    min: 0,
                    onChanged: (val) async {
                      await audioPlayer.seek(Duration(seconds: val.toInt()));
                      setState(() {
                        currentvalue = val;
                      });
                    },
                  ),
                ),
                Container(
                  width: size.width * 0.75,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Text("$cd"),
                    trailing: Text("$td"),
                  ),
                ),
                ListTile(
                  title: Center(child: Text(widget.songs.song_name.toString())),
                  subtitle: Center(child: Text(widget.songs.movie_name)),
                ),
              ],
            ),
          );
        });
  }
}
