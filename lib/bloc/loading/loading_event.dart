part of 'loading_bloc.dart';

@freezed
abstract class LoadingEvent with _$LoadingEvent {
  const factory LoadingEvent.loading({
    String? message,
    (String, void Function(), int?)? action1,
    (String, void Function(), int?)? action2,
  }) = _Loading;
  const factory LoadingEvent.loaded() = _Loaded;
}
