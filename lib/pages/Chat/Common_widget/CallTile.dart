import 'package:demo/pages/Chat/Colors/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallTile extends StatefulWidget {
  @override
  _CallTileState createState() => _CallTileState();
}

class _CallTileState extends State<CallTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(
              "https://media-exp2.licdn.com/dms/image/C5103AQEHKFsPcNKhXw/profile-displayphoto-shrink_400_400/0/1583564448790?e=1663804800&v=beta&t=Lp9JjFmPEYC8Vk6g-On6-l6DrWjHhyaFXXztZGCiuso",
            ))),
      ),
      title: Text("Tasvir Limbani"),
      subtitle: Row(
        children: [
          Icon(
            Icons.call,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text("Video call (2)")
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.call),
          ),
        ],
      ),
    );
  }
}
