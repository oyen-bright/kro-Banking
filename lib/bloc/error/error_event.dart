part of 'error_bloc.dart';

@freezed
class ErrorEvent with _$ErrorEvent {
  const factory ErrorEvent.showError(
    String message, {
    @Default(NotificationType.notify) NotificationType type,
  }) = _ShowError;
}
