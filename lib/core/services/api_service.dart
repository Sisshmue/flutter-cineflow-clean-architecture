import 'dart:convert';
import 'package:cineflow/core/secrets/secrets_data.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseUrl = SecretsData.tmdbBaseUrl;

  static Future<dynamic> apiGet(String url) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$url'),
        headers: {
          'Content-Type': 'application/json',
          "Authorization":
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1M2EzYTgyNmU0ODA5OTllMmJmNzI1MjY0MThiNmVmOSIsIm5iZiI6MTc3Mjc5MzM0NS4yMDQsInN1YiI6IjY5YWFhZTAxYTIwNjU4ODk1ZDk5ODZiNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Ws6CXV9A7LoHbBg9_vKNDb4rg5hQAxTnkaWg0rS0QBM',
        },
      );
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
