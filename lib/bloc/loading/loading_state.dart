part of 'loading_bloc.dart';

@freezed
abstract class LoadingState with _$LoadingState {
  const factory LoadingState.initial() = _Initial;
  const factory LoadingState.loading({
    String? message,
    (String, void Function(), int?)? action1,
    (String, void Function(), int?)? action2,
  }) = _IsLoading;
}
