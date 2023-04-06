import 'package:bloc/bloc.dart';

import 'orderdoc_event.dart';
import 'orderdoc_state.dart';

class OrderDocBloc extends Bloc<OrderDocEvent, OrderDocState> {
  OrderDocBloc(super.initialState) {
    on<OrderDocBrandChanged> ((event, emit) => emit(OrderDocStateBrand()));
    on<OrderDocModelChanged> ((event, emit) => emit(OrderDocStateModel()));
    on<OrderDocNewRow> ((event, emit) => emit(OrderDocStateNewRow()));
    on<OrderDocLoaded> ((event, emit) => emit(OrderDocStateLoaded()));
    on<OrderDocSubRow>((event, emit) => emit(OrderDocSubRowState(row: event.row)));
  }
}