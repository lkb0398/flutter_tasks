import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<Map<String, dynamic>> getWeather(String latitude, double longitude);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  static const String _baseUrl = 'https://api.open-meteo.com/v1/forecast';
  final http.Client _client;

  WeatherRemoteDataSourceImpl({http.Client? client})
      : _client = client ?? http.Client();

  @override
  Future<Map<String, dynamic>> getWeather(
      String latitude, double longitude) async {
    final uri = Uri.parse(
      '$_baseUrl?latitude=$latitude&longitude=$longitude'
      '&timezone=auto&current=temperature_2m,is_day,wind_speed_10m,weather_code',
    );

    final response = await _client.get(uri);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      return jsonData['current'] as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load weather: ${response.statusCode}');
    }
  }
}
