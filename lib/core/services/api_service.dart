import 'dart:convert';
import 'package:cineflow/core/secrets/secrets_data.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseUrl = SecretsData.baseUrl;

  static Future<dynamic> apiGet(String url) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$url'));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw 'Error in getting release movies with status ${response.statusCode}';
      }
    } catch (e) {
      throw 'Error $e';
    }
  }
}
