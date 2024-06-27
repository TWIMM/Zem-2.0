import 'package:agri_market/Services/RequestService.dart';
import 'dart:convert';

class OfferService {
  Future postOffer(dynamic payload) async {
    try {
      final response = await RequestService.post('/offers', payload);

      return jsonEncode(response);
    } catch (e) {
      return jsonEncode({'message': e});
    }
  }

  Future getCategories(dynamic authTooken) async {
    try {
      final response =
          await RequestService.getLikePost('/admin/category', authTooken);

      return response;
    } catch (e) {
      return jsonEncode({'message': e});
    }
  }

  Future getAllOffers(payload) async {
    try {
      final response = await RequestService.getLikePost('/offers', payload);

      return response;
    } catch (e) {
      return jsonEncode({'message': e});
    }
  }
}
