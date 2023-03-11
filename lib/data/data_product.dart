import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'data_product.freezed.dart';
part 'data_product.g.dart';

@freezed
class Product with _$Product {
  const factory Product(
      {required String id,
      required String branch,
      required String country,
      required String model,
      required String modelCode,
      required String name,
      required String size_standart,
      required String type}) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
class ProductList with _$ProductList {
  const factory ProductList({
    required List<Product> products
}) = _ProductList;

  factory ProductList.fromJson(Map<String, dynamic> json) => _$ProductListFromJson(json);
}

class ProductsDatasource extends SartexDataGridSource {
  ProductsDatasource({required super.context, required List<Product> productData}) {
    addRows(productData);
    addColumn('edit', 'Edit', 100);
    addColumn('id', 'Id', 40);
    addColumn('branch', 'Branch', 100);
    addColumn('country', 'Country', 200);
    addColumn('model', 'Model', 200);
    addColumn('modelCode', 'ModelCode', 200);
    addColumn('name', 'Name', 200);
    addColumn('size_standart', 'Standart', 200);
    addColumn('type', 'Type', 200);
  }

  @override
  void addRows(List d) {
    data.addAll(d);
    rows.addAll(d.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell(columnName: 'editdata', value: e.id),
      DataGridCell(columnName: 'id', value: e.id),
      DataGridCell(columnName: 'branch', value: e.branch),
      DataGridCell(columnName: 'country', value: e.country),
      DataGridCell(columnName: 'model', value: e.model),
      DataGridCell(columnName: 'modelCode', value: e.modelCode),
      DataGridCell(columnName: 'name', value: e.name),
      DataGridCell(columnName: 'size_standart', value: e.size_standart),
      DataGridCell(columnName: 'type', value: e.type),
    ])));
  }

}
