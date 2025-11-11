import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_tasks/data/model/weather_model.dart';

class WeatherRepository {
  static const String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<WeatherModel> getWeather(double latitude, double longitude) async {
    final uri = Uri.parse(
      '$_baseUrl?latitude=$latitude&longitude=$longitude'
      '&timezone=auto&current=temperature_2m,is_day,wind_speed_10m,weather_code',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final current = jsonData['current'] as Map<String, dynamic>;
      
      return WeatherModel.fromJson(current);
    } else {
      throw Exception('Failed to load weather: ${response.statusCode}');
    }
  }
}

