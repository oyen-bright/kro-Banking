part of 'error_bloc.dart';

@freezed
class ErrorState with _$ErrorState {
  const factory ErrorState.initial() = _ErrorInitial;
  const factory ErrorState.errorMessage(String message) = _ErrorMessage;
}
