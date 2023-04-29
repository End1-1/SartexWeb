import 'package:freezed_annotation/freezed_annotation.dart';

part 'orderdoc_event.freezed.dart';

abstract class OrderDocEvent {}
class OrderDocEventIdle extends OrderDocEvent{}
class OrderDocBrandChanged extends OrderDocEvent {
  final String brand;
  OrderDocBrandChanged(this.brand);
}
class OrderDocModelChanged extends OrderDocEvent {
  final String size;
  OrderDocModelChanged(this.size);
}
class OrderDocNewRow extends OrderDocEvent {}
class OrderDocEventOpen extends OrderDocEvent {
  final String id;
  OrderDocEventOpen(this.id);
}

@freezed
class OrderDocSubRow extends OrderDocEvent with _$OrderDocSubRow {
  const factory OrderDocSubRow({required String row}) = _OrderDocSubRow;
}