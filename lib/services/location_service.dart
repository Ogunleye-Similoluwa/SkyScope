import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationService {
  Future<List<Map<String, dynamic>>> searchLocation(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=10'
        ),
        headers: {'Accept': 'application/json'},
      );

      print('Search Response: ${response.body}');

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((location) => {
          'name': '${location['display_name']}',
          'lat': double.parse(location['lat']),
          'lon': double.parse(location['lon']),
        }).toList();
      } else {
        print('Search Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to search locations: ${response.statusCode}');
      }
    } catch (e) {
      print('Search Exception: $e');
      throw Exception('Failed to search locations: $e');
    }
  }
} 