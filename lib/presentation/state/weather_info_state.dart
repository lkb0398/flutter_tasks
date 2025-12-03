import 'package:flutter_tasks/domain/model/weather_model.dart';

class WeatherInfoState {
  final double latitude;
  final double longitude;
  final WeatherModel weather;

  WeatherInfoState({
    required this.latitude,
    required this.longitude,
    required this.weather,
  });
}
