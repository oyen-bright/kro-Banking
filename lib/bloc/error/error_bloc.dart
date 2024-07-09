import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_bloc.freezed.dart';
part 'error_event.dart';
part 'error_state.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc() : super(const ErrorState.initial()) {
    on<_ShowError>((event, emit) async {
      emit(ErrorState.errorMessage(event.message, event.type));
      await Future.delayed(const Duration(seconds: 4));
      emit(const ErrorState.initial());
    });
  }
}
