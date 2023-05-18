import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/utils/translator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'datasource.freezed.dart';

part 'datasource.g.dart';

@freezed
class RemainRow with _$RemainRow {
  const factory RemainRow(
      {required String? apr_id,
      required String? branch,
        required String? pahest,
      required String? brand,
      required String? Model,
      required String? ModelCod,
        required String? country,
      required String? variant_prod,
      required String? Colore,
        required String? size,
      required String? mnacord}) = _RemainRow;

  factory RemainRow.fromJson(Map<String, dynamic> json) =>
      _$RemainRowFromJson(json);
}

class RemainsDatasource extends SartexDataGridSource {
  RemainsDatasource() {
    addColumn('edit');
    addColumn(L.tr('Branch'));
    addColumn(L.tr('Pahest'));
    addColumn(L.tr('Brand'));
    addColumn(L.tr('Model'));
    addColumn(L.tr('Code'));
    addColumn(L.tr('Country'));
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
    List<RemainRow> r = [];
    for (final e in d) {
      r.add(RemainRow.fromJson(e));
    }
    rows.addAll(r.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e.apr_id),
        DataGridCell(columnName: columnNames[i++], value: e.branch),
        DataGridCell(columnName: columnNames[i++], value: e.pahest),
        DataGridCell(columnName: columnNames[i++], value: e.brand),
        DataGridCell(columnName: columnNames[i++], value: e.Model),
        DataGridCell(columnName: columnNames[i++], value: e.ModelCod),
        DataGridCell(columnName: columnNames[i++], value: e.country),
        DataGridCell(columnName: columnNames[i++], value: e.variant_prod),
        DataGridCell(columnName: columnNames[i++], value: e.Colore),
        DataGridCell(columnName: columnNames[i++], value: e.size),
        DataGridCell(columnName: columnNames[i++], value: double.tryParse(e.mnacord ?? '0') ?? 0),
      ]);
    }));
  }
}
