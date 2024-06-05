import 'package:bloc_tutorial_app/visibility_bloc/visibility_event.dart';
import 'package:bloc_tutorial_app/visibility_bloc/visibility_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisibilityBloc extends Bloc<VisibilityEvent, VisibilityState> {
  VisibilityBloc() : super(VisibilityState(show: true)) {
    on<VisibilityShowEvent>((event, emit) => emit(VisibilityState(show: true)));
    on<VisibilityHideEvent>(
        (event, emit) => emit(VisibilityState(show: false)));
  }
}
