import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';

part 'tv_model.freezed.dart';

part 'tv_model.g.dart';

@freezed
class ModelRow with _$ModelRow {
  const factory ModelRow(
      {required String? line,
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
      required String? Pref}) = _ModelRow;

  factory ModelRow.fromJson(Map<String, Object?> json) =>
      _$ModelRowFromJson(json);
}

class TVModel {
  final streamController = StreamController<List<ModelRow>>();
  final List<ModelRow> rows = [];
  var page = true;
  var pageNum = 0;
  int pageNumCount = 0;
  var totalRow = const ModelRow(
      line: '',
      brand: '',
      Model: '',
      t1030: '',
      t1230: '',
      t1530: '',
      t1730: '',
      Ext: '',
      Total: '',
      Past: '',
      Plan: '',
      Prod: '',
      Magaz: '',
      Pref: '');

  TVModel() {
    _refreshData();
    Timer.periodic(const Duration(seconds: 60), (timer) {
      _refreshData();
    });
    // Timer.periodic(const Duration(seconds: 10), (timer) {
    //   _showData();
    // });
  }

  setPageNumber(int num) {
    pageNum = num;
    prefs.setInt(key_page_number, pageNum);
    _showData();
  }

  _showData() {
    if (pageNum == 0) {
      streamController.add(rows);
      return;
    }
    pageNumCount = prefs.getInt(key_tv_page_count)!;
    final List<ModelRow> r = [];
    for (int i = 0; i < rows.length; i++) {
      int num = int.tryParse(rows[i].line!.substring(1, rows[i].line!.length)) ?? 0;
      if (num > (pageNum - 1) * pageNumCount && num <= (((pageNum - 1) * pageNumCount) + pageNumCount)) {
        r.add(rows[i]);
      }
    }
    streamController.add(r);
  }

  void _refreshData() {
    HttpSqlQuery.getStringT(type: 'damptv&ftp=2023').then((value) {
      List<dynamic> l = jsonDecode(value);
      if (kDebugMode) {
        print(l);
      }
      rows.clear();
      int t10 = 0,
          t12 = 0,
          t15 = 0,
          t17 = 0,
          tt = 0,
          text = 0,
          tplan = 0,
          tpast = 0,
          tprod = 0,
          tmagaz = 0;
      for (var e in l) {
        t10 += int.tryParse(e['10:30'] ?? '') ?? 0;
        t12 += int.tryParse(e['12:30'] ?? '') ?? 0;
        t15 += int.tryParse(e['15:30'] ?? '') ?? 0;
        t17 += int.tryParse(e['17:30'] ?? '') ?? 0;
        text += int.tryParse(e['Ext'] ?? '') ?? 0;
        tplan += int.tryParse(e['Plan'] ?? '') ?? 0;
        tpast += int.tryParse(e['Past'] ?? '') ?? 0;
        tprod += int.tryParse(e['Prod'] ?? '') ?? 0;
        tt += int.tryParse(e['Total'] ?? '') ?? 0;
        tmagaz += int.tryParse(e['Magaz'] ?? '') ?? 0;

        rows.add(ModelRow(
            line: e['line'] ?? '',
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
            Magaz: e['Magaz'] ?? '',
            Pref: e['PERF(%)'] ?? ''));
      }
      totalRow = ModelRow(
          line: '',
          brand: '',
          Model: '',
          t1030: t10.toString(),
          t1230: t12.toString(),
          t1530: t15.toString(),
          t1730: t17.toString(),
          Ext: text.toString(),
          Total: tt.toString(),
          Past: tpast.toString(),
          Plan: tplan.toString(),
          Prod: tprod.toString(),
          Magaz: tmagaz.toString(),
          Pref: (tplan == 0 ? 0 : (tprod / (tplan) * 100)).truncate().toString());

      pageNumCount = (prefs.getInt(key_tv_page_count) ?? 0) == 0 ? 8 : 12;
      pageNum = prefs.getInt(key_page_number) ?? 1;
      _showData();
      // for (int i = 0; i < 7; i++)
      //   rows.add(ModelRow(line: 'L${i+1}', brand: 'BRNAD', Model: 'MODEL', t1030: '1', t1230: '2', t1530: '3', t1730: '4', Ext: '5', Total: '6', Past: '8', Plan: '7', Prod: '8', Magaz: '7', Pref: '7'));
    });

  }
}
