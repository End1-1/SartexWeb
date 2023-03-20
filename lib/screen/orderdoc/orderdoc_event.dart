abstract class OrderDocEvent {}
class OrderDocEventIdel{}
class OrderDocBrandChanged extends OrderDocEvent {}
class OrderDocShortChanged extends OrderDocEvent {}
class OrderDocNewRow extends OrderDocEvent {}
class OrderDocLoaded extends OrderDocEvent {}