import 'dart:convert';
import 'package:agri_market/Utils/constantes.dart';
import 'package:http/http.dart' as http;

class RequestService {
  static final String baseUrl = apiBaseUrl; // Replace with your API base URL

  static Future<dynamic> post(String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse(baseUrl + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    var body = jsonDecode(response.body);
    var dataa = body['data'];
    print(dataa);

    if (response.statusCode == 200) {
      return {
        "error": false,
        "message": jsonDecode(response.body),
        "data": dataa
      };
    } else if (response.statusCode == 400) {
      return {
        "error": true,
        "message": jsonDecode(response.body)['message'],
      };
    } else if (response.statusCode == 500) {
      return {
        "error": true,
        "message": jsonDecode(response.body)['message'],
      };
    } else {
      throw Exception('Failed to perform POST request');
    }
  }

  static Future<dynamic> getLikePost(String endpoint, var data) async {
    final response = await http.get(
      Uri.parse(baseUrl + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $data',
      },
    );

    if (response.statusCode == 200) {
      return {
        "error": false,
        "message": jsonDecode(response.body),
      };
    } else if (response.statusCode == 400) {
      return {
        "error": true,
        "message": jsonDecode(response.body)['message'],
      };
    } else if (response.statusCode == 500) {
      return {
        "error": true,
        "message": jsonDecode(response.body)['message'],
      };
    } else {
      throw Exception('Failed to perform POST request');
    }
  }

  static Future<dynamic> postLikeGet(
      String endpoint, var data, var authTooken) async {
    final response = await http.post(Uri.parse(baseUrl + endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authTooken',
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return {
        "error": false,
        "message": jsonDecode(response.body),
      };
    } else if (response.statusCode == 400) {
      return {
        "error": true,
        "message": jsonDecode(response.body)['message'],
      };
    } else if (response.statusCode == 500) {
      return {
        "error": true,
        "message": jsonDecode(response.body)['message'],
      };
    } else {
      throw Exception('Failed to perform POST request');
    }
  }
}
