import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/data/sql.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/text_editing_controller.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:sartex/widgets/form_field.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'data_sizes.freezed.dart';
part 'data_sizes.g.dart';

@freezed
class DataSize with _$DataSize {
  const DataSize._();

  const factory DataSize({
    required String id,
    required String? code,
    required String? name,
    required String? size01,
    required String? size02,
    required String? size03,
    required String? size04,
    required String? size05,
    required String? size06,
    required String? size07,
    required String? size08,
    required String? size09,
    required String? size10,
    required String? size11,
    required String? size12
}) = _DataSize;

  factory DataSize.fromJson(Map<String, dynamic> json) => _$DataSizeFromJson(json);

  String sizeOfIndex(int i) {
    String? s;
    switch (i) {
      case 1:
        s = size01;
        break;
      case 2:
        s = size02;
        break;
      case 3:
        s = size03;
        break;
      case 4:
        s = size04;
        break;
      case 5:
        s = size05;
        break;
      case 6:
        s = size06;
        break;
      case 7:
        s = size07;
        break;
      case 8:
        s = size08;
        break;
      case 9:
         s = size09;
         break;
      case 10:
        s = size10;
        break;
      case 11:
        s = size11;
        break;
      case 12:
        s = size12;
        break;
      default:
        throw Exception('Invalid index for size');
    }
    return s ?? '0';
  }
}

@freezed
class SizeList with _$SizeList {
  const factory SizeList({required List<DataSize> sizes}) = _SizeList;
  factory SizeList.fromJson(Map<String, dynamic> json) => _$SizeListFromJson(json);
}

class SizeDatasource extends SartexDataGridSource {
  SizeDatasource(){
    addColumn(L.tr('Id'));
    addColumn(L.tr('Code'));
    addColumn(L.tr('Name'));
    addColumn(L.tr('size01'));
    addColumn(L.tr('size02'));
    addColumn(L.tr('size03'));
    addColumn(L.tr('size04'));
    addColumn(L.tr('size05'));
    addColumn(L.tr('size06'));
    addColumn(L.tr('size07'));
    addColumn(L.tr('size08'));
    addColumn(L.tr('size09'));
    addColumn(L.tr('size10'));
    addColumn(L.tr('size11'));
    addColumn(L.tr('size12'));
  }

  @override
  void addRows(List d) {
    SizeList sl = SizeList.fromJson({'sizes':d});
    rows.addAll(sl.sizes.map<DataGridRow>((e) {
      int i = 0;
        return DataGridRow(cells: [
      DataGridCell(columnName: columnNames[i++], value: e.id),
      DataGridCell(columnName: columnNames[i++], value: e.code),
      DataGridCell(columnName: columnNames[i++], value: e.name),
      DataGridCell(columnName: columnNames[i++], value: e.size01),
      DataGridCell(columnName: columnNames[i++], value: e.size02),
      DataGridCell(columnName: columnNames[i++], value: e.size03),
      DataGridCell(columnName: columnNames[i++], value: e.size04),
      DataGridCell(columnName: columnNames[i++], value: e.size05),
      DataGridCell(columnName: columnNames[i++], value: e.size06),
      DataGridCell(columnName: columnNames[i++], value: e.size07),
      DataGridCell(columnName: columnNames[i++], value: e.size08),
      DataGridCell(columnName: columnNames[i++], value: e.size09),
      DataGridCell(columnName: columnNames[i++], value: e.size10),
      DataGridCell(columnName: columnNames[i++], value: e.size11),
      DataGridCell(columnName: columnNames[i++], value: e.size12),
    ]);}));
  }

  @override
  Widget getEditWidget(BuildContext context, String id) {
    return SizesEdit(id);
  }
}

class SizesEdit extends EditWidget {
  final editId = STextEditingController();
  final editCode = STextEditingController();
  final editName = STextEditingController();
  final s1 = STextEditingController();
  final s2 = STextEditingController();
  final s3 = STextEditingController();
  final s4 = STextEditingController();
  final s5 = STextEditingController();
  final s6 = STextEditingController();
  final s7 = STextEditingController();
  final s8 = STextEditingController();
  final s9 = STextEditingController();
  final s10 = STextEditingController();
  final s11 = STextEditingController();
  final s12 = STextEditingController();
  
  SizesEdit(String id) {
    if (id.isNotEmpty) {
      HttpSqlQuery.post({'sl': "select * from Sizes where id=$id"}).then((value) {
        if (value.isNotEmpty) {
          editId.text = id;
          editCode.text = value[0]['code'] ?? '';
          editName.text = value[0]['name'] ?? '';
          s1.text = value[0]['size01'] ?? '';
          s2.text = value[0]['size02'] ?? '';
          s3.text = value[0]['size03'] ?? '';
          s4.text = value[0]['size04'] ?? '';
          s5.text = value[0]['size05'] ?? '';
          s6.text = value[0]['size06'] ?? '';
          s7.text = value[0]['size07'] ?? '';
          s8.text = value[0]['size08'] ?? '';
          s9.text = value[0]['size09'] ?? '';
          s10.text = value[0]['size10'] ?? '';
          s11.text = value[0]['size11'] ?? '';
          s12.text = value[0]['size12'] ?? '';
        }
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Row(children: [textFieldColumn(context: context, title: L.tr('ID'), textEditingController: editId),
        textFieldColumn(context: context, title: L.tr('Name'), textEditingController: editName),
        textFieldColumn(context: context, title: L.tr('Code'), textEditingController: editCode),
        ]),
        Row(children:[
          textFieldColumn(context: context, title: L.tr('Size01'), textEditingController: s1),
          textFieldColumn(context: context, title: L.tr('Size02'), textEditingController: s2),
          textFieldColumn(context: context, title: L.tr('Size03'), textEditingController: s3),
        ]),
        Row(children:[
          textFieldColumn(context: context, title: L.tr('Size04'), textEditingController: s4),
          textFieldColumn(context: context, title: L.tr('Size05'), textEditingController: s5),
          textFieldColumn(context: context, title: L.tr('Size06'), textEditingController: s6),
        ]),
        Row(children:[
          textFieldColumn(context: context, title: L.tr('Size07'), textEditingController: s7),
          textFieldColumn(context: context, title: L.tr('Size08'), textEditingController: s8),
          textFieldColumn(context: context, title: L.tr('Size09'), textEditingController: s9),
        ]),
        Row(children:[
          textFieldColumn(context: context, title: L.tr('Size10'), textEditingController: s10),
          textFieldColumn(context: context, title: L.tr('Size11'), textEditingController: s11),
          textFieldColumn(context: context, title: L.tr('Size12'), textEditingController: s12),
        ]),
        saveWidget(context, Object()),
      ] 
    );
  }

  @override
  void save(BuildContext context, String table, object) async {
    Map<String, String> data = {};
    data['code'] = editCode.text;
    data['name'] = editName.text;
    data['size01'] = s1.text;
    data['size02'] = s2.text;
    data['size03'] = s3.text;
    data['size04'] = s4.text;
    data['size05'] = s5.text;
    data['size06'] = s6.text;
    data['size07'] = s7.text;
    data['size08'] = s8.text;
    data['size09'] = s9.text;
    data['size10'] = s10.text;
    data['size11'] = s11.text;
    data['size12'] = s12.text;
    if (editId.text.isEmpty) {
      await HttpSqlQuery.post({'sl': Sql.insert("Sizes", data)});
    } else {
      data['id'] = editId.text;
      await HttpSqlQuery.post({'sl': Sql.update("Sizes", data)});
    }
    Navigator.pop(context, true);
  }

  @override
  String getTable() {
    return "Sizes";
  }

}