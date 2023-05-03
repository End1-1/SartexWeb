import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/screen/orderdoc/orderdoc_screen.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/translator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'order_row.freezed.dart';

part 'order_row.g.dart';

@freezed
class OrderRow with _$OrderRow {
  const factory OrderRow(
      {required String? main,
      required String id,
      required String? branch,
      required String? action,
      required String? User,
      required String? date,
      required String? IDPatver,
      required String? status,
      required String? PatverN,
      required String? PatverDate,
      required String? parent_id,
      required String? Katarox,
      required String? Patviratu,
      required String? Model,
      required String? ModelCod,
      required String? brand,
      required String? short_code,
      required String? size_standart,
      required String? country,
      required String? variant_prod,
      required String? Colore,
      required String? line,
      required String? Size01,
      required String? Size02,
      required String? Size03,
      required String? Size04,
      required String? Size05,
      required String? Size06,
      required String? Size07,
      required String? Size08,
      required String? Size09,
      required String? Size10,
      required String? Size11,
      required String? Size12,
      required String? Total,
      required String? executed,
        required String? nextload,
      required String? discarded,
      required String? appended}) = _OrderRow;

  factory OrderRow.fromJson(Map<String, dynamic> json) =>
      _$OrderRowFromJson(json);
}

@freezed
class OrderRowList with _$OrderRowList {
  const factory OrderRowList({required List<OrderRow> list}) = _OrderRowList;

  factory OrderRowList.fromJson(Map<String, dynamic> json) =>
      _$OrderRowListFromJson(json);
}

class OrderRowDatasource extends SartexDataGridSource {
  late List<String> executors;
  late List<String> brands;

  OrderRowDatasource() {
    addColumn('edit');
    addColumn(L.tr('Id'));
    addColumn(L.tr('Date'));
    addColumn(L.tr('NN'));
    addColumn(L.tr('Brand'));
    addColumn(L.tr('Model'));
    addColumn(L.tr('Model code'));
    addColumn(L.tr('Executor'));
    addColumn(L.tr('+'));
    addColumn(L.tr('-'));
    addColumn(L.tr('Total'));
    addColumn(L.tr('Exec.'));
    addColumn(L.tr('Exec. %'));
    addColumn(L.tr('Remain'));
    addColumn(L.tr('Next loading'));
    addColumn(L.tr('Need execute'));
    addColumn(L.tr('Execute date'));
    addColumn(L.tr('Status'));
    HttpSqlQuery.listOfQuery("select name from Parthners where type='Արտադրող'")
        .then((value) => executors = value);
  }

  @override
  void addRows(List d) {
    var o = OrderRowList.fromJson({'list': d});
    rows.addAll(o.list.map<DataGridRow>((e) { int i = 0;
      return DataGridRow(cells: [
          DataGridCell(columnName: columnNames[i++], value: e.IDPatver),
          DataGridCell(columnName: columnNames[i++], value: e.id),
          DataGridCell(columnName: columnNames[i++], value: e.date),
          DataGridCell(columnName: columnNames[i++], value: e.PatverN),
          DataGridCell(columnName: columnNames[i++], value: e.brand),
          DataGridCell(columnName: columnNames[i++], value: e.Model),
          DataGridCell(columnName: columnNames[i++], value: e.ModelCod),
          DataGridCell(columnName: columnNames[i++], value: e.Katarox),
          DataGridCell(columnName: columnNames[i++], value: e.appended),
          DataGridCell(columnName: columnNames[i++], value: e.discarded),
          DataGridCell(columnName: columnNames[i++], value: e.Total),
          DataGridCell(columnName: columnNames[i++], value: e.executed),
          DataGridCell(
              columnName: columnNames[i++],
              value: (double.tryParse(e.Total ?? '0') ?? 0) > 0
                  ? (((double.tryParse(e.executed ?? '0') ?? 0) /
                      (double.tryParse(e.Total ?? '0') ?? 0)) * 100).truncateToDouble()
                  : 0),
          DataGridCell(columnName: columnNames[i++], value: (double.tryParse(e.Total ?? '0') ?? 0) - (double.tryParse(e.executed ?? '0') ?? 0)),
          DataGridCell(columnName: columnNames[i++], value: e.nextload),
          DataGridCell(columnName: columnNames[i++], value: ((double.tryParse(e.Total ?? '0') ?? 0) - (double.tryParse(e.executed ?? '0') ?? 0)) - (double.tryParse(e.nextload ?? '0') ?? 0) ),
          DataGridCell(columnName: columnNames[i++], value: e.PatverDate),
          DataGridCell(columnName: columnNames[i++], value: e.status),
        ]);}));
  }

  @override
  Widget getEditWidget(BuildContext context, String id) {
    return OrderDocScreen(orderId: id, datasource: this);
  }
}
