import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/screen/preloading/preloading_bloc.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/svg_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

const ts = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

class Sum1 extends SartexDataGridSource {
  Sum1(List<dynamic> data) {
    addColumn(L.tr('Brand'), ts: ts);
    addColumn(L.tr('Loading'), ts: ts);
    addColumn(L.tr('Store'), ts: ts);
    addColumn(L.tr('Diff'), ts: ts);

    cellBgColors[L.tr('Brand')] = const Color(0xff9fe8fa);
    cellBgColors[L.tr('Loading')] = const Color(0xff9fe8fa);
    cellBgColors[L.tr('Store')] = const Color(0xff9fe8fa);
    cellBgColors[L.tr('Diff')] = const Color(0xffffcfcf);
    rowStyle[L.tr('Diff')] = const TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold);

    sumRows.add(
        GridTableSummaryRow(
            title: L.tr('Summary'),
            showSummaryInRow: false,
            columns: [
              GridSummaryColumn(
                  name: columnNames[1],
                  columnName: columnNames[1],
                  summaryType: GridSummaryType.sum),
              GridSummaryColumn(
                  name: columnNames[2],
                  columnName: columnNames[2],
                  summaryType: GridSummaryType.sum),
              GridSummaryColumn(
                  name: columnNames[3],
                  columnName: columnNames[3],
                  summaryType: GridSummaryType.sum)
            ], position: GridTableSummaryRowPosition.bottom)
    );

    addRows(data);
  }

  @override
  void addRows(List d) {
    rows.addAll(d.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e['brand']),
        DataGridCell(columnName: columnNames[i++], value: double.tryParse(e['pqanak'] ?? '0') ?? 0),
        DataGridCell(columnName: columnNames[i++], value: double.tryParse(e['mqanak'] ?? '0') ?? 0),
        DataGridCell(columnName: columnNames[i++], value: double.tryParse(e['diff'] ?? '0') ?? 0),
      ]);
    }));
  }
}

class Sum2 extends SartexDataGridSource {
  Sum2(List<dynamic> data) {
    addColumn(L.tr('Line'), ts: ts);
    addColumn(L.tr('Loading'), ts: ts);
    addColumn(L.tr('Store'), ts: ts);
    addColumn(L.tr('Diff'), ts: ts);

    cellBgColors[L.tr('Line')] = const Color(0xff9fe8fa);
    cellBgColors[L.tr('Loading')] = const Color(0xff9fe8fa);
    cellBgColors[L.tr('Store')] = const Color(0xff9fe8fa);
    cellBgColors[L.tr('Diff')] = const Color(0xffffcfcf);
    rowStyle[L.tr('Diff')] = const TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold);

    sumRows.add(
        GridTableSummaryRow(
            title: L.tr('Summary'),
            showSummaryInRow: false,
            columns: [
              GridSummaryColumn(
                  name: columnNames[1],
                  columnName: columnNames[1],
                  summaryType: GridSummaryType.sum),
              GridSummaryColumn(
                  name: columnNames[2],
                  columnName: columnNames[2],
                  summaryType: GridSummaryType.sum),
              GridSummaryColumn(
                  name: columnNames[3],
                  columnName: columnNames[3],
                  summaryType: GridSummaryType.sum)
            ], position: GridTableSummaryRowPosition.bottom)
    );

    addRows(data);
  }

  @override
  void addRows(List d) {
    rows.addAll(d.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e['line']),
        DataGridCell(columnName: columnNames[i++], value: double.tryParse(e['pqanak']) ?? 0),
        DataGridCell(columnName: columnNames[i++], value: double.tryParse(e['mqanak']) ?? 0),
        DataGridCell(columnName: columnNames[i++], value: double.tryParse(e['diff']) ?? 0),
      ]);
    }));
  }
}

class Sum3 extends SartexDataGridSource {
  Sum3(List<dynamic> data) {
    addColumn(L.tr('Commesa'), ts: ts);
    addColumn(L.tr('Model'), ts: ts);
    addColumn(L.tr('Country'), ts: ts);
    addColumn(L.tr('Loading'), ts: ts);
    addColumn(L.tr('Store'), ts: ts);
    addColumn(L.tr('Diff'), ts: ts);

    cellBgColors[L.tr('Commesa')] = const Color(0xff9fe8fa);
    cellBgColors[L.tr('Model')] = const Color(0xff9fe8fa);
    cellBgColors[L.tr('Country')] = const Color(0xff9fe8fa);
    cellBgColors[L.tr('Loading')] = const Color(0xff9fe8fa);
    cellBgColors[L.tr('Store')] = const Color(0xff9fe8fa);
    cellBgColors[L.tr('Diff')] = const Color(0xffffcfcf);
    rowStyle[L.tr('Diff')] = const TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold);

    sumRows.add(
        GridTableSummaryRow(
            title: L.tr('Summary'),
            showSummaryInRow: false,
            columns: [
              GridSummaryColumn(
                  name: columnNames[3],
                  columnName: columnNames[3],
                  summaryType: GridSummaryType.sum),
              GridSummaryColumn(
                  name: columnNames[4],
                  columnName: columnNames[4],
                  summaryType: GridSummaryType.sum),
              GridSummaryColumn(
                  name: columnNames[5],
                  columnName: columnNames[5],
                  summaryType: GridSummaryType.sum)
            ], position: GridTableSummaryRowPosition.bottom)
    );

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
        DataGridCell(columnName: columnNames[i++], value: double.tryParse(e['pqanak']) ?? 0),
        DataGridCell(columnName: columnNames[i++], value: double.tryParse(e['mqanak']) ?? 0),
        DataGridCell(columnName: columnNames[i++], value: double.tryParse(e['diff']) ?? 0),
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

  PreloadingSummmaryScreen({super.key, required this.doc}) {
    sum1 = Sum1(doc['bybrand']!);
    sum2 = Sum2(doc['byline']!);
    sum3 = Sum3(doc['bycommesa']!);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
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
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SvgButton(
                onTap: () {
                  Navigator.pop(context);
                },
                assetPath: 'svg/cancel.svg',
                darkMode: false,
              ),
              SvgButton(
                onTap: () {
                  _exportToExcel(context);
                },
                assetPath: 'svg/excel.svg',
                darkMode: false,
              ),
            ],),
          ]),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                  const SizedBox(height: 10),
                    SfDataGridTheme(
                        data: SfDataGridThemeData(headerColor: const Color(
                            0xff1f3069)),
                        child: SfDataGrid(
                    source: sum1,
                    columns: sum1.columns,
                    tableSummaryRows: sum1.sumRows,
                          allowColumnsResizing: true,
                          allowFiltering: true,
                          allowSorting: true,
                          isScrollbarAlwaysShown: true,
                          columnWidthMode:  ColumnWidthMode.auto,
                  )),
                  const SizedBox(height: 10),
                    SfDataGridTheme(
                        data: SfDataGridThemeData(headerColor: const Color(
                            0xff1f3069)),
                        child: SfDataGrid(
                    source: sum2,
                    columns: sum2.columns,
                    tableSummaryRows: sum2.sumRows,
                          allowColumnsResizing: true,
                          allowFiltering: true,
                          allowSorting: true,
                          isScrollbarAlwaysShown: true,
                          columnWidthMode:  ColumnWidthMode.auto,
                  )),
                ])))),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
              const SizedBox(height: 10),
                SfDataGridTheme(
                    data: SfDataGridThemeData(headerColor: const Color(
                        0xff1f3069)),
                    child: SfDataGrid(
                source: sum3,
                columns: sum3.columns,
                tableSummaryRows: sum3.sumRows,
                      allowColumnsResizing: true,
                      allowFiltering: true,
                      allowSorting: true,
                      isScrollbarAlwaysShown: true,
                      columnWidthMode: ColumnWidthMode.auto,
              )),
            ]))
          ]),
        ]));
  }

  _exportToExcel(BuildContext context) {

  }
}
