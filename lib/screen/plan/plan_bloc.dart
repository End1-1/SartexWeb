import 'package:bloc/bloc.dart';
import 'package:sartex/screen/plan/plan_model.dart';

abstract class PlanState {}
class PlanSRefresh extends PlanState {}
abstract class PlanEvent {}
class PlanERefresh extends PlanEvent {
  final PlanModel pm;
  PlanERefresh(this.pm);
}

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc(super.initialState) {
    on<PlanERefresh>((event, emit) => refresh(event));
  }

  void refresh(PlanERefresh p) async {
    await p.pm.open();
    await p.pm.loadQty();
    emit(PlanSRefresh());
  }

}