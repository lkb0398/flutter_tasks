import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_tasks/data/repository/weather_repository.dart';
import 'package:flutter_tasks/data/model/weather_model.dart';

part 'weather_info_view_model.g.dart';

@riverpod
WeatherRepository weatherRepository(Ref ref) {
  return WeatherRepository();
}

@riverpod
class WeatherInfoViewModel extends _$WeatherInfoViewModel {
  @override
  Future<WeatherInfoState> build() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('위치 서비스가 비활성화되어 있습니다.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('위치 권한이 거부되었습니다.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('위치 권한이 영구적으로 거부되었습니다.');
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.best),
    );

    final latitude = position.latitude;
    final longitude = position.longitude;

    final repository = ref.read(weatherRepositoryProvider);
    final weather = await repository.getWeather(latitude, longitude);

    return WeatherInfoState(
      latitude: latitude,
      longitude: longitude,
      weather: weather,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

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
