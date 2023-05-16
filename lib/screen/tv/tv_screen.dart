import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sartex/screen/tv/tv_model.dart';
import 'package:sartex/utils/translator.dart';

class TVScreen extends StatelessWidget {
  var page = true;
  final List<ModelRow> modelRows = [];

  final dw = <double>[
    100,
    200,
    200,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100
  ];
  List<double> cw = [];
  final _model = TVModel();
  final double rowHeight = 80;
  final double headerHeight = 80;
  static const _color0 = Color(0xFF0035FF);
  static const _color1 = Color(0xff6bc26a);
  static const _color2 = Color(0xff565656);
  final _standartPadding = const EdgeInsets.all(10);
  final _textHeader1 = const TextStyle(
    color: Colors.white,
    height: 1.52,
    fontSize: 22,
    fontFamily: 'Agency FB',
  );
  final _textHeader2 = const TextStyle(
      color: Colors.black87,
      fontSize: 24,
      height: 1.5,
      fontFamily: 'Agency FB');
  final _textHeader3 = const TextStyle(
      color: Colors.white,
      fontSize: 26,
      height: 1.5,
      fontFamily: 'Agency FB',
      fontWeight: FontWeight.bold);
  final _textTableHeader = const TextStyle(
      color: Colors.black87,
      fontSize: 28,
      height: 1.5,
      fontFamily: 'Agency FB');
  final _textLine = const TextStyle(
      color: Colors.black87,
      fontSize: 32,
      height: 1.5,
      fontFamily: 'Agency FB',
      fontWeight: FontWeight.bold);
  final _textTotal = const TextStyle(
      color: Colors.black87,
      fontSize: 28,
      fontWeight: FontWeight.w900,
      height: 1.5,
      fontFamily: 'Agency FB');
  final _textPlan = const TextStyle(
      color: Colors.red,
      fontSize: 32,
      fontWeight: FontWeight.w900,
      height: 1.5,
      fontFamily: 'Agency FB');

  final _t1 = const BoxDecoration(
      color: _color0,
      border: Border.fromBorderSide(BorderSide(color: Color(0XFF0035FF))));
  final _t2 = const BoxDecoration(
      color: _color1,
      border: Border.fromBorderSide(BorderSide(color: Colors.black12)));
  final _t3 = const BoxDecoration(
      color: _color1,
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFF00FF3D)]),
      border: Border.fromBorderSide(BorderSide(color: Colors.black12)));
  final _t4 = const BoxDecoration(
      color: _color2,
      border: Border.fromBorderSide(BorderSide(color: Colors.black12)));

  final _t5 = const BoxDecoration(
      color: Colors.white,
      border: Border.fromBorderSide(BorderSide(color: Colors.black12)));
  final _t6 = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFF97FFFA)]),
      border: Border.fromBorderSide(BorderSide(color: Colors.black12)));

  final _t7 = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFF4BC7FD)]),
      border: Border.fromBorderSide(BorderSide(color: Colors.black12)));

  final _t8 = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Color(0xFF036C14),
            Color(0xFF006510),
            Color(0xFF006510)
          ]),
      border: Border.fromBorderSide(BorderSide(color: Colors.black12)));

  final _t9 = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Color(0xFFFF2C8B),
            Color(0xFFFF2C8B),
            Color(0xFFFF2C8B),
            Color(0xFFFF2C8B)
          ]),
      border: Border.fromBorderSide(BorderSide(color: Colors.black12)));

  @override
  Widget build(BuildContext context) {
    cw.clear();
    cw.addAll(dw);
    double t = 0;
    for (var e in cw) {
      t += e;
    }
    t = (MediaQuery.of(context).size.width - t) / cw.length;
    t -= 2;
    for (int i = 0; i < cw.length; i++) {
      cw[i] = cw[i] + t;
    }
    return Scaffold(
        body: SafeArea(
            child: StreamBuilder<List<ModelRow>>(
                stream: _model.streamController.stream,
                builder: (context, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _header(),
                      _tableHeader(),
                      Expanded(
                          child: Column(children: [
                        for (var e in snapshot.data ?? []) ...[_tableRow(e)]
                      ])),
                      //SingleChildScrollView(child: Column(children: [ for (var e in snapshot.data ?? [])...[_tableRow(e)]]))),
                      _totalRow()
                    ],
                  );
                })));
  }

  Widget _header() {
    return Row(
      children: [
        Container(
            height: 60,
            width: cw[0] +
                cw[1] +
                cw[2] +
                cw[3] +
                cw[4] +
                cw[5] +
                cw[6] +
                cw[7] +
                cw[8] +
                cw[9] +
                cw[10],
            padding: _standartPadding,
            decoration: const BoxDecoration(color: Color(0xffffffff)),
            child: Text(DateFormat('dd/MM/yyyy').format(DateTime.now()),
                textAlign: TextAlign.center, style: _textHeader2)),
        Expanded(child: Container()),
        Container(
            height: 60,
            width: cw[11] + cw[12] + cw[13],
            padding: _standartPadding,
            decoration: const BoxDecoration(color: Color(0xffffffff)),
            child: Text(DateFormat('MMMM').format(DateTime.now()),
                textAlign: TextAlign.center, style: _textHeader2)),
      ],
    );
  }

  Widget _tableHeader() {
    int i = 0;
    return Row(
      children: [
        //line
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text("Line", style: _textHeader1)),
        //brand
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text("Brand", style: _textHeader1)),
        //model
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text("Model", style: _textHeader1)),
        //10.30
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(L.tr("10:30"), style: _textHeader1)),
        //12.30
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(L.tr("12:30"), style: _textHeader1)),
        //15.30
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(L.tr("15:30"), style: _textHeader1)),
        //17.30
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(L.tr("17:30"), style: _textHeader1)),
        //Ext.
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(L.tr("Ext"), style: _textHeader1)),
        //total
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text("Total", style: _textHeader1)),
        //PAST
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(L.tr("Past"), style: _textHeader1)),
        //plan
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text("Plan", style: _textHeader1)),
        Expanded(child: Container()),
        //Prod
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t3,
            alignment: Alignment.center,
            child: Text(L.tr("Prod"), style: _textHeader2)),
        //Stock
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t3,
            alignment: Alignment.center,
            child: Text(L.tr("Stock"), style: _textHeader2)),
        //Pref
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(L.tr("Perf(%)"), style: _textHeader2)),
      ],
    );
  }

  Widget _tableRow(ModelRow r) {
    int i = 0;
    return Row(
      children: [
        //line
        Container(
            width: cw[i++],
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t5,
            alignment: Alignment.center,
            child: Text(r.line!, style: _textLine)),
        //brand
        Container(
            width: cw[i++],
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t5,
            alignment: Alignment.center,
            child: Text(r.brand!, style: _textTableHeader)),
        //model
        Container(
            width: cw[i++],
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t5,
            alignment: Alignment.center,
            child: Text(r.Model!, style: _textTableHeader)),
        //10.30
        Container(
            width: cw[i++],
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t6,
            alignment: Alignment.center,
            child: Text(r.t1030!, style: _textTableHeader)),
        //12.30
        Container(
            width: cw[i++],
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t6,
            alignment: Alignment.center,
            child: Text(r.t1230!, style: _textTableHeader)),
        //15.30
        Container(
            width: cw[i++],
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t6,
            alignment: Alignment.center,
            child: Text(r.t1530!, style: _textTableHeader)),
        //17.30
        Container(
            width: cw[i++],
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t6,
            alignment: Alignment.center,
            child: Text(r.t1730!, style: _textTableHeader)),
        //Ext.
        Container(
            width: cw[i++],
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t6,
            alignment: Alignment.center,
            child: Text(r.Ext!, style: _textTableHeader)),
        //total
        Container(
            width: cw[i++],
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t7,
            alignment: Alignment.center,
            child: Text(r.Total!, style: _textTotal)),
        //PAST
        Container(
            width: cw[i++],
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t5,
            alignment: Alignment.center,
            child: Text(r.Past!, style: _textTableHeader)),
        //plan
        Container(
            width: cw[i++],
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t8,
            alignment: Alignment.center,
            child: Text(r.Plan!, style: _textPlan)),
        Expanded(child: Container()),
        //PAST
        Container(
            width: cw[i++],
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t3,
            alignment: Alignment.center,
            child: Text(r.Prod!, style: _textTableHeader)),
        //plan
        Container(
            width: cw[i++],
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t3,
            alignment: Alignment.center,
            child: Text(r.Magaz!, style: _textTableHeader)),
        //perf
        Container(
            width: cw[i++],
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t9,
            alignment: Alignment.center,
            child: Text(r.Pref!, style: _textTableHeader)),
      ],
    );
  }

  Widget _totalRow() {
    int i = 3;
    return Row(
      children: [
        //line
        Container(
            height: headerHeight,
            width: cw[0] + cw[1] + cw[2],
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(L.tr("Grand total"), style: _textHeader3)),

        //10.30
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.t1030!, style: _textHeader3)),
        //12.30
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.t1230!, style: _textHeader3)),
        //15.30
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.t1530!, style: _textHeader3)),
        //17.30
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.t1730!, style: _textHeader3)),
        //Ext.
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.Ext!, style: _textHeader3)),
        //total
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.Total!, style: _textHeader3)),
        //PAST
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.Past!, style: _textHeader3)),
        //plan
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.Plan!, style: _textHeader3)),
        Expanded(child: Container()),
        //PAST
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.Prod!, style: _textHeader3)),
        //plan
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.Magaz!, style: _textHeader3)),
        //perf
        Container(
            height: headerHeight,
            width: cw[i++],
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.Pref!, style: _textHeader3)),
      ],
    );
  }
}
