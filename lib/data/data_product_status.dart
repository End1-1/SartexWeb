import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/utils/translator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'data_product_status.freezed.dart';

part 'data_product_status.g.dart';

@freezed
class ProductStatus with _$ProductStatus {
  const factory ProductStatus(
      {required String id,
      required String branch,
      required String checkStatus,
      required String prod_status}) = _ProductStatus;

  factory ProductStatus.fromJson(Map<String, dynamic> json) =>
      _$ProductStatusFromJson(json);
}

@freezed
class ProductStatusList with _$ProductStatusList {
  const factory ProductStatusList(
      {required List<ProductStatus> productStatuses}) = _ProductStatusList;

  factory ProductStatusList.fromJson(Map<String, dynamic> json) =>
      _$ProductStatusListFromJson(json);
}

class ProductStatusDatasource extends SartexDataGridSource {
  ProductStatusDatasource() {
    addColumn(L.tr('Id'));
    addColumn(L.tr('Branch'));
    addColumn(L.tr('Check status'));
    addColumn(L.tr('Prod status'));
  }

  @override
  void addRows(List d) {
    ProductStatusList ps = ProductStatusList.fromJson({'productStatuses': d});
    rows.addAll(ps.productStatuses.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e.id),
        DataGridCell(columnName: columnNames[i++], value: e.branch),
        DataGridCell(columnName: columnNames[i++], value: e.checkStatus),
        DataGridCell(columnName: columnNames[i++], value: e.prod_status),
      ]);
    }));
  }
}
