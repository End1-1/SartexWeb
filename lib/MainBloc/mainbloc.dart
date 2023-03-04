import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:sartex/MainBloc/actions.dart';
import 'package:sartex/MainBloc/states.dart';

class MainBloc extends Bloc<MainBlocAction, SartexAppState> {

  MainBloc(super.initialState) {
    mapEventToState(BlocStartApp());
  }

  Future<void> mapEventToState(MainBlocAction event) async {
    emit(SartexAppStateLoadingData());
    await event.proccesing();
    emit(event.state);
  }

  void dispose() {}
}
