import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/utils/http_sql.dart';

part 'tv_model.freezed.dart';

part 'tv_model.g.dart';

@freezed
class ModelRow with _$ModelRow {
  const factory ModelRow({
    required String? line,
    required String? brand,
    required String? Model,
    required String? t1030,
    required String? t1230,
    required String? t1530,
    required String? t1730,
    required String? Ext,
    required String? Total,
    required String? Past,
    required String? Plan,
    required String? Prod,
    required String? Magaz,
  }) = _ModelRow;

  factory ModelRow.fromJson(Map<String, Object?> json) =>
      _$ModelRowFromJson(json);
}

class TVModel {
  final streamController = StreamController<List<ModelRow>>();
  final List<ModelRow> rows = [];

  TVModel() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      HttpSqlQuery.getStringT(type: 'damp&ftp=2023').then((value) {
        List<dynamic> l = jsonDecode(value);
        if (kDebugMode) {
          print(l);
        }
        rows.clear();
        for (var e in l) {
          rows.add(ModelRow(line: e['line'] ?? '',
              brand: e['brand'] ?? '',
              Model: e['Model'] ?? '',
              t1030: e['10:30'] ?? '',
              t1230: e['12:30'] ?? '',
              t1530: e['15:30'] ?? '',
              t1730: e['17:30'] ?? '',
              Ext: e['Ext'] ?? '',
              Total: e['Total'] ?? '',
              Past: e['Past'] ?? '',
              Plan: e['Plan'] ?? '',
              Prod: e['Prod'] ?? '',
              Magaz: e['Magaz'] ?? ''));
        }
        streamController.add(rows);
      });
    });
  }
}