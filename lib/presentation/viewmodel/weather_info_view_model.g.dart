// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_info_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(weatherRepository)
const weatherRepositoryProvider = WeatherRepositoryProvider._();

final class WeatherRepositoryProvider
    extends
        $FunctionalProvider<
          WeatherRepositoryImp,
          WeatherRepositoryImp,
          WeatherRepositoryImp
        >
    with $Provider<WeatherRepositoryImp> {
  const WeatherRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weatherRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weatherRepositoryHash();

  @$internal
  @override
  $ProviderElement<WeatherRepositoryImp> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WeatherRepositoryImp create(Ref ref) {
    return weatherRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeatherRepositoryImp value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeatherRepositoryImp>(value),
    );
  }
}

String _$weatherRepositoryHash() => r'eb5c196cae70c5ce7abfc447de8c3035518ee85f';

@ProviderFor(getWeatherUseCase)
const getWeatherUseCaseProvider = GetWeatherUseCaseProvider._();

final class GetWeatherUseCaseProvider
    extends
        $FunctionalProvider<
          GetWeatherUseCase,
          GetWeatherUseCase,
          GetWeatherUseCase
        >
    with $Provider<GetWeatherUseCase> {
  const GetWeatherUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getWeatherUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getWeatherUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetWeatherUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetWeatherUseCase create(Ref ref) {
    return getWeatherUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetWeatherUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetWeatherUseCase>(value),
    );
  }
}

String _$getWeatherUseCaseHash() => r'e679f8138081ae1c58e61a770e67dd08d9e2f3e5';

@ProviderFor(WeatherInfoViewModel)
const weatherInfoViewModelProvider = WeatherInfoViewModelProvider._();

final class WeatherInfoViewModelProvider
    extends $AsyncNotifierProvider<WeatherInfoViewModel, WeatherInfoState> {
  const WeatherInfoViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weatherInfoViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weatherInfoViewModelHash();

  @$internal
  @override
  WeatherInfoViewModel create() => WeatherInfoViewModel();
}

String _$weatherInfoViewModelHash() =>
    r'79470e5857175acc290fa39590f99ae37c231e29';

abstract class _$WeatherInfoViewModel extends $AsyncNotifier<WeatherInfoState> {
  FutureOr<WeatherInfoState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<WeatherInfoState>, WeatherInfoState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WeatherInfoState>, WeatherInfoState>,
              AsyncValue<WeatherInfoState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
