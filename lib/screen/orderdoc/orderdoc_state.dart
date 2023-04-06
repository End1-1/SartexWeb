import 'package:freezed_annotation/freezed_annotation.dart';

part 'orderdoc_state.freezed.dart';

abstract class OrderDocState{}
class OrderDocStateNone extends OrderDocState {}
class OrderDocStateBrand extends OrderDocState {}
class OrderDocStateModel extends OrderDocState {}
class OrderDocStateNewRow extends OrderDocState {}
class OrderDocStateLoaded extends OrderDocState {}

@freezed
class OrderDocSubRowState extends OrderDocState with _$OrderDocSubRowState {
  const factory OrderDocSubRowState({required String row}) = _OrderDocSubRowState;
}