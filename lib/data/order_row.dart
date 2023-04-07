import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/screen/orderdoc/orderdoc_screen.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
part 'order_row.freezed.dart';
part 'order_row.g.dart';

@freezed
class OrderRow with _$OrderRow {
  const factory OrderRow({
  required String? main,
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
    required String? Total,
    required String? discarded,
    required String? appended
}) = _OrderRow;
  factory OrderRow.fromJson(Map<String, dynamic> json) => _$OrderRowFromJson(json);
}

@freezed
class OrderRowList with _$OrderRowList {
  const factory OrderRowList({required List<OrderRow> list}) = _OrderRowList;
  factory OrderRowList.fromJson(Map<String, dynamic> json) => _$OrderRowListFromJson(json);
}

class OrderRowDatasource extends SartexDataGridSource {
  late List<String> executors;
  late List<String> brands;
  final Map<String, List<String>> codeAndSizeList = {};
  final Map<String, List<String>> modelList = {};
  final Map<String, List<String>> sizesOfModel = {};

  OrderRowDatasource({required super.context, required List data}) {
    addRows(data);
    addColumn('edit', 'Edit', 100);
    addColumn('id', 'Id', 60);
    addColumn('date', 'Date', 100);
    addColumn('patvern', 'NN', 100);
    addColumn('patviratu', 'Customer', 120);
    addColumn('brand', 'Brand', 100);
    addColumn('model', 'Model', 100);
    addColumn('modelcod', 'Model code', 100);
    addColumn('executor', 'Executor', 110);
    addColumn('+', '+', 50);
    addColumn('-', '-', 50);
    addColumn('-', 'Total', 110);
    addColumn('executed', 'Executed', 100);
    addColumn('executed persent', 'Executed %', 100);
    addColumn('remain', 'Remain', 100);
    addColumn('nextload', 'Next loading', 100);
    addColumn('execmust', 'Need execute', 100);
    addColumn('execdate', 'Execute date', 100);
    addColumn('status', 'Status', 100);
    HttpSqlQuery.listOfQuery("select name from Parthners where type='Արտադրող'").then((value) => executors = value);
    HttpSqlQuery.listDistinctOf('Products', 'brand');
    HttpSqlQuery.get('select brand, model, modelCode,  size_standart  from Products').then((value) => value.forEach((e) {
      if (!modelList.containsKey(e['brand'])) {
        modelList[e['brand']] = [];
      }
      modelList[e['brand']]!.add(e['model']);
      codeAndSizeList[e['model']] = [e['modelCode'], e['size_standart']];
    }));
    HttpSqlQuery.get('select * from Sizes').then((value) => value.forEach((e) {
      sizesOfModel[e['code']] = [e['size01'], e['size02'], e['size03'], e['size04'], e['size05'], e['size06'], e['size07'], e['size08'], e['size09'], e['size10']];
    }));
  }

  @override
  void addRows(List d) {
    data.addAll(d);
    rows.addAll(d.map<DataGridRow>((e) => DataGridRow(cells: [
        DataGridCell(columnName: 'editdata', value: e.IDPatver),
        DataGridCell(columnName: 'id', value: e.id),
        DataGridCell(columnName: 'date', value: e.date),
        DataGridCell(columnName: 'patvern', value: e.PatverN),
        DataGridCell(columnName: 'patviratu', value: e.Patviratu),
        DataGridCell(columnName: 'brand', value: e.brand),
        DataGridCell(columnName: 'model', value: e.Model),
        DataGridCell(columnName: 'modelcod', value: e.ModelCod),
        DataGridCell(columnName: 'executor', value: e.Katarox),
        DataGridCell(columnName: '+', value: e.appended),
        DataGridCell(columnName: '-', value: e.discarded),
        DataGridCell(columnName: 'total', value: e.Total),
        DataGridCell(columnName: 'executed', value: 'HARCNEL'),
        DataGridCell(columnName: 'executed percent', value: 'HARCNEL'),
        DataGridCell(columnName: 'Remain', value: 'HARCNEL'),
        DataGridCell(columnName: 'nextload', value: 'HARC'),
        DataGridCell(columnName: 'execmust', value: 'HARC'),
        DataGridCell(columnName: 'execdata', value: e.PatverDate),
        DataGridCell(columnName: 'status', value: e.status),
    ])));
  }

  @override
  Widget getEditWidget(String id) {
    return OrderDocScreen(orderId: id, datasource: this);
  }
}