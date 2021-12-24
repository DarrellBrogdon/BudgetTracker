import 'dart:convert';
import 'package:http/http.dart' as http;

class Categories {
  Categories();

  Future<Map<String, dynamic>> fetchCategories() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/api/1.0/categories'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load the categories');
    }
  }
}
