part of 'error_bloc.dart';

enum NotificationType { loading, error, notify }

@freezed
class ErrorState with _$ErrorState {
  const factory ErrorState.initial() = _ErrorInitial;
  const factory ErrorState.errorMessage(String message, NotificationType type) =
      _ErrorMessage;
}
