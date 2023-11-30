import 'dart:convert';
import 'package:http/http.dart' as http;

class CodexApiService {
  // static const String apiUrl = 'https://api.codex.jaagrav.in';
  static const String apiUrl = 'https://codex-api.fly.dev';

  static Future<Map<String, dynamic>> compileCode(
    String code,
    String input,
  ) async {
    final url = Uri.parse(apiUrl);
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final data = {'code': code, 'language': 'c', 'input': input};
    final encodedData = Uri(queryParameters: data).query;

    try {
      final response =
          await http.post(url, headers: headers, body: encodedData);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return {
          'output': jsonResponse['output'] ?? '',
          'error': jsonResponse['error'] ?? '',
        };
      } else {
        print(response.body);
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the API: $e');
    }
  }
}
