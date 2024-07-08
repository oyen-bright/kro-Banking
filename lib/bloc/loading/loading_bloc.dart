import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'loading_bloc.freezed.dart';
part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(const LoadingState.initial()) {
    on<_Loading>(_onLoading);
    on<_Loaded>(_onLoaded);
  }

  void _onLoading(_Loading event, Emitter<LoadingState> emit) {
    emit(LoadingState.loading(
      message: event.message,
      action1: event.action1,
      action2: event.action2,
    ));
  }

  void _onLoaded(_Loaded event, Emitter<LoadingState> emit) {
    emit(const LoadingState.initial());
  }
}
