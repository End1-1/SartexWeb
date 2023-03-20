import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/widgets/edit_widget.dart';
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
  ProductsDatasource({required super.context, required List data}) {
    addRows(data);
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

  @override
  Widget getEditWidget(String id) {
    if (id.isEmpty) {
      return ProductEditWidget(product: const Product(id: '',
          branch: '',
          country: '',
          model: '',
          modelCode: '',
          name: '',
          size_standart: '',
          type: ''), source: this);
    } else {
      return ProductEditWidget(product: data
          .where((e) => e.id == id)
          .first, source: this);
    }
  }
}

class ProductEditWidget extends EditWidget {
  late Product product;
  late ProductsDatasource source;

  final TextEditingController _tecContry = TextEditingController();
  final TextEditingController _tecModelCode = TextEditingController();
  final TextEditingController _tecModel = TextEditingController();
  final TextEditingController _tecName = TextEditingController();
  final TextEditingController _tecSizeStandart = TextEditingController();
  final TextEditingController _tecType = TextEditingController();

  ProductEditWidget({super.key, required this.product, required this.source}) {
    _tecContry.text = product.country;
    _tecModel.text = product.model;
    _tecModelCode.text = product.modelCode;
    _tecName.text = product.name;
    _tecSizeStandart.text = product.size_standart;
    _tecType.text = product.type;
  }

  @override
  void save(BuildContext context, String table, object) {
    product = product.copyWith(
        country: _tecContry.text,
        model: _tecModel.text,
        name: _tecName.text,
        type: _tecType.text,
        size_standart: _tecSizeStandart.text,
        modelCode: _tecModelCode.text
    );
    super.save(context, table, product);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(children: [
            textFieldColumn(context: context, title: 'Model code', textEditingController: _tecModelCode),
            textFieldColumn(context: context, title: 'Model', textEditingController: _tecModel)
          ]),
          Row(children: [
            textFieldColumn(context: context, title: 'Name', textEditingController: _tecName),
            textFieldColumn(context: context, title: 'Type', textEditingController: _tecType),
          ]),
          Row(
            children: [
              textFieldColumn(context: context, title: 'Country', textEditingController: _tecContry),
              textFieldColumn(context: context, title: 'Size', textEditingController: _tecSizeStandart)
            ],
          ),
          saveWidget(context, product)
        ]);
  }

  @override
  String getTable() {
    return 'Products';
  }

}
