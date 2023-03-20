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

  List<String> shortCodeOf(String brand) {
    return datasource.shortCodeOfBrand[brand] ?? [];
  }
}