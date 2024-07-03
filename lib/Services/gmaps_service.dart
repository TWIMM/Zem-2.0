import 'package:agri_market/Utils/constantes.dart';
import 'package:agri_market/Utils/get_coordinates_from_place_id.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:agri_market/Utils/place_from_coordinates.dart';
import 'package:agri_market/Utils/get_places.dart';

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

  static Future<GetPlaces> getPlaces(String placeName) async {
    Uri uri = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$apikey");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return GetPlaces.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("ERROR");
    }
  }

  static Future<GetCoordinatesFromPlaceId> getPlaceCoordinateFromId(
      String placeId) async {
    Uri uri = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/json?placeid=$placeId&key=$apikey");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return GetCoordinatesFromPlaceId.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("ERROR");
    }
  }
}
