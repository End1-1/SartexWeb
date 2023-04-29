import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/order_row.dart';

part 'orderdoc_state.freezed.dart';

abstract class OrderDocState{}
class OrderDocStateNone extends OrderDocState {}
class OrderDocStateBrand extends OrderDocState {
  final List<String> brandList;
  OrderDocStateBrand(this.brandList);
}
class OrderDocStateModel extends OrderDocState {
  final Map<String, String> modelList;
  final Map<String, String> sizeList;
  OrderDocStateModel(this.modelList, this.sizeList);
}

class OrderDocStateSizes extends OrderDocState {
  final List<String> sizes;
  OrderDocStateSizes(this.sizes);
}
class OrderDocStateNewRow extends OrderDocState {}
class OrderDocStateLoaded extends OrderDocState {
  final List<OrderRow> details;
  OrderDocStateLoaded(this.details);
}

@freezed
class OrderDocSubRowState extends OrderDocState with _$OrderDocSubRowState {
  const factory OrderDocSubRowState({required String row}) = _OrderDocSubRowState;
}