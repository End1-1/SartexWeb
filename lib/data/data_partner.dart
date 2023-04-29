import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'data_partner.freezed.dart';

part 'data_partner.g.dart';

@freezed
class Partner with _$Partner {
  const factory Partner(
      {required String id,
      required String branch,
      required String country,
      required String name,
      required String type}) = _Partner;

  factory Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);
}

@freezed
class PartnerList with _$PartnerList {
  const factory PartnerList({required List<Partner> partners}) = _PartnerList;

  factory PartnerList.fromJson(Map<String, dynamic> json) =>
      _$PartnerListFromJson(json);
}

class PartnerDatasource extends SartexDataGridSource {
  PartnerDatasource({required super.context, required List data}) {
    addRows(data);
    addColumn('edit');
    addColumn('Id');
    addColumn('Branch');
    addColumn('Country');
    addColumn('Name');
    addColumn('Type');
  }

  @override
  void addRows(List d) {
    data.addAll(d);
    rows.addAll(d.map<DataGridRow>((e) => DataGridRow(cells: [
          DataGridCell(columnName: 'editdata', value: e.id),
          DataGridCell(columnName: 'id', value: e.id),
          DataGridCell(columnName: 'branch', value: e.branch),
          DataGridCell(columnName: 'country', value: e.country),
          DataGridCell(columnName: 'name', value: e.name),
          DataGridCell(columnName: 'type', value: e.type),
        ])));
  }
}
