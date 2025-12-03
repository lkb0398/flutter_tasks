import 'package:flutter_tasks/domain/model/weather_model.dart';
import 'package:flutter_tasks/domain/repository/weather_repository.dart';
import 'package:flutter_tasks/data/datasource/weather_remote_datasource.dart';

class WeatherRepositoryImp implements WeatherRepository {
  final WeatherRemoteDataSource _dataSource;

  WeatherRepositoryImp({WeatherRemoteDataSource? dataSource})
    : _dataSource = dataSource ?? WeatherRemoteDataSourceImpl();

  @override
  Future<WeatherModel> getWeather(String latitude, double longitude) async {
    final data = await _dataSource.getWeather(latitude, longitude);
    return WeatherModel.fromJson(data);
  }
}
