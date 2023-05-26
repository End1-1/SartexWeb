import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/screen/preloading/preloading_bloc.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/svg_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Sum1 extends SartexDataGridSource {
  Sum1(List<dynamic> data) {
    addColumn(L.tr('Brand'));
    addColumn(L.tr('Loading'));
    addColumn(L.tr('Store'));
    addColumn(L.tr('Diff'));
    addRows(data);
  }

  @override
  void addRows(List d) {
    rows.addAll(d.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e['brand']),
        DataGridCell(columnName: columnNames[i++], value: e['pqanak']),
        DataGridCell(columnName: columnNames[i++], value: e['mqanak']),
        DataGridCell(columnName: columnNames[i++], value: e['diff']),
      ]);
    }));
  }
}

class Sum2 extends SartexDataGridSource {
  Sum2(List<dynamic> data) {
    addColumn(L.tr('Line'));
    addColumn(L.tr('Loading'));
    addColumn(L.tr('Store'));
    addColumn(L.tr('Diff'));
    addRows(data);
  }

  @override
  void addRows(List d) {
    rows.addAll(d.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e['line']),
        DataGridCell(columnName: columnNames[i++], value: e['pqanak']),
        DataGridCell(columnName: columnNames[i++], value: e['mqanak']),
        DataGridCell(columnName: columnNames[i++], value: e['diff']),
      ]);
    }));
  }
}

class Sum3 extends SartexDataGridSource {
  Sum3(List<dynamic> data) {
    addColumn(L.tr('Commesa'));
    addColumn(L.tr('Model'));
    addColumn(L.tr('Model'));
    addColumn(L.tr('Country'));
    addColumn(L.tr('Store'));
    addColumn(L.tr('Diff'));
    addRows(data);
  }

  @override
  void addRows(List d) {
    rows.addAll(d.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e['commesa']),
        DataGridCell(columnName: columnNames[i++], value: e['Model']),
        DataGridCell(columnName: columnNames[i++], value: e['country']),
        DataGridCell(columnName: columnNames[i++], value: e['pqanak']),
        DataGridCell(columnName: columnNames[i++], value: e['mqanak']),
        DataGridCell(columnName: columnNames[i++], value: e['diff']),
      ]);
    }));
  }
}

class PreloadingSummmaryScreen extends StatelessWidget {
  static const TextStyle tsDialogHeader = TextStyle(
      color: Color(0xff0000ff), fontSize: 30, fontWeight: FontWeight.bold);

  final Map<String, List<dynamic>> doc;
  late final Sum1 sum1;
  late final Sum2 sum2;
  late final Sum3 sum3;

  PreloadingSummmaryScreen({required this.doc}) {
    sum1 = Sum1(doc['bybrand']!);
    sum2 = Sum2(doc['byline']!);
    sum3 = Sum3(doc['bycommesa']!);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SvgButton(
              onTap: () {
                BlocProvider.of<PreloadingBloc>(context).add(
                    PreloadingEventOpenDoc(docnum: doc['doc']![0]['docnum']));
              },
              assetPath: 'svg/left.svg',
              darkMode: false,
            ),
            Expanded(child: Container()),
            Container(
                child: Text(
                    '${L.tr('Summary of preloading')} ${doc['doc']![0]['docnum']}',
                    style: tsDialogHeader)),
            Expanded(child: Container()),
          ]),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                  const SizedBox(height: 10),
                  SfDataGrid(
                    source: sum1,
                    columns: sum1.columns,
                    tableSummaryRows: [
                      GridTableSummaryRow(columns: [
                        GridSummaryColumn(
                            name: sum1.columnNames[3],
                            columnName: sum1.columnNames[3],
                            summaryType: GridSummaryType.sum)
                      ], position: GridTableSummaryRowPosition.bottom)
                    ],
                  ),
                  const SizedBox(height: 10),
                  SfDataGrid(
                    source: sum2,
                    columns: sum2.columns,
                    tableSummaryRows: [
                      GridTableSummaryRow(columns: [
                        GridSummaryColumn(
                            name: sum2.columnNames[3],
                            columnName: sum2.columnNames[3],
                            summaryType: GridSummaryType.sum)
                      ], position: GridTableSummaryRowPosition.bottom)
                    ],
                  ),
                ]))),
            Expanded(
                child: Column(children: [
              const SizedBox(height: 10),
              SfDataGrid(
                source: sum3,
                columns: sum3.columns,
                tableSummaryRows: [
                  GridTableSummaryRow(columns: [
                    GridSummaryColumn(
                        name: sum3.columnNames[5],
                        columnName: sum3.columnNames[5],
                        summaryType: GridSummaryType.sum)
                  ], position: GridTableSummaryRowPosition.bottom)
                ],
              )
            ]))
          ]),
        ])));
  }
}
