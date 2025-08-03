import 'dart:convert';

import 'package:http/http.dart' as http;

const String apiKey = '8e809ef2c7f44f55a81130516250208';

class WeatherApiService {
  final String baseUrl = 'http://api.weatherapi.com/v1';

  Future<Map<String, dynamic>> getHourlyForecast(String location) async {
    final url = Uri.parse(
      '$baseUrl/current.json?key=$apiKey&q=$location'
    );

    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception('Failed to fetch data ${res.body}');
    }
    final data = json.decode(res.body);
    if (data.containsKey('error')) {
      throw Exception('Error: ${data['error']['message'] ?? 'Invalid Location'}');
    }
    return data;    
  }
}