import 'dart:async';
import 'dart:convert';
import 'package:demo/pages/GoogleMap/AddressTile.dart';
import 'package:demo/pages/GoogleMap/Search_logic.dart';
import 'package:demo/pages/Indicator/Animation_Indicator.dart';
import 'package:demo/pages/Indicator/ProgressIndicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userLat = "userLat";
String userLong = "userLong";
String userDropLat = "userDropLat";
String userDropLong = "userDropLong";
String userPlaceId = "userPlaceId";

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  int mapIndex = 1;
  double lat = 0;
  double long = 0;
  Position? _position;
  Set<Marker> markers = {};
  List<PredictedPlaces> placesPredictedList = [];
  bool selectLocation = false;
  String userDropOffAddress = "";
  bool timerStart = false;
  final int _start = 5;
  double dropLat = 0;
  double dropLong = 0;
  Set<Polyline> polyLineSet = {};
  List<LatLng> polylineCoordinates = [];
  bool _search = false;
  bool _getLocation = false;
  void _getCurrentLocation() async {
    Position position = await _determinPermision();
    setState(() {
      _position = position;
      lat = _position!.latitude;
      long = _position!.longitude;

      markers.add(Marker(
        markerId: MarkerId(1.toString()),
        position: LatLng(lat, long), //position of marker
        infoWindow: InfoWindow(
          title: 'Your Location',
          snippet: '$lat and $long',
        ),
      ));
    });
  }

  Future<Position> _determinPermision() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission are denied');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void autoCompleteSearch(String inputText) async {
    if (inputText.length > 1) //2 or more than 2 input characters
    {
      String urlAutoCompleteSearch =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$mapKey&components=country:IN";

      var responseAutoCompleteSearch =
          await RequestAssistant.receiveRequest(urlAutoCompleteSearch);

      if (responseAutoCompleteSearch ==
          "Error Occurred, Failed. No Response.") {
        return;
      }

      if (responseAutoCompleteSearch["status"] == "OK") {
        var placePredictions = responseAutoCompleteSearch["predictions"];

        var placePredictionsList = (placePredictions as List)
            .map((jsonData) => PredictedPlaces.fromJson(jsonData))
            .toList();

        setState(() {
          placesPredictedList = placePredictionsList;
        });
      }
    }
  }

  getPlaceDirectionDetails(String? placeId, context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        message: "Wait.",
      ),
    );

    String placeDirectionDetailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";

    var responseApi =
        await RequestAssistant.receiveRequest(placeDirectionDetailsUrl);

    Navigator.pop(context);

    if (responseApi["status"] == "REQUEST_DENIED") {
      return showDialog(
        context: context,
        builder: (BuildContext context) => Stack(
          children: [
            AlertDialog(
              title: Column(
                children: const [
                  Text(
                    "ERROR",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Divider(
                    height: 0,
                  )
                ],
              ),
              content: const Text("Please Enter Valid Location"),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Back")),
              ],
            ),
          ],
        ),
      );
    }

    if (responseApi["status"] == "OK") {
      Directions directions = Directions();
      directions.locationName = responseApi["result"]["name"];
      directions.locationId = placeId;
      directions.locationLatitude =
          responseApi["result"]["geometry"]["location"]["lat"];
      dropLat = responseApi["result"]["geometry"]["location"]["lat"];

      directions.locationLongitude =
          responseApi["result"]["geometry"]["location"]["lng"];
      dropLong = responseApi["result"]["geometry"]["location"]["lng"];

      setState(() {
        userDropOffAddress = directions.locationName!;
      });
      _getCurrentLocation();
      markers.add(Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        markerId: MarkerId(2.toString()),
        position: LatLng(dropLat, dropLong), //position of marker
        infoWindow: InfoWindow(
          title: 'Search Location',
          snippet: '$dropLat and $dropLong',
        ),
      ));
      getPolyPoints();
      _search = false;
    }
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "$mapKey",
      PointLatLng(lat, long),
      PointLatLng(dropLat, dropLong),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Google Map",
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
        ),
        actions: [
          IconButton(
            tooltip: "Only Show",
            onPressed: () {},
            icon: Icon(Icons.my_location),
          )
        ],
      ),
      body: _getLocation
          ? Stack(
              children: [
                GoogleMap(
                  markers: markers,
                  mapType: MapType.values[mapIndex],
                  initialCameraPosition: CameraPosition(
                    target: LatLng(lat, long),
                    zoom: 14.4746,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  zoomControlsEnabled: false,
                  polylines: {
                    Polyline(
                        polylineId: PolylineId("route"),
                        points: polylineCoordinates,
                        color: Colors.red,
                        width: 5,
                        onTap: () {}),
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 600),
                      width: _search ? 400 : 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.blueGrey),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 15),
                              child: _search
                                  ? TextFormField(
                                      textInputAction: TextInputAction.search,
                                      style: TextStyle(color: Colors.white),
                                      cursorColor: Colors.white,
                                      onChanged: (valueTyped) {
                                        autoCompleteSearch(valueTyped);
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Search",
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide.none),
                                          hintStyle:
                                              TextStyle(color: Colors.white)),
                                    )
                                  : null,
                            ),
                          ),
                          AnimatedContainer(
                            padding: EdgeInsets.only(right: 10),
                            duration: Duration(milliseconds: 600),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _search = !_search;
                                  placesPredictedList.clear();
                                  polylineCoordinates.clear();
                                });
                              },
                              child: Icon(
                                _search ? Icons.close : Icons.search,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _search
                    ? Container(
                        height: size.height / 2,
                        margin: EdgeInsets.only(top: 60, left: 10, right: 10),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: ListView.builder(
                            itemCount: placesPredictedList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    onTap: () async {
                                      getPlaceDirectionDetails(
                                          placesPredictedList[index].place_id,
                                          context);

                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setDouble(userLat, lat);
                                      await prefs.setDouble(userLong, long);
                                      await prefs.setDouble(
                                          userDropLat, dropLat);
                                      await prefs.setDouble(
                                          userDropLong, dropLong);
                                      await prefs.setString(
                                          userPlaceId,
                                          placesPredictedList[index]
                                              .place_id
                                              .toString());
                                      setState(() {});
                                      bool visit =
                                          prefs.getBool('counter') ?? true;
                                      await prefs.setBool('counter', visit);
                                      prefs.getString(userDropLong);
                                      print("asasasasa" + userDropLong);
                                      //   _search = false;
                                      // });
                                    },
                                    title: Text(
                                        "${placesPredictedList[index].main_text}"),
                                    subtitle: Text(
                                      "${placesPredictedList[index].secondary_text}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    // trailing: Icon(
                                    //   Icons.verified,
                                    //   color: widget.selectLocation ? Colors.green : Colors.grey,
                                    // ),
                                  ),
                                  const Divider(
                                    height: 0,
                                    indent: 15,
                                    // endIndent: 20,
                                  ),
                                ],
                              );
                            }),
                      )
                    : Container(),
              ],
            )
          : Center(
              child: TextButton.icon(
                  onPressed: () async {
                    Position position = await _determinPermision();
                    _position = position;
                    setState(() {
                      lat = _position!.latitude;
                      long = _position!.longitude;
                      _getLocation = true;
                    });
                  },
                  icon: Icon(Icons.wifi),
                  // ignore: prefer_const_constructors
                  label: Text("Choose Your Current Location")),
            ),
      floatingActionButton: _getLocation
          ? Container(
              margin: EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton.extended(
                    backgroundColor:
                        mapIndex == 1 ? Colors.blueGrey : Colors.green,
                    splashColor: mapIndex == 1
                        ? Colors.blueGrey[900]
                        : Colors.green[900],
                    onPressed: _getCurrentLocation,
                    icon: Icon(Icons.person_pin_circle),
                    label: Text("My Location"),
                  ),
                  SpeedDial(
                    animatedIcon: AnimatedIcons.menu_close,
                    animatedIconTheme: IconThemeData(size: 28.0),
                    backgroundColor:
                        mapIndex == 1 ? Colors.blueGrey : Colors.green,
                    visible: true,
                    curve: Curves.bounceInOut,
                    children: [
                      SpeedDialChild(
                        child: Icon(Icons.map, color: Colors.white),
                        backgroundColor:
                            mapIndex == 1 ? Colors.blueGrey : Colors.green,
                        onTap: () {
                          setState(() {
                            mapIndex = 1;
                          });
                        },
                        label: 'Normal',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                        labelBackgroundColor: Colors.black,
                      ),
                      SpeedDialChild(
                        child: Icon(Icons.park, color: Colors.white),
                        backgroundColor:
                            mapIndex == 1 ? Colors.blueGrey : Colors.green,
                        onTap: () {
                          setState(() {
                            mapIndex = 2;
                          });
                        },
                        label: 'Hybrid',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                        labelBackgroundColor: Colors.black,
                      ),
                      SpeedDialChild(
                        child: Icon(Icons.home_mini, color: Colors.white),
                        backgroundColor:
                            mapIndex == 1 ? Colors.blueGrey : Colors.green,
                        onTap: () {
                          setState(() {
                            mapIndex = 3;
                          });
                        },
                        label: 'Satellite',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                        labelBackgroundColor: Colors.black,
                      ),
                      SpeedDialChild(
                        child: Icon(Icons.travel_explore, color: Colors.white),
                        backgroundColor:
                            mapIndex == 1 ? Colors.blueGrey : Colors.green,
                        onTap: () {
                          setState(() {
                            mapIndex = 4;
                          });
                        },
                        label: 'Terrain',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                        labelBackgroundColor: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
