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
          WeatherRepository,
          WeatherRepository,
          WeatherRepository
        >
    with $Provider<WeatherRepository> {
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
  $ProviderElement<WeatherRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WeatherRepository create(Ref ref) {
    return weatherRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeatherRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeatherRepository>(value),
    );
  }
}

String _$weatherRepositoryHash() => r'a723f7ec7ffb1c1b417661827fad4d44d500d53b';

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
    r'e0bd33ef3c15c433f020311cb4c44822e0312e6d';

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
