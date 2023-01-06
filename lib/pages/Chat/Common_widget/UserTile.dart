import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/pages/Chat/Colors/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTile extends StatefulWidget {
  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<QuerySnapshot>(context);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Container(
          child: CupertinoContextMenu(
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                    "https://media-exp2.licdn.com/dms/image/C5103AQEHKFsPcNKhXw/profile-displayphoto-shrink_400_400/0/1583564448790?e=1663804800&v=beta&t=Lp9JjFmPEYC8Vk6g-On6-l6DrWjHhyaFXXztZGCiuso",
                  ))),
            ),
            previewBuilder: (BuildContext context, Animation<double> animation,
                Widget child) {
              return FittedBox(
                fit: BoxFit.cover,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0 * animation.value),
                  child: Image.network(
                    "https://media-exp2.licdn.com/dms/image/C5103AQEHKFsPcNKhXw/profile-displayphoto-shrink_400_400/0/1583564448790?e=1663804800&v=beta&t=Lp9JjFmPEYC8Vk6g-On6-l6DrWjHhyaFXXztZGCiuso",
                  ),
                ),
              );
            },
            actions: [
              CupertinoContextMenuAction(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tasvir Limbani"),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient:
                            LinearGradient(colors: [darkColor, lightColor]),
                      ),
                      child: Text(
                        "2",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        title: Text("Tasvir Limbani"),
        subtitle: Text("Hey 👋"),
        trailing: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [darkColor, lightColor]),
          ),
          child: Text(
            "2",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
