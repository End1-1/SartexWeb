import 'package:sartex/data/sartex_datagridsource.dart';

class DashboardModel<T> {
  late T datasource;

  DashboardModel(T t) {
    datasource = t;
  }
}