import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sql.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/text_editing_controller.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'product_type_code_datasource.g.dart';
part 'product_type_code_datasource.freezed.dart';

@freezed
class ProductTypeCode with _$ProductTypeCode {
  const factory ProductTypeCode({
    required String? id,
    required String? name,
    required String? atg_name
}) = _ProductTypeCode;
  factory ProductTypeCode.fromJson(Map<String, dynamic> json) => _$ProductTypeCodeFromJson(json);
}

class ProductTypeCodeDatasource extends SartexDataGridSource {

  ProductTypeCodeDatasource() {
    addColumn(L.tr('ID'));
    addColumn(L.tr('Name'));
    addColumn(L.tr('Atg name'));
  }

  @override
  void addRows(List d) {
    List<ProductTypeCode> l = [];
    for (final e in d) {
      l.add(ProductTypeCode.fromJson(e));
    }

    rows.clear();
    rows.addAll(l.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(
        cells: [
          DataGridCell(columnName: columnNames[i++], value: e.id),
          DataGridCell(columnName: columnNames[i++], value: e.name),
          DataGridCell(columnName: columnNames[i++], value: e.atg_name)
        ]
      );
    }));
  }

  @override
  Widget getEditWidget(BuildContext context, String id) {
    return ProductTypeCodeEdit(id);
  }

}

class ProductTypeCodeEdit extends EditWidget {
  final _editID = STextEditingController();
  final _editName = STextEditingController();
  final _editAgtName = STextEditingController();

  ProductTypeCodeEdit(String id) {
    _editID.text = id;
    if (id.isNotEmpty) {
      HttpSqlQuery.post({'sl': "select * from ProductTypeCode where id=$id"}).then((value) {
        if (value.isNotEmpty) {
          _editName.text = value[0]['name'];
          _editAgtName.text = value[0]['atg_name'];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textFieldColumn(context: context, title: L.tr('ID'), textEditingController: _editID, enabled: false),
      textFieldColumn(context: context, title: L.tr('Name'), textEditingController: _editName, enabled: true),
      textFieldColumn(context: context, title: L.tr('Atg name'), textEditingController: _editAgtName, enabled: true),
      saveWidget(context, Object())
    ],);
  }

  @override
  void save(BuildContext context, String table, dynamic object) async {
    Map<String, String> vals = {};
    vals['name'] = _editName.text;
    vals['atg_name'] = _editAgtName.text;
    if (_editID.text.isEmpty) {
      await HttpSqlQuery.post({'sl' : Sql.insert("ProductTypeCode", vals)});
    } else {
      vals['id'] = _editID.text;
      await HttpSqlQuery.post({"sl": Sql.update("ProductTypeCode", vals)});
    }
    Navigator.pop(context, true);
  }

  @override
  String getTable() {
    return 'ProductTypeCode';
  }

}