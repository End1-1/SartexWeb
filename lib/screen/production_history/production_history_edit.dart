import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_bloc.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:sartex/widgets/svg_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'production_history_edit.freezed.dart';

part 'production_history_edit.g.dart';

@freezed
class PHEditRecord with _$PHEditRecord {
  const factory PHEditRecord({
    required String date,
    time,
    user,
    location,
    brand,
    Model,
    country,
    variant_prod,
    Colore,
    qanak,
    real_status,
  }) = _PHEditRecord;

  factory PHEditRecord.fromJson(Map<String, dynamic> json) =>
      _$PHEditRecordFromJson(json);
}

class _DataSource extends SartexDataGridSource {
  _DataSource() {
    addColumn(L.tr('Date'));
    addColumn(L.tr('Time'));
    addColumn(L.tr('User'));
    addColumn(L.tr('Brand'));
    addColumn(L.tr('Model'));
    addColumn(L.tr('Country'));
    addColumn(L.tr('Variant'));
    addColumn(L.tr('Color'));
    addColumn(L.tr('Status'));
    addColumn(L.tr('Quantity'));
  }

  @override
  void addRows(List d) {
    List<PHEditRecord> l = [];
    for (final e in d) {
      l.add(PHEditRecord.fromJson(e));
      rows.addAll(l.map<DataGridRow>((e) {
        int i = 0;
        return DataGridRow(cells: [
          DataGridCell(columnName: columnNames[i++], value: e.date),
          DataGridCell(columnName: columnNames[i++], value: e.time),
          DataGridCell(columnName: columnNames[i++], value: e.user),
          DataGridCell(columnName: columnNames[i++], value: e.brand),
          DataGridCell(columnName: columnNames[i++], value: e.Model),
          DataGridCell(columnName: columnNames[i++], value: e.country),
          DataGridCell(columnName: columnNames[i++], value: e.variant_prod),
          DataGridCell(columnName: columnNames[i++], value: e.Colore),
          DataGridCell(columnName: columnNames[i++], value: e.real_status),
          DataGridCell(columnName: columnNames[i++], value: double.tryParse(e.qanak ?? '0') ?? 0),
        ]);
      }));
    }
  }

}

class ProductionHistoryEditWidget extends EditWidget {
  final String apr_id;
  late final String query;
  final da = _DataSource();

  ProductionHistoryEditWidget(this.apr_id) {
    query =
        "select h.date, h.time, concat_ws(' ', u.lastName, u.firstName) as user, h.location, pd.brand, pd.Model, "
        "pd.country, pd.variant_prod, pd.Colore, h.qanak, h.real_status "
        "from History h "
        "left join Apranq a on a.apr_id=h.apr_id "
        "left join patver_data pd on pd.id=a.pid "
        "left join Users u on u.user_id=h.user_id "
        "where h.apr_id=$apr_id and h.action='NOH_YND' "
        "order by 1, 2";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => HttpBloc()..add(HttpBlocEventQuery(query)),
        child: BlocBuilder<HttpBloc, HttpBlocState>(builder: (context, state) {
          if (state is HttpBlocStateIdle || state is HttpBlocStateLoading) {
            return const SizedBox(width: 36, height: 36, child: CircularProgressIndicator());
          }
          da.rows.clear();
          da.addRows((state as HttpBlocStateRead).data);
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Container()),
                    Container(
                        child: Text('${L.tr('History of production')} ',
                            style: tsDialogHeader)),
                    Expanded(child: Container()),
                    SvgButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      assetPath: 'svg/cancel.svg',
                      darkMode: false,
                    ),
                  ],
                ),
                Expanded(child: SfDataGrid(
                  source: da,
                  columns: da.columns,
                  allowColumnsResizing: true,
                  allowFiltering: true,
                  allowSorting: true,
                  isScrollbarAlwaysShown: true,
                  columnWidthMode: state.data.isEmpty ? ColumnWidthMode.fitByColumnName : ColumnWidthMode.auto,
                ))
              ]));
        }));
  }

  @override
  String getTable() {
    return "";
  }
}
