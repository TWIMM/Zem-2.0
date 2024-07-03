import 'package:agri_market/Utils/constantes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:agri_market/Utils/place_from_coordinates.dart';

class GmapsService {
  static Future<PlaceFromCoordinates> placeFromCoordinates(
      double lat, double long) async {
    Uri uri = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$apikey");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return PlaceFromCoordinates.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("ERROR");
    }
  }
}
