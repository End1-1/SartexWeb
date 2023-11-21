import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/screen/app/app_screen.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_bloc.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/svg_button.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'dashboard_model.dart';

part 'dashboard_screen.freezed.dart';

part 'dashboard_screen.g.dart';

@freezed
class DampexRow with _$DampexRow {
  const factory DampexRow(
      {required String branch,
        line,
      date,
      brand,
      model,
      s10_30,
      s12_30,
      s15_30,
      s17_30,
      sExt,
      sTotal,
      sPast,
      sPlan,
      sdif,
      sPERF,
        sProd,
      i10_30,
      i12_30,
      i15_30,
      i17_30,
      iExt,
      iTotal,
      iPast,
      iPlan,
      idif,
      iPERF,
        iProd,
      smProd,
      imProd,
      smPlan,
      imPlan,
      smStok,
      imStok,
      smCamion,
      imCamion}) = _DampexRow;

  factory DampexRow.fromJson(Map<String, dynamic> json) =>
      _$DampexRowFromJson(json);
}

@freezed
class CamionRow with _$CamionRow {
  const factory CamionRow({
  required String branch, date, camion, Quantity, stock, diff
}) = _CamionRow;
  factory CamionRow.fromJson(Map<String, dynamic> json) => _$CamionRowFromJson(json);
}

@freezed
class StockRow with _$StockRow {
  const factory StockRow({
    required String branch, brand, Model, stock,
}) = _StockRow;
  factory StockRow.fromJson(Map<String, dynamic> json) => _$StockRowFromJson(json);
}

@freezed
class MonthlyRow with _$MonthlyRow {
  const factory MonthlyRow({
    required String branch, date, line, brand, Model, Prod, Plan, Stok, Camion, PERF
}) = _MonthlyRow;
  factory MonthlyRow.fromJson(Map<String, dynamic> json) => _$MonthlyRowFromJson(json);
}

class Datasource1 extends SartexDataGridSource {
  Datasource1() {
    addColumn('Line ');
    addColumn('Brand ');
    addColumn('Model ');
    addColumn('10:30');
    addColumn('12:30');
    addColumn('15:30');
    addColumn('17:30');
    addColumn('Ext ');
    addColumn('Total ');
    addColumn('Past');
    addColumn('Plan ');
    addColumn('Diff ');
    addColumn('%');
    addColumn('Prod');

    sumRows.add(GridTableSummaryRow(
        title: L.tr('Summary'),
        showSummaryInRow: false,
        columns: [
          for (int i = 3; i < 14; i++) ...[
            GridSummaryColumn(
                name: columnNames[i],
                columnName: columnNames[i],
                summaryType: GridSummaryType.sum)
          ]
        ],
        position: GridTableSummaryRowPosition.bottom));
  }

  @override
  void addRows(List d) {
    final List<DampexRow> l = [];
    for (final e in d) {
      DampexRow dr = DampexRow.fromJson(e);
      if (dr.branch != 'Sartex') {
        continue;
    }
      l.add(dr);
    }
    rows.addAll(l.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e.line),
        DataGridCell(columnName: columnNames[i++], value: e.brand),
        DataGridCell(columnName: columnNames[i++], value: e.model),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.s10_30 ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.s12_30 ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.s15_30 ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.s17_30 ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.sExt ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.sTotal ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.sPast ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.sPlan ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.sdif ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: '${(double.tryParse(e.sPERF ?? '0') ?? 0).truncate() * 100}%'),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.sProd ?? '0') ?? 0),
      ]);
    }));
  }
}

class Datasource2 extends SartexDataGridSource {
  Datasource2() {
    addColumn('Line ');
    addColumn('Brand ');
    addColumn('Model ');
    addColumn('10:30');
    addColumn('12:30');
    addColumn('15:30');
    addColumn('17:30');
    addColumn('Ext ');
    addColumn('Total ');
    addColumn('Past');
    addColumn('Plan ');
    addColumn('Diff ');
    addColumn('%');
    addColumn('Prod');

    sumRows.add(GridTableSummaryRow(
        title: L.tr('Summary'),
        showSummaryInRow: false,
        columns: [
          for (int i = 3; i < 14; i++) ...[
            GridSummaryColumn(
                name: columnNames[i],
                columnName: columnNames[i],
                summaryType: GridSummaryType.sum)
          ]
        ],
        position: GridTableSummaryRowPosition.bottom));
  }

  @override
  void addRows(List d) {
    final List<DampexRow> l = [];
    for (final e in d) {
      DampexRow dr = DampexRow.fromJson(e);
      if (dr.branch != 'Itex') {
        continue;
      }
      l.add(dr);
    }
    rows.addAll(l.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e.line),
        DataGridCell(columnName: columnNames[i++], value: e.brand),
        DataGridCell(columnName: columnNames[i++], value: e.model),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.i10_30 ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.i12_30 ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.i15_30 ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.i17_30 ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.iExt ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.iTotal ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.iPast ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.iPlan ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.idif ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: '${(double.tryParse(e.iPERF ?? '0') ?? 0) * 100}%'),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.iProd ?? '0') ?? 0),
      ]);
    }));
  }
}

class Datasource3 extends SartexDataGridSource {
  Datasource3() {
    addColumn('Line ');
    addColumn('Brand ');
    addColumn('Model ');
    addColumn('10:30');
    addColumn('12:30');
    addColumn('15:30');
    addColumn('17:30');
    addColumn('Ext ');
    addColumn('Total ');
    addColumn('Past');
    addColumn('Plan ');
    addColumn('Diff ');
    addColumn('%');
    addColumn('Prod');

    sumRows.add(GridTableSummaryRow(
        title: L.tr('Summary'),
        showSummaryInRow: false,
        columns: [
          for (int i = 3; i < 13; i++) ...[
            GridSummaryColumn(
                name: columnNames[i],
                columnName: columnNames[i],
                summaryType: GridSummaryType.sum)
          ]
        ],
        position: GridTableSummaryRowPosition.bottom));
  }

  @override
  void addRows(List d) {
    final List<DampexRow> l = [];
    for (final e in d) {
      l.add(DampexRow.fromJson(e));
    }
    rows.addAll(l.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e.line),
        DataGridCell(columnName: columnNames[i++], value: e.brand),
        DataGridCell(columnName: columnNames[i++], value: e.model),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.i10_30 ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.i12_30 ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.i15_30 ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.i17_30 ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.iExt ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.iTotal ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.iPast ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.iPlan ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.idif ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: '${(double.tryParse(e.iPERF ?? '0') ?? 0) * 100}%'),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.iProd ?? '0') ?? 0),
      ]);
    }));
  }
}

class Datasource4 extends SartexDataGridSource {
  Datasource4() {
    addColumn('Line ');
    addColumn('PROD');
    addColumn('PLAN');
    addColumn('STOCK');
    addColumn('PERF(%)');

    sumRows.add(GridTableSummaryRow(
        title: L.tr('Summary'),
        showSummaryInRow: false,
        columns: [
          for (int i = 1; i < 4; i++) ...[
            GridSummaryColumn(
                name: columnNames[i],
                columnName: columnNames[i],
                summaryType: GridSummaryType.sum)
          ]
        ],
        position: GridTableSummaryRowPosition.bottom));
  }

  @override
  void addRows(List d) {
    final List<MonthlyRow> l = [];
    for (final e in d) {
      l.add(MonthlyRow.fromJson(e));
    }
    rows.addAll(l.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e.line),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.Prod ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.Plan ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.Stok ?? '0') ?? 0),
        DataGridCell(
            columnName: columnNames[i++],
            value: double.tryParse(e.PERF ?? '0') ?? 0),
      ]);
    }));
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        height: 10 * scale_factor,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(3.0),
        color:  row.getCells().indexOf(e) == 0 ? Colors.white : row.getCells().indexOf(e).isEven
            ? Color(0xfff89662)
            : Color(0xff00aab9),
        child: Text(e.value.toString(),
            style: rowStyle.containsKey(e.columnName)
                ? rowStyle[e.columnName]
                : const TextStyle(fontSize: 12)),
      );
    }).toList());
  }
}

class Dashboard extends App {
  var date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var dateMonth = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var ds1 = Datasource1();
  var ds2 = Datasource2();
  var ds4 = Datasource4();
  var ds5 = Datasource4();
  final dateController = StreamController.broadcast();
  final camionController = StreamController.broadcast();
  final stockController = StreamController.broadcast();

  final monthController = StreamController.broadcast();
  final mtableSartex = StreamController.broadcast();
  final mtableItex = StreamController.broadcast();

  static const colwidth = 830.0;

  Dashboard() : super(title: '', model: DashboardModel());

  @override
  Widget body(BuildContext context) {
    if (MediaQuery.of(context).size.width <= 1366) {
      scale_factor = scale_1366;
    }
    return BlocProvider(
        create: (_) => HttpBloc()
          ..add(HttpBlocEventGet(
              "dampex&flt=${DateFormat('yyyy-MM-dd').format(date)}")),
        child: BlocBuilder<HttpBloc, HttpBlocState>(builder: (context, state) {
          if (state is HttpBlocStateLoading || state is HttpBlocStateIdle) {
            return const Center(
                child: SizedBox(
                    width: 36, height: 36, child: CircularProgressIndicator()));
          }
          ds1 = Datasource1();
          ds2 = Datasource2();
          List<dynamic> data = jsonDecode((state as HttpBlocStateRead).data);
          ds1.addRows(data);
          ds2.addRows(data);
          _getCamion(context);
          _getStock();
          _getMonthly();
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dateHeader(context),
                Expanded(
                    child: Scrollbar(
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            primary: true,
                            child: SingleChildScrollView(
                                child: SizedBox(
                                    width: colwidth * 3,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //LEFT SIDE
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (prefs.branch() ==
                                                        'Sartex' ||
                                                    prefs.roleSuperAdmin())
                                                  SizedBox(
                                                      width: colwidth,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      color: Color(
                                                                          0xff005566)),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: const Text(
                                                                  'Sartex',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20))),
                                                          _mainTableSartex(
                                                              context)
                                                        ],
                                                      )),
                                                const SizedBox(width: 10),
                                                //   //RIGHT SIDE
                                                if (prefs.branch() == 'Itex' ||
                                                    prefs.roleSuperAdmin())
                                                  SizedBox(
                                                      width: colwidth,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      color: Color(
                                                                          0xffec5706)),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: const Text(
                                                                  'Itex',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20))),
                                                          _mainTableItex(
                                                              context)
                                                        ],
                                                      )),
                                                const SizedBox(width: 10),
                                                _totals(context) //TOTALS
                                              ]),

                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (prefs.branch() == 'Sartex' ||
                                                  prefs.roleSuperAdmin()) ...[
                                                SizedBox(
                                                  width: colwidth / 2,
                                                  child: _camion(
                                                      context, true),
                                                ),
                                                const SizedBox(width: 10),
                                                SizedBox(
                                                  width: colwidth / 2,
                                                  child: _stock(
                                                      context, data, true),
                                                ),
                                              ],
                                              if (prefs.branch() == 'Itex' ||
                                                  prefs.roleSuperAdmin()) ...[
                                                const SizedBox(width: 10),
                                                SizedBox(
                                                  width: colwidth / 2,
                                                  child: _camion(
                                                      context, false),
                                                ),
                                                const SizedBox(width: 10),
                                                SizedBox(
                                                  width: colwidth / 2,
                                                  child: _stock(
                                                      context, data, false),
                                                ),
                                              ]
                                            ],
                                          )
                                        ]))))))
              ]);
        }));
  }

  Widget _dateHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        SvgButton(
          onTap: () {
            date = date.add(const Duration(days: -1));
            BlocProvider.of<HttpBloc>(context).add(HttpBlocEventGet(
                "dampex&flt=${DateFormat('yyyy-MM-dd').format(date)}"));
          },
          assetPath: 'svg/left.svg',
          darkMode: false,
        ),
        Text(DateFormat("dd/MM/yyyy").format(date),
            style: const TextStyle(color: Colors.black, fontSize: 20)),
        SvgButton(
          onTap: () {
            date = date.add(const Duration(days: 1));
            BlocProvider.of<HttpBloc>(context).add(HttpBlocEventGet(
                "dampex&flt=${DateFormat('yyyy-MM-dd').format(date)}"));
          },
          assetPath: 'svg/right.svg',
          darkMode: false,
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget _mainTableSartex(BuildContext context) {
    return _mainTable(context, ds1, const Color(0xff62c8ff));
  }

  Widget _mainTableItex(BuildContext context) {
    return _mainTable(context, ds2, const Color(0xffffbb62));
  }

  Widget _mainTable(
      BuildContext context, SartexDataGridSource ds, Color headerColor) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: colwidth,
        child: SfDataGridTheme(
            data: SfDataGridThemeData(
                headerColor: headerColor,
                rowHoverColor: Colors.yellow,
                rowHoverTextStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                )),
            child: SfDataGrid(
              onQueryRowHeight: (details) {
                return 30.0;
              },
              source: ds,
              columns: ds.columns,
              tableSummaryRows: ds.sumRows,
              allowColumnsResizing: true,
              allowFiltering: false,
              allowSorting: false,
              isScrollbarAlwaysShown: true,
              columnWidthMode: ColumnWidthMode.auto,
            )));
  }

  Widget _totals(BuildContext context) {
    return SizedBox(
        width: colwidth - 20,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
        decoration: const BoxDecoration(color: Color(0xffec5706)) , child: Row(children:[
            Expanded(child: Container()),
            SvgButton(
              onTap: () {
                dateMonth = DateTime(dateMonth.year, dateMonth.month - 1, 1);
                _getMonthly();
              },
              assetPath: 'svg/left.svg',
              darkMode: false,
            ),
            StreamBuilder(stream: monthController.stream, builder: (context, snapshot){ return Container(
              decoration: const BoxDecoration(color: Color(0xffec5706)),
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              child: Text(DateFormat('MMMM').format(dateMonth),
                  style: const TextStyle(color: Colors.white, fontSize: 20)));}),
            SvgButton(
              onTap: () {
                dateMonth = DateTime(dateMonth.year, dateMonth.month + 1, 1);
                _getMonthly();
              },
              assetPath: 'svg/right.svg',
              darkMode: false,
            ),
            Expanded(child: Container()),
          ])),
          Row(children:[
            StreamBuilder(stream: mtableSartex.stream, builder: (context, snapshot) {
              if (!prefs.roleSuperAdmin() && !(prefs.branch() == 'Sartex')) {
                return Container();
              }
              ds4 = Datasource4();
              ds4.addRows(jsonDecode(snapshot.data ?? '[]'));
              return
                SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: (colwidth / 2) - 30,
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(child: Text('Sartex', style: const TextStyle(fontSize: 20))), Expanded(child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                      headerColor: Color(0xff00aaff),
                      rowHoverColor: Colors.yellow,
                      rowHoverTextStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      )),
                  child: SfDataGrid(
                    onQueryRowHeight: (details) {
                      return 30.0;
                    },
                    source: ds4,
                    columns: ds4.columns,
                    tableSummaryRows: ds4.sumRows,
                    allowColumnsResizing: true,
                    allowFiltering: false,
                    allowSorting: false,
                    isScrollbarAlwaysShown: true,
                    columnWidthMode: ColumnWidthMode.auto,
                  )))]
              ));}),
            //itex
            StreamBuilder(stream: mtableItex.stream, builder: (context, snapshot) {
              if (!prefs.roleSuperAdmin() && !(prefs.branch() == 'Itex')) {
                return Container();
              }
              ds5 = Datasource4();
              ds5.addRows(jsonDecode(snapshot.data ?? '[]'));
              return
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: (colwidth / 2) - 30,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Container(child: Text('Itex', style: const TextStyle(fontSize: 20))), Expanded(child: SfDataGridTheme(
                          data: SfDataGridThemeData(
                              headerColor: Color(0xff00aaff),
                              rowHoverColor: Colors.yellow,
                              rowHoverTextStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              )),
                          child: SfDataGrid(
                            onQueryRowHeight: (details) {
                              return 30.0;
                            },
                            source: ds5,
                            columns: ds5.columns,
                            tableSummaryRows: ds5.sumRows,
                            allowColumnsResizing: true,
                            allowFiltering: false,
                            allowSorting: false,
                            isScrollbarAlwaysShown: true,
                            columnWidthMode: ColumnWidthMode.auto,
                          )))]
                    ));})
          ])
        ]));
  }

  Future<dynamic> _getCamion(BuildContext context) async {
    final r = await HttpSqlQuery.getStringT(type: 'camion');
    camionController.add(r);
  }

  Future<dynamic> _getStock() async {
    final r = await HttpSqlQuery.get("select pd.brand, pd.Model, m.branch, sum(m.mnacord) as stock "
        "from Mnacord m "
        "left join Apranq a on a.apr_id=m.apr_id "
        "left join patver_data pd on pd.id=a.pid "
        "group by 1, 2, 3 "
        "having sum(m.mnacord) <>0");
    stockController.add(r);
  }

  Future<dynamic> _getMonthly() async {
    final r1 = await HttpSqlQuery.getStringT(type: "dampexm,where date='${DateFormat('yyyy-MM').format(dateMonth)}' and branch='Sartex'");
    final r2 = await HttpSqlQuery.getStringT(type: "dampexm,where date='${DateFormat('yyyy-MM').format(dateMonth)}' and branch='Itex'");
    mtableSartex.add(r1);
    mtableItex.add(r2);
    monthController.add(null);
  }

  Widget _camion(BuildContext contex, bool side) {
    final color = side ? const Color(0xff448df8) : Color(0xffec5706);
    final List<CamionRow> lr = [];

    return StreamBuilder(
      stream: camionController.stream,
        builder: (builder, snapshot) {
        double total = 0.0, totalStock = 0.0, totalDiff = 0.0;
        if ((snapshot.data ?? []).isEmpty) {
          return Container();
        }
        ds4 = Datasource4();
        ds4.addRows(jsonDecode(snapshot.data ?? []));
        lr.clear();
        for (final e in jsonDecode(snapshot.data)) {
          CamionRow cr = CamionRow.fromJson(e);
          if (side) {
            if (cr.branch != 'Sartex') {
              continue;
            }
          } else {
            if (cr.branch != 'Itex') {
              continue;
            }
          }
          total += double.tryParse(cr.Quantity ?? '0') ?? 0;
          totalStock += double.tryParse(cr.stock ?? '0') ?? 0;
          totalDiff += double.tryParse(cr.diff ?? '0') ?? 0;
          lr.add(cr);
        }
        return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Container(
                    alignment: Alignment.center, child: Text('Camion')))
          ],
        ),
        Row(
          children: [
            Container(
                width: 80,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: color),
                child: Text('Date')),
            Container(
                width: 80,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: color),
                child: Text('Camion')),
            Container(
                width: 80,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: color),
                child: Text('Quantity')),
            Container(
                width: 60,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: color),
                child: Text('Stock')),
            Container(
                width: 50,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: color),
                child: Text('Diff')),
          ],
        ),
        for (final e in lr) ... [
        Row(
          children: [
            Container(
                width: 80,
                padding: const EdgeInsets.all(5),
                child: Text(e.date)),
            Container(
                width: 80,
                padding: const EdgeInsets.all(5),
                child: Text(e.camion)),
            Container(
                width: 80,
                padding: const EdgeInsets.all(5),
                child: Text(e.Quantity)),
            Container(
                width: 60,
                padding: const EdgeInsets.all(5),
                child: Text(e.stock ?? '')),
            Container(
                width: 50,
                padding: const EdgeInsets.all(5),
                child: Text(e.diff ?? '')),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
          Row(
            children: [
              Container(
                  width: 160,
                  padding: const EdgeInsets.all(5),
                  child: Text('Total')),

              Container(
                  width: 80,
                  padding: const EdgeInsets.all(5),
                  child: Text(total.toString())),
              Container(
                  width: 60,
                  padding: const EdgeInsets.all(5),
                  child: Text(totalStock.toString())),
              Container(
                  width: 50,
                  padding: const EdgeInsets.all(5),
                  child: Text(totalDiff.toString())),
            ],
          ),
        ]
      ],
    );});
  }

  Widget _stock(BuildContext context, List<dynamic> data, bool side) {
    final color = side ? const Color(0xff448df8) : Color(0xffec5706);
    final List<StockRow> lr = [];

    return StreamBuilder(
    stream: stockController.stream,
        builder: (builder, snapshot) {
      lr.clear();
      double total = 0.0;
      if ((snapshot.data ?? []).isEmpty) {
        return Container();
      }
      for (final e in snapshot.data) {
        StockRow sr = StockRow.fromJson(e);
        if (side) {
          if (sr.branch != 'Sartex') {
            continue;
          }
        } else {
          if (sr.branch != 'Itex') {
            continue;
          }
        }
        lr.add(sr);
        total += double.tryParse(sr.stock ?? '0') ?? 0;
      }
      return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Container(
                    alignment: Alignment.center, child: Text('Stock')))
          ],
        ),
        Row(
          children: [
            Container(
                width: 80,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: color),
                child: Text('Brand')),
            Container(
                width: 150,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: color),
                child: Text('Model')),
            Container(
                width: 60,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: color),
                child: Text('Stock')),
          ],
        ),
          for (final f in lr) ...[
            Row(
              children: [
                Container(
                    width: 80,
                    padding: const EdgeInsets.all(5),
                    child: Text(f.brand)),
                Container(
                    width: 150,
                    padding: const EdgeInsets.all(5),
                    child: Text(f.Model)),
                Container(
                    width: 60,
                    padding: const EdgeInsets.all(5),
                    child: Text(f.stock)),
              ],
            )
          ],
        Row(
          children: [
            Container(
                width: 230,
                padding: const EdgeInsets.all(5),
                child: Text('Total')),
            Container(
                width: 60,
                padding: const EdgeInsets.all(5),
                child: Text(total.toString())),
          ],
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );});
  }
}
