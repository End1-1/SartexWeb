import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/screen/production_history/production_history_edit.dart';
import 'package:sartex/utils/translator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'production_history_datasource.freezed.dart';
part 'production_history_datasource.g.dart';

@freezed
class PHistoryRec with _$PHistoryRec {
  const factory PHistoryRec({
    required String apr_id, date,
    line, commesa,
    brand, Model, variant_prod, Colore, size, qanak
}) = _PHistoryRec;
  factory PHistoryRec.fromJson(Map<String, dynamic> json) => _$PHistoryRecFromJson(json);
}

class ProductionHistoryDatasource extends SartexDataGridSource {

  ProductionHistoryDatasource() {
    addColumn(L.tr('Apr_id'));
    addColumn(L.tr('Date'));
    addColumn(L.tr('Line'));
    addColumn(L.tr('Commesa'));
    addColumn(L.tr('Brand'));
    addColumn(L.tr('Model'));
    addColumn(L.tr('Variant'));
    addColumn(L.tr('Color'));
    addColumn(L.tr('Size'));
    addColumn(L.tr('Quantity'));

    sumRows.add(GridTableSummaryRow(
        title: L.tr('Total'),
        showSummaryInRow: false,
        columns: [
          GridSummaryColumn(
              name: L.tr('Quantity'),
              columnName: L.tr('Quantity'),
              summaryType: GridSummaryType.sum)
        ], position: GridTableSummaryRowPosition.bottom));
  }

  @override
  void addRows(List d) {
    List<PHistoryRec> l = [];
    for (final e in d) {
      l.add(PHistoryRec.fromJson(e));
    }
    rows.addAll(l.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e.apr_id),
        DataGridCell(columnName: columnNames[i++], value: e.date),
        DataGridCell(columnName: columnNames[i++], value: e.line),
        DataGridCell(columnName: columnNames[i++], value: e.commesa),
        DataGridCell(columnName: columnNames[i++], value: e.brand),
        DataGridCell(columnName: columnNames[i++], value: e.Model),
        DataGridCell(columnName: columnNames[i++], value: e.variant_prod),
        DataGridCell(columnName: columnNames[i++], value: e.Colore),
        DataGridCell(columnName: columnNames[i++], value: e.size),
        DataGridCell(columnName: columnNames[i++], value: double.tryParse(e.qanak ?? '0') ?? 0),
      ]);
    }));
  }

  @override
  Widget getEditWidget(BuildContext context, String id) {
    return ProductionHistoryEditWidget(id);
  }

}