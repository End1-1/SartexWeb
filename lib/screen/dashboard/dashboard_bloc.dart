import 'package:bloc/bloc.dart';
import 'package:sartex/screen/dashboard/dashboard_actions.dart';

import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardAction, DashboardState> {




  DashboardBloc(super.initialState);

  Future<void> eventToState(DashboardAction a) async {
    emit(a.state);
  }

}