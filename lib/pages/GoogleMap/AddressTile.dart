import 'dart:async';

import 'package:demo/pages/GoogleMap/Search_logic.dart';
import 'package:flutter/material.dart';

class AddressTile extends StatefulWidget {
  bool selectLocation;
  PredictedPlaces predictedPlaces;
  List<PredictedPlaces> placesPredictedList;
  bool search;
  AddressTile(
      {Key? key,
      required this.selectLocation,
      required this.predictedPlaces,
      required this.search,
      required this.placesPredictedList})
      : super(key: key);

  @override
  _AddressTileState createState() => _AddressTileState();
}

class _AddressTileState extends State<AddressTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          title: Text("${widget.predictedPlaces.main_text}"),
          subtitle: Text(
            "${widget.predictedPlaces.secondary_text}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(
            Icons.verified,
            color: widget.selectLocation ? Colors.green : Colors.grey,
          ),
        ),
        Divider(
          height: 0,
          indent: 15,
          // endIndent: 20,
        ),
      ],
    );
  }
}
