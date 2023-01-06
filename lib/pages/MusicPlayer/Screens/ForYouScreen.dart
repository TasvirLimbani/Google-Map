import 'dart:convert';
import 'package:demo/pages/MusicPlayer/Model/firebaseData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/songData.dart';

class ForYou extends StatefulWidget {
  final Function(int) foryouSelectIndex;
  final Function(SongData) songdata;
  List<SongData>? songData;
  ForYou({
    Key? key,
    required this.foryouSelectIndex,
    required this.songData,
    required this.songdata,
  }) : super(key: key);

  @override
  _ForYouState createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {
  int arijitLength = 0;
  int arrahmnaLength = 0;
  bool arijitFav = false;
  bool arrahmanFav = false;

  visited() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool visit = preferences.getBool("counter") ?? false;
    !visit ? arijitFav = false : arijitFav = true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visited();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 257,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.songData!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      widget.foryouSelectIndex(0);
                      widget.songdata(widget.songData![index]);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.blueGrey, width: 2)),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      widget.songData![index].image),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          width: 170,
                          child: ListTile(
                            minVerticalPadding: -10,
                            contentPadding: EdgeInsets.zero,
                            title: Center(
                                child: Text(widget.songData![index].song_name
                                    .toString())),
                            subtitle: Center(
                                child:
                                    Text(widget.songData![index].movie_name)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 280,
            child: StreamBuilder<List<SongData>>(
                stream: DatabaseService().arijitSingh,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    arijitLength = snapshot.data!.length;
                    final data = snapshot.data;
                    return Column(
                      children: [
                        ListTile(
                          onTap: null,
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://pbs.twimg.com/profile_images/1291384747227099136/jMuAw4IQ_400x400.jpg"),
                          ),
                          title: const Text(
                            "Arijit Singh",
                            style: TextStyle(fontSize: 17),
                          ),
                          subtitle:
                              Text("Arijit Singh Top ${data!.length} Song"),
                          trailing: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  arijitFav = !arijitFav;
                                });
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setBool("counter", arijitFav);
                              },
                              child: Icon(
                                arijitFav
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color:
                                    arijitFav ? Colors.blueGrey : Colors.grey,
                              )),
                        ),
                        Expanded(
                          child: GridView.builder(
                              itemCount: data.length,
                              scrollDirection: Axis.horizontal,
                              // shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.22,
                                crossAxisCount: 3,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.foryouSelectIndex(0);
                                      widget.songdata(data[index]);
                                    });
                                  },
                                  child: GridTile(
                                    songs: data[index],
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
                  }
                  return const Center(child: CupertinoActivityIndicator());
                }),
          ),
          Divider(
            indent: 20,
            thickness: 1,
            color: Colors.blueGrey.shade300,
            endIndent: 20,
          ),
          SizedBox(
            height: 280,
            child: StreamBuilder<List<SongData>>(
                stream: DatabaseService().A_R_Rahman,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    arrahmnaLength = snapshot.data!.length;
                    final data = snapshot.data;
                    return Column(
                      children: [
                        ListTile(
                          onTap: null,
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://static.toiimg.com/photo/msid-91651723/91651723.jpg?38220"),
                          ),
                          title: const Text(
                            "A R Rahman",
                            style: TextStyle(fontSize: 17),
                          ),
                          subtitle: Text("A R Rahman Top ${data!.length} Song"),
                          trailing: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  arrahmanFav = !arrahmanFav;
                                });
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setBool("counter", arrahmanFav);
                              },
                              child: Icon(
                                arrahmanFav
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color:
                                    arrahmanFav ? Colors.blueGrey : Colors.grey,
                              )),
                        ),
                        Expanded(
                          child: GridView.builder(
                              itemCount: data.length,
                              scrollDirection: Axis.horizontal,
                              // shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.22,
                                crossAxisCount: 3,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.foryouSelectIndex(0);
                                      widget.songdata(data[index]);
                                    });
                                  },
                                  child: GridTile(
                                    songs: data[index],
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
                  }
                  return const Center(child: CupertinoActivityIndicator());
                }),
          ),
        ],
      ),
    );
  }
}

class GridTile extends StatefulWidget {
  SongData songs;
  GridTile({required this.songs});
  @override
  _GridTileState createState() => _GridTileState();
}

class _GridTileState extends State<GridTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(widget.songs.image),
          ),
        ),
      ),
      title: Text(
        widget.songs.song_name.toString(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        widget.songs.movie_name.toString(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blueGrey[200]),
        child: Text("Play"),
      ),
    );
  }
}
