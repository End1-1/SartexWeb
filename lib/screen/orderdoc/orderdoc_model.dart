import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sartex/screen/patver_data/order_row.dart';

import '../../utils/text_editing_controller.dart';

class OrderDocModel {
  final Map<String, String> modelList = {};
  final Map<String, String> sizesList = {};
  final List<String> sizesOfModel = [];

  OrderDocModel() {

  }

  String? _orderId;

  String? get orderId => _orderId ?? '';

  set orderId(x) => _orderId = x;

  late OrderRowDatasource datasource;

  int rowEditMode = -1;
  final List<OrderRow> details = [];

  final TextEditingController orderIdController = TextEditingController();
  final TextEditingController dateCreateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController dateForController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController executorController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController brandController = STextEditingController();
  final TextEditingController modelController = STextEditingController();
  final TextEditingController modelCodeController = STextEditingController();
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
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  void countTotalOfDetailsRow(int r) {
    OrderRow or = details[r];
    double total = (double.tryParse(or.Size01!) ?? 0) +
        (double.tryParse(or.Size02!) ?? 0) +
        (double.tryParse(or.Size03!) ?? 0) +
        (double.tryParse(or.Size04!) ?? 0) +
        (double.tryParse(or.Size05!) ?? 0) +
        (double.tryParse(or.Size06!) ?? 0) +
        (double.tryParse(or.Size07!) ?? 0) +
        (double.tryParse(or.Size08!) ?? 0) +
        (double.tryParse(or.Size09!) ?? 0) +
        (double.tryParse(or.Size10!) ?? 0) +
        (double.tryParse(or.Size11!) ?? 0) +
        (double.tryParse(or.Size12!) ?? 0);
    details[r] = or.copyWith(Total: '$total');
  }
}
