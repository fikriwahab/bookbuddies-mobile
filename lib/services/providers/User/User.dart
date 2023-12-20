import 'package:bookbuddies/models/User/User.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {
  final Dio dio = Dio();
  static String? baseUrl = dotenv.env['API_URL'];

  Future<bool> register(String username, String email, String firstName,
      String lastName, String password) async {
    try {
      FormData formData = FormData.fromMap({
        'username': username,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'password': password,
      });

      debugPrint(formData.fields.toString());

      final response = await dio.post(
        '$baseUrl/auth/register/',
        data: formData,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final accessToken = response.data['access'];
        final refreshToken = response.data['refresh'];

        await saveTokens(accessToken, refreshToken);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Error during registration: $e');
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      FormData formData = FormData.fromMap({
        'username': username,
        'password': password,
      });

      final response = await dio.post(
        '$baseUrl/auth/token/',
        data: formData,
      );

      if (response.statusCode == 200) {
        final accessToken = response.data['access'].toString();
        final refreshToken = response.data['refresh'].toString();
        await saveTokens(accessToken, refreshToken);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Error during login: $e');
      return false;
    }
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access', accessToken);
    await prefs.setString('refresh', refreshToken);
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access');
  }

  Future<String?> getRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh');
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access');
    await prefs.remove('refresh');
  }

  Future<User> getUserProfile() async {
    try {
      await refreshToken();
      final response = await dio.get(
        '$baseUrl/auth/profile/',
        options: await _getAuthOptions(),
      );

      if (response.statusCode == 200) {
        debugPrint(response.toString());
        final userJson = response.data as Map<String, dynamic>;
        debugPrint(userJson.toString());
        return User.fromJson(userJson);
      } else {
        throw Exception('Failed to get user profile');
      }
    } catch (e) {
      debugPrint('Error getting user profile: $e');
      throw Exception('Failed to get user profile');
    }
  }

  Future<Options> _getAuthOptions() async {
    final String? token = await getAccessToken();

    if (token != null) {
      return Options(headers: {'Authorization': 'Bearer $token'});
    } else {
      throw Exception('No access token available');
    }
  }

  Future<bool> refreshToken() async {
    try {
      final refreshToken = await getRefreshToken();

      if (refreshToken != null) {
        final response = await dio.post(
          '$baseUrl/auth/token/refresh/',
          data: {'refresh': refreshToken},
        );

        if (response.statusCode == 200) {
          final newAccessToken = response.data['access'].toString();
          await saveTokens(newAccessToken, refreshToken);
          return true;
        } else {
          return false;
        }
      } else {
        throw Exception('No refresh token available');
      }
    } catch (e) {
      debugPrint('Error during token refresh: $e');
      return false;
    }
  }
}
