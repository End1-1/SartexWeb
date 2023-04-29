import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'docs.freezed.dart';
part 'docs.g.dart';

@freezed
class Docs with _$Docs {
const factory Docs ({
  required String id,
  required String? branch,
  required String? country,
  required String? receiver,
  required String? avto,
  required String? type,
  required String? date,
  required String? apr_id,
  required String? pahest,
  required String? qanak,
  required String? yqanak,
  required String? status
}) = _Docs;

factory Docs.fromJson(Map<String, Object?> json) => _$DocsFromJson(json);

}

@freezed
class DocsList with _$DocsList {
  const factory DocsList ({required List<Docs> list}) = _DocsList;
  factory DocsList.fromJson(Map<String, Object?> json) => _$DocsListFromJson(json);
}

class DocsDatasource extends SartexDataGridSource {

  DocsDatasource({required super.context, required List data}) {
    addRows(data);
    addColumn('edit');
    addColumn('Id');
    addColumn( 'Date');
    addColumn( 'Branch');
    addColumn( 'Country');
    addColumn( 'Receiver');
    addColumn('Auto');
    addColumn('Store');
    addColumn('Quantity',);
    addColumn( 'Status');
  }

  @override
  void addRows(List d) {
    data.addAll(d);
    rows.addAll(d.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell(columnName: 'editdata', value: e.id),
      DataGridCell(columnName: 'id', value: e.id),
      DataGridCell(columnName: 'date', value: e.date),
      DataGridCell(columnName: 'branch', value: e.branch),
      DataGridCell(columnName: 'country', value: e.country),
      DataGridCell(columnName: 'receiver', value: e.receiver),
      DataGridCell(columnName: 'auto', value: e.auto),
      DataGridCell(columnName: 'pahest', value: e.pahest),
      DataGridCell(columnName: 'qanak', value: e.qanak),
      DataGridCell(columnName: 'status', value: e.status),
    ])));
  }

}