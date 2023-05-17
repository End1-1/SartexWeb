import 'package:flutter/material.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/utils/translator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'datasource.freezed.dart';

part 'datasource.g.dart';

@freezed
class THashivRow with _$THashivRow {
  const factory THashivRow(
      {required String? date,
      required String? input,
      required String? out}) = _THashivRow;

  factory THashivRow.fromJson(Map<String, dynamic> json) =>
      _$THashivRowFromJson(json);
}

class THashivDatasource extends SartexDataGridSource {
  THashivDatasource() {
    addColumn(L.tr('Date'));
    addColumn(L.tr('Input'));
    addColumn(L.tr('Output'));
    addColumn(L.tr('Remain'));
  }

  @override
  void addRows(List d) {
    List<THashivRow> l = [];
    for (final e in d) {
      l.add(THashivRow.fromJson(e));
    }
    double value  = 0;
    rows.addAll(l.map<DataGridRow>((e) {
      int i = 0;
      double vp = double.tryParse(e.input ?? '0') ?? 0;
      double vm = double.tryParse(e.out ?? '0') ?? 0;
      value += (vp - vm);
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e.date),
        DataGridCell(columnName: columnNames[i++], value: e.input),
        DataGridCell(columnName: columnNames[i++], value: e.out),
        DataGridCell(columnName: columnNames[i++], value: value),
      ]);
    }));
  }
}
