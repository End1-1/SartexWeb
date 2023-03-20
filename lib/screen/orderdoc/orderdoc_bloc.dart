import 'package:bloc/bloc.dart';

import 'orderdoc_event.dart';
import 'orderdoc_state.dart';

class OrderDocBloc extends Bloc<OrderDocEvent, OrderDocState> {
  OrderDocBloc(super.initialState) {
    on<OrderDocBrandChanged> ((event, emit) => emit(OrderDocStateBrand()));
    on<OrderDocShortChanged> ((event, emit) => emit(OrderDocStateShort()));
  }
}