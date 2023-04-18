import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:async';

import 'package:intl/intl.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/text_editing_controller.dart';

part 'plan_model.freezed.dart';
part 'plan_model.g.dart';

@freezed
class PlanRow with _$PlanRow {
  factory PlanRow({
    required String? remain,
    required String? brand,
    required String? model,
    required String? mo,
    required String? to,
    required String? we,
    required String? th,
    required String? fr,
    required String? sa,
    required String? su,
    required String? tot
}) = _PlanRow;
  factory PlanRow.fromJson(Map<String, Object?> json) => _$PlanRowFromJson(json);
}

class PlanRowEdit {
  final editRemain = STextEditingController();
  final editBrand = STextEditingController();
  final editModel = STextEditingController();
  final editMo = STextEditingController();
  final editTo = STextEditingController();
  final editWe = STextEditingController();
  final editTh = STextEditingController();
  final editFr = STextEditingController();
  final editSa = STextEditingController();
  final editSu = STextEditingController();
  final editTot = STextEditingController();
}


class PlanModel {
  final dateRangeController = StreamController();
  final tableHeaderController = StreamController();
  final tableDataController = StreamController();
  DateTime date = DateTime.now();
  final List<String> lines = [];
  final Map<String, List<PlanRowEdit>> linesData = {};
  final Map<String, List<String>> brandModel = {};

  PlanModel() {
    for (int i = 0; i < 16; i++) {
      lines.add('L${i + 1}');
    }
    for (var l in lines) {
      linesData[l] = [];
    }
    HttpSqlQuery.post({'sl': "select brand, model from Products"}).then((value) {
      for (var e in value) {
        if (!brandModel.containsKey(e['brand'])) {
          brandModel[e['brand']] = [];
        }
        brandModel[e['brand']]!.add(e['model']);
      }
    });
  }

  String weekRange() {
    int d = date.weekday;
    DateTime firstDate = date.add(Duration(days: -1 * (d - 1)));
    DateTime endDate = date.add(Duration(days: 7 - d));
    return '${DateFormat('dd/MM/yyyy').format(firstDate)} - ${DateFormat('dd/MM/yyyy').format(endDate)}';
  }

  String dayOfRange(int i) {
    int d = date.weekday - 1;
    return '${DateFormat('dd/MM').format(date.add(Duration(days: -1 * (d + i))))}';
  }
}