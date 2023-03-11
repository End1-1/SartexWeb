import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'data_product_status.freezed.dart';
part 'data_product_status.g.dart';

@freezed
class ProductStatus with _$ProductStatus {
  const factory ProductStatus (
  {
    required String id,
    required String branch,
    required String checkStatus,
    required String prod_status
}
      ) = _ProductStatus;

  factory ProductStatus.fromJson(Map<String,dynamic> json) => _$ProductStatusFromJson(json);
}

@freezed
class ProductStatusList with _$ProductStatusList {
  const factory ProductStatusList({required List<ProductStatus> productStatuses}) = _ProductStatusList;
  factory ProductStatusList.fromJson(Map<String,dynamic> json) => _$ProductStatusListFromJson(json);
}

class ProductStatusDatasource extends SartexDataGridSource {
  ProductStatusDatasource({required super.context, required List<ProductStatus> productStatuses}) {
    addRows(productStatuses);
    addColumn('edit', 'Edit', 100);
    addColumn('id', 'Id', 40);
    addColumn('branch', 'Branch', 100);
    addColumn('checkStatus', 'Check status', 200);
    addColumn('prod_status', 'Prod status', 200);
  }

  @override
  void addRows(List d) {
    data.addAll(d);
    rows.addAll(d.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell(columnName: 'editdata', value: e.id),
      DataGridCell(columnName: 'id', value: e.id),
      DataGridCell(columnName: 'branch', value: e.branch),
      DataGridCell(columnName: 'checkStatus', value: e.checkStatus),
      DataGridCell(columnName: 'prod_status', value: e.prod_status),
    ])));
  }

}