import 'package:http/http.dart' as http;
import 'dart:convert';

class ServerService {
  final String baseUrl = 'http://localhost:3000';

  Future<List<String>> fetchData() async {
    final response = await http.get(Uri.parse('$baseUrl/data'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<String>.from(data['data']);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> addData(String newData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/data'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'newData': newData}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add data');
    }
  }
}
