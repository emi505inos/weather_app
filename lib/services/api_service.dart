import 'dart:convert';

import 'package:flutter/material.dart';
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
  Future<List<Map<String, dynamic>>> getLastSevenDaysWeather(String location) async {
    final List<Map<String, dynamic>> weatherData = [];
    final today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      final date = today.subtract(Duration(days: i));
      final formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      final url = Uri.parse(
        '$baseUrl/history.json?key=$apiKey&q=$location&dt=$formattedDate'
      );

      final res = await http.get(url);
      if (res.statusCode != 200) {
        final data = json.decode(res.body);
        if (data.containsKey('error')) {
        throw Exception('Error: ${data['error']['message'] ?? 'Invalid Location'}');
        }
        if (data['forecast']?['forecastday'] != null) {
          weatherData.add(data);
        }
      } else {
        debugPrint('Failed to fetch data for $formattedDate: ${res.body}');
      }
    }
    return weatherData;
  }
}