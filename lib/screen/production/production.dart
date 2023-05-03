import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/screen/production/production_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'production.freezed.dart';

part 'production.g.dart';

@freezed
class ProductionRow with _$ProductionRow {
  const factory ProductionRow(
      {required String DocN,
      required String date,
      required String brand,
      required String modelCod,
      required String country}) = _ProductionRow;

  factory ProductionRow.fromJson(Map<String, Object?> json) =>
      _$ProductionRowFromJson(json);
}

@freezed
class ProductionList with _$ProductionList {
  const factory ProductionList({required List<ProductionRow> list}) =
      _ProductionList;

  factory ProductionList.fromJson(Map<String, Object?> json) =>
      _$ProductionListFromJson(json);
}

class ProductionDatasource extends SartexDataGridSource {
  ProductionDatasource() {
      addColumn('edit');
      addColumn('Date');
      addColumn('Doc number');
      addColumn('Brand');
      addColumn('Model');
      addColumn('Country');
  }

  @override
  void addRows(List d) {
    rows.addAll(d.map((e) => DataGridRow(cells: [
          DataGridCell(columnName: 'editdata', value: e.DocN),
          DataGridCell(columnName: 'date', value: e.date),
          DataGridCell(columnName: 'DocN', value: e.DocN),
          DataGridCell(columnName: 'brand', value: e.brand),
          DataGridCell(columnName: 'modelCod', value: e.modelCod),
          DataGridCell(columnName: 'country', value: e.country),
        ])));
  }

  @override
  Widget getEditWidget(BuildContext context, String id) {
    return ProductionWidget(line: '');
  }
}
