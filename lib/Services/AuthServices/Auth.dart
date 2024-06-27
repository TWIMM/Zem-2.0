import 'package:agri_market/Services/RequestService.dart';
import 'dart:convert';

class AuthService {
  Future login(String email, String password) async {
    final loginData = {
      'login': email,
      'password': password,
    };

    try {
      final response = await RequestService.post('/auth/login', loginData);

      return jsonEncode(response);
    } catch (e) {
      return jsonEncode({'message': e});
    }
  }

  Future register(dynamic payload) async {
    try {
      final response = await RequestService.post('/auth/register', payload);

      return jsonEncode(response);
    } catch (e) {
      return jsonEncode({'message': e});
    }
  }

  Future verify(String email, var otp) async {
    try {
      final response = await RequestService.post(
          '/auth/verify', {'email': email, 'otp': otp});

      return jsonEncode(response);
    } catch (e) {
      return jsonEncode({'message': e});
    }
  }

  Future forgotPwd(String email) async {
    try {
      final response =
          await RequestService.post('/auth/forgot-password', {'email': email});

      return jsonEncode(response);
    } catch (e) {
      return jsonEncode({'message': e});
    }
  }

  Future resendOtp(String email) async {
    try {
      final response =
          await RequestService.post('/auth/resend-otp', {'email': email});

      return jsonEncode(response);
    } catch (e) {
      return jsonEncode({'message': e});
    }
  }
}
