import 'package:flutter_tasks/domain/model/weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherModel> getWeather(String location, double longitude);
}
