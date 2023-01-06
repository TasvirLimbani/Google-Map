import 'dart:async';
import 'package:demo/pages/MusicPlayer/Model/firebaseData.dart';
import 'package:demo/pages/MusicPlayer/Model/firebaseQuery.dart';
import 'package:demo/pages/MusicPlayer/Model/songData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FavoritePage extends StatefulWidget {
  final Function(int) foryouSelectIndex;
  final Function(SongData) songdata;
  FavoritePage({required this.songdata, required this.foryouSelectIndex});
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int _start = 4;
  bool userPop = false;
  timeCounter(BuildContext context) {
    const oneDecimal = Duration(seconds: 1);
    Timer _timer = Timer.periodic(
        oneDecimal,
        (Timer timer) => setState(() {
              if (_start < 1) {
                timer.cancel();
                userPop ? null : Navigator.of(context).pop();
                _start = 5;
              } else {
                _start = _start - 1;
                print("timer" + _start.toString());
                setState(() {});
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Favorite Songs",
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
          stream: DatabaseService().favoriteSong,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      // behavior: HitTestBehavior.opaque,
                      confirmDismiss: (direction) {
                        timeCounter(context);
                        return Alert(
                          context: context,
                          style: AlertStyle(
                            overlayColor: Colors.black54,
                            animationType: AnimationType.grow,
                            isCloseButton: false,
                            isOverlayTapDismiss: false,
                            descStyle: TextStyle(fontWeight: FontWeight.bold),
                            descTextAlign: TextAlign.center,
                            animationDuration: Duration(seconds: 1),
                            alertBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side:
                                  BorderSide(color: Colors.blueGrey, width: 5),
                            ),
                            titleStyle: TextStyle(
                              color: Colors.red,
                            ),
                            alertAlignment: Alignment.center,
                          ),
                          content: Column(
                            children: [
                              Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        data[index].thumbnail_image),
                                  ),
                                ),
                              ),
                              Text(
                                "${data[index].song_name}",
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                data[index].movie_name.toString(),
                                style: TextStyle(fontSize: 17),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Text(
                                  "Auto Close in 5 Second",
                                  style: TextStyle(
                                      color: Colors.grey.shade300,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Remove",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () {
                                FirebaseQuery.firebaseQuery
                                    .removeSong(data[index].uid.toString());
                                Navigator.pop(context);
                                setState(() {
                                  userPop = true;
                                });
                              },
                              radius: BorderRadius.circular(15),
                            ),
                          ],
                        ).show();
                      },
                      key: Key("${data[index].song_id}"),
                      background: Container(
                        margin: const EdgeInsets.only(right: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.favorite),
                            Text("Remove Favorite"),
                          ],
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            widget.foryouSelectIndex(0);
                            widget.songdata(data[index]);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          tileColor: Colors.grey[200],
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(data[index].image),
                              ),
                            ),
                          ),
                          title: Text(
                            data[index].song_name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            data[index].movie_name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blueGrey[200]),
                            child: const Text("Play"),
                          ),
                        ),
                      ),
                    );
                  });
            }
            if (!snapshot.hasData) {
              return Center(
                child: Image.network(
                    "https://i.pinimg.com/originals/48/fb/90/48fb90bcf2a1f779ee66deee8a12c898.png"),
              );
            }
            return const Center(child: CupertinoActivityIndicator());
          }),
    );
  }
}
