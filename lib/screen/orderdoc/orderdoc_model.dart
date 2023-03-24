import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sartex/data/order_row.dart';
import 'package:sartex/utils/http_sql.dart';

import '../../data/sql.dart';
import '../../utils/text_editing_controller.dart';
import 'orderdoc_bloc.dart';
import 'orderdoc_event.dart';


class OrderDocModel {
  OrderDocModel();

  String? _orderId;
  String? get orderId => _orderId ?? '';
  set orderId (x) => _orderId = x;

  late OrderRowDatasource datasource;

  int rowEditMode = -1;
  final List<OrderRow> details = [];

  final TextEditingController orderIdController = TextEditingController();
  final TextEditingController dateCreateController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController dateForController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController executorController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController brandController = STextEditingController();
  final TextEditingController modelCodController = STextEditingController();
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

  Future<void> loadOrder() async {
    await HttpSqlQuery.postString({'sl' : "${Sql.sqlList['open_patver_data']} where IDPatver='$_orderId'"}).then((value) {
      OrderRowList orl = OrderRowList.fromJson({'list' : jsonDecode(value)});
      for (var e in orl.list) {
        details.add(e);
      }
    });
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