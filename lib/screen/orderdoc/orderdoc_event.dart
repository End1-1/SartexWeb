import 'package:freezed_annotation/freezed_annotation.dart';

part 'orderdoc_event.freezed.dart';

abstract class OrderDocEvent {}
class OrderDocEventIdel{}
class OrderDocBrandChanged extends OrderDocEvent {}
class OrderDocModelChanged extends OrderDocEvent {}
class OrderDocNewRow extends OrderDocEvent {}
class OrderDocLoaded extends OrderDocEvent {}

@freezed
class OrderDocSubRow extends OrderDocEvent with _$OrderDocSubRow {
  const factory OrderDocSubRow({required String row}) = _OrderDocSubRow;
}