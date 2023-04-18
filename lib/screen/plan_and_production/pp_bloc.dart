import 'package:bloc/bloc.dart';

abstract class PPState {}

class PPIdle extends PPState {}

class PSRefresh extends PPState {}

class PSPlanData extends PPState {}

class PSEditRow extends PPState {}

class PSLine extends PPState {
  final String line;
  final bool open;
  PSLine({required this.line, required this.open});
}

abstract class PPAction {}

class PARefresh extends PPAction {}
class PAEditRow extends PPAction {}

class PALine extends PPAction {
  final String line;
  final bool open;
  PALine({required this.line, required this.open});
}

class PAPlanData extends PPAction {}

class PPBloc extends Bloc<PPAction, PPState> {
  PPBloc(super.initialState) {
    on<PARefresh>((event, emit) => emit(PSRefresh()));
    on<PALine>((event, emit) => emit(PSLine(line: event.line, open: event.open)));
    on<PAPlanData>((event, emit) => emit(PSPlanData()));
    on<PAEditRow>((event, emit) => emit(PSEditRow()));
  }
}
