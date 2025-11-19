import 'package:http/http.dart' as http;
import 'dart:convert';
import 'token_storage_service.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000';
  final TokenStorageService _tokenStorage = TokenStorageService();

  Future<Map<String, dynamic>> post(
    String endpoint, {
    required Map<String, dynamic> body,
    bool requiresAuth = false,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
      };

      if (requiresAuth) {
        final token = await _tokenStorage.getAccessToken();
        if (token != null) {
          headers['Authorization'] = 'Bearer $token';
        }
      }

      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(
          errorBody['message'] ?? 'Request failed with status ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    bool requiresAuth = true,
  }) async {
    try {
      final headers = <String, String>{};

      if (requiresAuth) {
        final token = await _tokenStorage.getAccessToken();
        if (token != null) {
          headers['Authorization'] = 'Bearer $token';
        }
      }

      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Request failed with status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> clearAuthToken() async {
    await _tokenStorage.clearAccessToken();
  }

  Future<void> saveAuthToken(String token) async {
    await _tokenStorage.saveAccessToken(token);
  }
}
