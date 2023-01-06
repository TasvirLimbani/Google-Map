import 'dart:convert';
import 'package:http/http.dart' as http;

const String mapKey = "AIzaSyDoX5Qv_jvAmvcuz2eHyznjj2BtvIFkyBg";

class PredictedPlaces {
  String? place_id;
  String? main_text;
  String? secondary_text;

  PredictedPlaces({
    this.place_id,
    this.main_text,
    this.secondary_text,
  });

  PredictedPlaces.fromJson(Map<String, dynamic> jsonData) {
    place_id = jsonData["place_id"];
    main_text = jsonData["structured_formatting"]["main_text"];
    secondary_text = jsonData["structured_formatting"]["secondary_text"];
  }
}

class RequestAssistant {
  static Future<dynamic> receiveRequest(String url) async {
    http.Response httpResponse = await http.get(Uri.parse(url));

    try {
      if (httpResponse.statusCode == 200) //successful
      {
        String responseData = httpResponse.body; //json

        var decodeResponseData = jsonDecode(responseData);

        return decodeResponseData;
      } else {
        return "Error Occurred, Failed. No Response.";
      }
    } catch (exp) {
      return "Error Occurred, Failed. No Response.";
    }
  }
}

class Directions {
  String? humanReadableAddress;
  String? locationName;
  String? locationId;
  double? locationLatitude;
  double? locationLongitude;

  Directions({
    this.humanReadableAddress,
    this.locationName,
    this.locationId,
    this.locationLatitude,
    this.locationLongitude,
  });
}
