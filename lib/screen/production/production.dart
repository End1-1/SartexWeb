import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/screen/production/production_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'production.freezed.dart';

part 'production.g.dart';

@freezed
class ProductionRow with _$ProductionRow {
  const factory ProductionRow({required String DocN, required String date}) =
      _ProductionRow;

  factory ProductionRow.fromJson(Map<String, Object?> json) =>
      _$ProductionRowFromJson(json);
}

class ProductionDatasource extends SartexDataGridSource {
  ProductionDatasource({required super.context, required List? data}) {
    if (data != null) {
      addRows(data);
      addColumn('edit', 'Edit', 100);
      addColumn('date', 'Date', 120);
      addColumn('DocN', 'Doc number', 120);
    }
  }

  @override
  void addRows(List d) {
    data.addAll(d);
    rows.addAll(d.map((e) =>
        DataGridRow(cells: [DataGridCell(columnName: 'edit', value: e.DocN),
        DataGridCell(columnName: 'date', value: e.date),
        DataGridCell(columnName: 'DocN', value: e.DocN)])));
  }

  @override
  Widget getEditWidget(String id) {
    return ProductionWidget(DocN: id);
  }
}
