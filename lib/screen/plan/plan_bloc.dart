import 'package:bloc/bloc.dart';
import 'package:sartex/screen/plan/plan_model.dart';

abstract class PlanState {}

class PlanSRefresh extends PlanState {
  final PlanModel? planModel;
  PlanSRefresh(this.planModel) ;
}
abstract class PlanEvent {}

class PlanERefresh extends PlanEvent {
  final PlanModel? planModel;
  PlanERefresh(this.planModel);
}

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc(super.initialState) {
    on<PlanERefresh>((event, emit) => refresh(event));
    print("PLANBLOC CREATED");
  }

  void refresh(PlanERefresh p) async {
    if (p.planModel == null) {
      emit(PlanSRefresh(p.planModel));
      return;
    }
    await p.planModel!.open();
    await p.planModel!.loadQty();
    emit(PlanSRefresh(p.planModel));
  }

}