import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_tasks/domain/usecase/get_weather_usecase.dart';
import 'package:flutter_tasks/data/repository_imp/weather_repository_imp.dart';
import 'package:flutter_tasks/presentation/state/weather_info_state.dart';

part 'weather_info_view_model.g.dart';

@riverpod
WeatherRepositoryImp weatherRepository(Ref ref) {
  return WeatherRepositoryImp();
}

@riverpod
GetWeatherUseCase getWeatherUseCase(Ref ref) {
  return GetWeatherUseCase(ref.read(weatherRepositoryProvider));
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

    final useCase = ref.read(getWeatherUseCaseProvider);
    final weather = await useCase(latitude.toString(), longitude);

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
