import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sartex/data/order_row.dart';

import '../../utils/text_editing_controller.dart';
import 'orderdoc_bloc.dart';
import 'orderdoc_event.dart';


class OrderDocModel {
  OrderDocModel();

  String? _orderId;
  String? get orderId => _orderId;
  set orderId (x) {
    _orderId = x;
    if (_orderId == null) {
      return;
    }
  }

  late OrderRowDatasource datasource;

  int rowEditMode = -1;
  final List<OrderRow> details = [];

  final TextEditingController orderIdController = TextEditingController();
  final TextEditingController dateCreateController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController dateForContrller = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController customerController = TextEditingController();
  final TextEditingController executorController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController brandController = STextEditingController();
  final TextEditingController shortCodeController = STextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController sizeStandartController = TextEditingController();
  final List<TextEditingController> detailsControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  List<String> shortCodeOf(String brand) {
    return datasource.shortCodeOfBrand[brand] ?? [];
  }

  void countTotalOfDetailsRow(int r) {
    OrderRow or = details[r];
    double total
    = (double.tryParse(or.Size01!) ?? 0)
    + (double.tryParse(or.Size02!) ?? 0)
        + (double.tryParse(or.Size03!) ?? 0)
        + (double.tryParse(or.Size04!) ?? 0)
        + (double.tryParse(or.Size05!) ?? 0)
        + (double.tryParse(or.Size06!) ?? 0)
        + (double.tryParse(or.Size07!) ?? 0)
        + (double.tryParse(or.Size08!) ?? 0)
        + (double.tryParse(or.Size09!) ?? 0)
        + (double.tryParse(or.Size10!) ?? 0);
    details[r] = or.copyWith(Total: '$total');
  }
}