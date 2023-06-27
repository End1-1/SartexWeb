import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/data/sql.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:sartex/widgets/form_field.dart';
import 'package:sartex/widgets/key_value_dropdown.dart';
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
      required String? productTypeName,
      required String? Netto,
      required String? Brutto}) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
class ProductList with _$ProductList {
  const factory ProductList({required List<Product> products}) = _ProductList;

  factory ProductList.fromJson(Map<String, dynamic> json) =>
      _$ProductListFromJson(json);
}

class ProductsDatasource extends SartexDataGridSource {
  ProductsDatasource() {
    addColumn(L.tr('Id'));
    addColumn(L.tr('Branch'));
    addColumn(L.tr('Brand'));
    addColumn(L.tr('Model'));
    addColumn(L.tr('ModelCode'));
    addColumn(L.tr('Standart'));
    addColumn(L.tr('Packaging'));
    addColumn(L.tr('Products type code'));
    addColumn(L.tr('Products type name'));
    addColumn(L.tr('Netto'));
    addColumn(L.tr('Brutto'));
  }

  @override
  void addRows(List d) {
    ProductList pl = ProductList.fromJson({'products': d});
    rows.addAll(pl.products.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e.id),
        DataGridCell(columnName: columnNames[i++], value: e.branch),
        DataGridCell(columnName: columnNames[i++], value: e.brand),
        DataGridCell(columnName: columnNames[i++], value: e.model),
        DataGridCell(columnName: columnNames[i++], value: e.modelCode),
        DataGridCell(columnName: columnNames[i++], value: e.size_standart),
        DataGridCell(columnName: columnNames[i++], value: e.Packaging),
        DataGridCell(columnName: columnNames[i++], value: e.ProductsTypeCode),
        DataGridCell(columnName: columnNames[i++], value: e.productTypeName),
        DataGridCell(columnName: columnNames[i++], value: e.Netto),
        DataGridCell(columnName: columnNames[i++], value: e.Brutto)
      ]);
    }));
  }

  @override
  Widget getEditWidget(BuildContext context, String id) {
    return ProductEditWidget(id: id, brand: '', model: '');

  }
}

class ProductEditWidget extends EditWidget {
  final productTypeController = StreamController();
  Product product = const Product(
      id: '',
      branch: '',
      brand: '',
      model: '',
      modelCode: '',
      size_standart: '',
      Packaging: '',
      ProductsTypeCode: '',
      productTypeName: '',
      Netto: '',
      Brutto: '');
  List<String> sizes = [];
  Map<String, String> productTypeCode = {};

  final TextEditingController _editBrand = TextEditingController();
  final TextEditingController _editModelCode = TextEditingController();
  final TextEditingController _editModel = TextEditingController();
  final TextEditingController _editSizeStandart = TextEditingController();
  final TextEditingController _editPackaging = TextEditingController();
  final TextEditingController _editProductsTypeCode = TextEditingController();
  final TextEditingController _editNetto = TextEditingController();
  final TextEditingController _editBrutto = TextEditingController();

  ProductEditWidget({super.key, required String id, required String brand,  required String model}) {
    _editBrand.text = brand;
    _editModel.text = model;
    HttpSqlQuery.post({'sl': "select code from Sizes"}).then((value) {
      for (var e in value) {
        sizes.add(e['code']);
      }
      HttpSqlQuery.post({'sl': "select id, name from ProductTypeCode"})
          .then((value) {
        for (final e in value) {
          productTypeCode[e['id']] = e['name'];
        }
        productTypeController.add(null);
        if (id.isNotEmpty) {
          HttpSqlQuery.post({'sl': "select * from Products where id=${id}"})
              .then((value) {
            product = Product.fromJson(value[0]);
            _editBrand.text = product.brand ?? '';
            _editModel.text = product.model ?? '';
            _editModelCode.text = product.modelCode ?? '';
            _editSizeStandart.text = product.size_standart ?? '';
            _editPackaging.text = product.Packaging ?? '';
            _editProductsTypeCode.text = productTypeCode[ product.ProductsTypeCode] ?? '';
            _editNetto.text = product.Netto ?? '';
            _editBrutto.text = product.Brutto ?? '';
            productTypeController.add(null);
          });
        }
      });
    });
  }

  @override
  void save(BuildContext context, String table, object) async {
    String err = '';
    if (_editBrand.text.isEmpty) {
      err += '${L.tr('Select brand')}\r\n';
    }
    if (_editModelCode.text.isEmpty) {
      err += '${L.tr('Select model code')}\r\n';
    }
    if (_editSizeStandart.text.isEmpty) {
      err += '${L.tr('Select size standart')}\r\n';
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
      ProductsTypeCode: productTypeCode.keys.firstWhere((element) => productTypeCode[element] ==  _editProductsTypeCode.text),
      Packaging: _editPackaging.text,
      Netto: double.tryParse(_editNetto.text)?.toString() ?? '0',
      Brutto: double.tryParse(_editBrutto.text)?.toString() ?? '0',
    );

    String sql;
    Map<String, dynamic> json = product.toJson();
    json.remove("productTypeName");
    if (product.id.isEmpty) {
      json.remove('id');
      sql = Sql.insert(table, json);
    } else {
      sql = Sql.update(table, json);
    }
    await HttpSqlQuery.post({'sl': sql});
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(children: [
            textFieldColumn(
                context: context,
                title: 'Brand',
                textEditingController: _editBrand),
            textFieldColumn(
                context: context,
                title: 'Model',
                textEditingController: _editModel),
            textFieldColumn(
                context: context,
                title: 'Model code',
                textEditingController: _editModelCode),
          ]),
          Row(children: [
            textFieldColumn(
                context: context,
                title: 'Size',
                textEditingController: _editSizeStandart,
                onTap: () {
                  valueOfList(context, sizes, _editSizeStandart);
                }),
            textFieldColumn(
                context: context,
                title: 'Packaging',
                textEditingController: _editPackaging,
                onTap: () {
                  valueOfList(context, ['Handlers', 'Box'], _editPackaging);
                }),
            textFieldColumn(
                context: context,
                title: 'Product type',
                textEditingController: _editProductsTypeCode,
                onTap: () {
                  valueOfList(context, productTypeCode.values.toList(), _editProductsTypeCode);
                }),
          ]),
          Row(
            children: [
              textFieldColumn(
                  context: context,
                  title: 'Netto',
                  textEditingController: _editNetto),
              textFieldColumn(
                  context: context,
                  title: 'Brutto',
                  textEditingController: _editBrutto),
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
