import 'package:flutter_tasks/domain/model/weather_model.dart';
import 'package:flutter_tasks/domain/repository/weather_repository.dart';

class GetWeatherUseCase {
  final WeatherRepository _repository;

  GetWeatherUseCase(this._repository);

  Future<WeatherModel> call(String latitude, double longitude) async {
    return await _repository.getWeather(latitude, longitude);
  }
}
