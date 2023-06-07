import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/screen/store_docs/store_docs_datasource.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_bloc.dart';
import 'package:sartex/utils/text_editing_controller.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:sartex/widgets/form_field.dart';
import 'package:sartex/widgets/svg_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'store_docs_edit_widget.freezed.dart';

part 'store_docs_edit_widget.g.dart';

@freezed
class StoreDocsEditRecord with _$StoreDocsEditRecord {
  const factory StoreDocsEditRecord(
      {required String commesa, docnum, type, pahest, status, brand,
      Model,
      ModelCod,
      coutry,
        variant_prod,
      Colore,
      qanak}) = _StoreDocsEditRecord;

  factory StoreDocsEditRecord.fromJson(Map<String, dynamic> json) =>
      _$StoreDocsEditRecordFromJson(json);
}

class StoreDocsEditWidgetDatasource extends SartexDataGridSource {
  StoreDocsEditWidgetDatasource() {
    addColumn(L.tr('Commesa'));
    addColumn(L.tr('Brand'));
    addColumn(L.tr('Model'));
    addColumn(L.tr('ModelCod'));
    addColumn(L.tr('Country'));
    addColumn(L.tr('Variant'));
    addColumn(L.tr('Color'));
    addColumn(L.tr('Quantity'));

    rowStyle[L.tr('Quantity')] = const TextStyle(
        fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16);

    sumRows.add(GridTableSummaryRow(
        title: L.tr('Total'),
        showSummaryInRow: false,
        columns: [
          GridSummaryColumn(
              name: L.tr('Quantity'),
              columnName: L.tr('Quantity'),
              summaryType: GridSummaryType.sum)
        ],
        position: GridTableSummaryRowPosition.bottom));
  }

  @override
  void addRows(List d) {
    List<StoreDocsEditRecord> l = [];
    for (final e in d) {
      l.add(StoreDocsEditRecord.fromJson(e));
    }
    rows.addAll(l.map<DataGridRow>((r) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: r.commesa),
        DataGridCell(columnName: columnNames[i++], value: r.brand),
        DataGridCell(columnName: columnNames[i++], value: r.Model),
        DataGridCell(columnName: columnNames[i++], value: r.ModelCod),
        DataGridCell(columnName: columnNames[i++], value: r.coutry),
        DataGridCell(columnName: columnNames[i++], value: r.variant_prod),
        DataGridCell(columnName: columnNames[i++], value: r.Colore),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(r.qanak ?? '0') ?? 0),
      ]);
    }));
  }
}

class StoreDocsEditWidget extends EditWidget {
  final String docNum;
  late final String query;
  final tecStore = STextEditingController();
  final tecStatus = STextEditingController();
  final datasource = StoreDocsEditWidgetDatasource();

  StoreDocsEditWidget(this.docNum) {
    query = "select d.docnum, d.type, d.pahest, d.status, pd.PatverN as commesa, "
        "pd.brand, pd.Model, pd.ModelCod, pd.country, pd.variant_prod, pd.Colore, "
        "sum(d.yqanak) as qanak "
        "from Docs d "
        "left join Apranq a on a.apr_id=d.apr_id "
        "left join patver_data pd on pd.id=a.pid "
        "where d.docnum='$docNum' "
        "group by 5, 6, 7, 8, 9";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => HttpBloc()..add(HttpBlocEventQuery(query)),
        child: BlocBuilder<HttpBloc, HttpBlocState>(builder: (context, state) {
          if (state is HttpBlocStateLoading || state is HttpBlocStateIdle) {
            return const Center(child: CircularProgressIndicator());
          }
          if ((state as HttpBlocStateRead).data == null ||
              (state as HttpBlocStateRead).data.isEmpty) {
            return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                child: Text(L.tr('Empty document')));
          }
          datasource.rows.clear();
          datasource.addRows(state.data);
          final h =StoreDocsEditRecord.fromJson(state.data[0]);
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Row(
                children: [
                  Text('${storeDocsTypes[h.type]!} $docNum', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 * scale_factor)),
                  Expanded(child: Container()),
                  SvgButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    assetPath: 'svg/cancel.svg',
                    darkMode: false,
                  )
                ],
              ),
              Row(children: [
                textFieldColumn(context: context,
                  title: 'Store',
                  enabled: false, textEditingController: tecStore..text = h.pahest,
                ),
                textFieldColumn(context: context,
                  title: 'Status',
                  enabled: false, textEditingController: tecStatus..text = h.status,
                )
              ],),
              SizedBox(height: 10 * scale_factor),
              Expanded(child: SfDataGrid(
                source: datasource,
                columns: datasource.columns,
              ))
            ]),
          );
        }));
  }

  @override
  String getTable() {
    return "";
  }
}
