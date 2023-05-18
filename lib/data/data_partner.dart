import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/screen/partners/partners_edit.dart';
import 'package:sartex/utils/translator.dart';
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
  PartnerDatasource() {
    addColumn(L.tr('Id'));
    addColumn(L.tr('Branch'));
    addColumn(L.tr('Country'));
    addColumn(L.tr('Name'));
    addColumn(L.tr('Type'));
  }

  @override
  void addRows(List d) {
    PartnerList pl = PartnerList.fromJson({'partners': d});
    rows.addAll(pl.partners.map<DataGridRow>((e) { int i = 0;
      return DataGridRow(cells: [
          DataGridCell(columnName: columnNames[i++], value: e.id),
          DataGridCell(columnName: columnNames[i++], value: e.branch),
          DataGridCell(columnName: columnNames[i++], value: e.country),
          DataGridCell(columnName: columnNames[i++], value: e.name),
          DataGridCell(columnName: columnNames[i++], value: e.type),
        ]);}));
  }

  @override
  Widget getEditWidget(BuildContext context, String id) {
    return PartnersEdit(id);
  }
}
