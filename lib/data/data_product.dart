import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../utils/consts.dart';
import '../utils/prefs.dart';

part 'data_product.freezed.dart';
part 'data_product.g.dart';

@freezed
class Product with _$Product {
  const factory Product(
      {required String id,
      required String? branch,
        required String? brand,
      required String? model,
      required String? modelCode,
        required String? size_standart,
        required String? Packaging,
        required String? ProductsTypeCode,
        required String? Netto,
        required String? Brutto}) = _Product;

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
    addColumn('edit');
    addColumn('Id');
    addColumn('Branch');
    addColumn('Brand');
    addColumn('Model',);
    addColumn('ModelCode');
    addColumn('Standart');
    addColumn('Products type code');
    addColumn('Netto');
    addColumn('Brutto');
  }

  @override
  void addRows(List d) {
    data.addAll(d);
    rows.addAll(d.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell(columnName: 'editdata', value: e.id),
      DataGridCell(columnName: 'id', value: e.id),
      DataGridCell(columnName: 'branch', value: e.branch),
      DataGridCell(columnName: 'brand', value: e.brand),
      DataGridCell(columnName: 'model', value: e.model),
      DataGridCell(columnName: 'modelCode', value: e.modelCode),
      DataGridCell(columnName: 'size_standart', value: e.size_standart),
      DataGridCell(columnName: 'productstypecode', value: e.ProductsTypeCode),
      DataGridCell(columnName: 'Netto', value: e.Netto),
      DataGridCell(columnName: 'Brutto', value: e.Brutto)
    ])));
  }

  @override
  Widget getEditWidget(String id) {
    if (id.isEmpty) {
      return ProductEditWidget(product: const Product(id: '',
          branch: '',
          brand: '',
          model: '',
          modelCode: '',
          size_standart: '',
          ProductsTypeCode: '',
      Packaging: '',
      Netto: '',
      Brutto: '',), source: this);
    } else {
      return ProductEditWidget(product: data
          .where((e) => e.id == id)
          .first, source: this);
    }
  }
}

class ProductEditWidget extends EditWidget {
  late Product product;
  final List<String> sizes = [];
  ProductsDatasource? source;

  final TextEditingController _editBrand = TextEditingController();
  final TextEditingController _editModelCode = TextEditingController();
  final TextEditingController _editModel = TextEditingController();
  final TextEditingController _editSizeStandart = TextEditingController();
  final TextEditingController _editPackaging = TextEditingController();
  final TextEditingController _editProductsTypeCode = TextEditingController();
  final TextEditingController _editNetto = TextEditingController();
  final TextEditingController _editBrutto = TextEditingController();

  ProductEditWidget({super.key, required this.product, required this.source}) {
    HttpSqlQuery.post({'sl':"select code from Sizes"}).then((value) {
      for (var e in value) {
        sizes.add(e['code']);
      }
    });
    _editBrand.text = product.brand ?? '';
    _editModel.text = product.model ?? '';
    _editModelCode.text = product.modelCode ?? '';
    _editSizeStandart.text = product.size_standart ?? '';
    _editPackaging.text = product.Packaging ?? '';
    _editProductsTypeCode.text = product.ProductsTypeCode ?? '';
    _editNetto.text = product.Netto ?? '';
    _editBrutto.text = product.Brutto ?? '';
  }

  @override
  void save(BuildContext context, String table, object) {
    String err = '';
    if (_editBrand.text.isEmpty) {
      err += L.tr('Select brand') + '\r\n';
    }
    if (_editModelCode.text.isEmpty) {
      err += L.tr('Select model code') + '\r\n';
    }
    if (_editSizeStandart.text.isEmpty) {
      err += L.tr('Select size standart') + '\r\n';
    }
    if (err.isNotEmpty) {
      appDialog(context, err);
      return;
    }
    product = product.copyWith(
      branch: prefs.getString(key_user_branch) ?? 'Unknown',
      brand: _editBrand.text,
      model: _editModel.text,
      modelCode: _editModelCode.text,
      size_standart: _editSizeStandart.text,
      ProductsTypeCode: _editProductsTypeCode.text,
      Packaging: _editPackaging.text,
      Netto: double.tryParse(_editNetto.text)?.toString() ?? '0',
      Brutto: double.tryParse(_editBrutto.text)?.toString() ?? '0' ,
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
            textFieldColumn(context: context, title: 'Brand', textEditingController: _editBrand),
            textFieldColumn(context: context, title: 'Model', textEditingController: _editModel),
            textFieldColumn(context: context, title: 'Model code', textEditingController: _editModelCode),
          ]),
          Row(children: [
            textFieldColumn(context: context, title: 'Size', textEditingController: _editSizeStandart, onTap: (){
              valueOfList(context, sizes, _editSizeStandart);
            }),
            textFieldColumn(context: context, title: 'Packaging', textEditingController: _editPackaging),
            textFieldColumn(context: context, title: 'ProductsTypeCode', textEditingController: _editProductsTypeCode),
          ]),
          Row(
            children: [
              textFieldColumn(context: context, title: 'Netto', textEditingController: _editNetto),
              textFieldColumn(context: context, title: 'Brutto', textEditingController: _editBrutto),
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
