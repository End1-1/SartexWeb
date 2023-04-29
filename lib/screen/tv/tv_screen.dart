import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sartex/screen/tv/tv_model.dart';
import 'package:sartex/utils/translator.dart';

class TVScreen extends StatelessWidget {
  final _model = TVModel();
  final double rowHeight = 90;
  static const _color0 = Color(0xFF0035FF);
  static const _color1 = Color(0xff6bc26a);
  static const _color2 = Color(0xff565656);
  final _standartPadding = const EdgeInsets.all(10);
  final _textHeader1 = const TextStyle(
    color: Colors.white,
    height: 1.5,
    fontSize: 28,
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
      fontSize: 32,
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
                      Expanded(child:
                      Transform.scale(
                              alignment: Alignment.topLeft,
                              scaleY: (MediaQuery.of(context).size.height -
                                      120) /
                                  ((snapshot.data?.length ?? 0) * rowHeight),
                              child: SingleChildScrollView(child: Column(children: [ for (var e in snapshot.data ?? [])...[_tableRow(e)]]))
                                )),
                      _totalRow()
                    ],
                  );
                })));
  }

  Widget _header() {
    return Row(
      children: [
        Container(
            width: 1350,
            padding: _standartPadding,
            decoration: const BoxDecoration(color: Color(0xffffffff)),
            child: Text(DateFormat('dd/MM/yyyy').format(DateTime.now()),
                textAlign: TextAlign.center, style: _textHeader2)),
        SizedBox.fromSize(size: const Size(100, 0)),
        Container(
            width: 330,
            padding: _standartPadding,
            decoration: const BoxDecoration(color: Color(0xffffffff)),
            child: Text(DateFormat('MMMM').format(DateTime.now()),
                textAlign: TextAlign.center, style: _textHeader2)),
      ],
    );
  }

  Widget _tableHeader() {
    return Row(
      children: [
        //line
        Container(
            width: 150,
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text("Line", style: _textHeader1)),
        //brand
        Container(
            width: 200,
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text("Brand", style: _textHeader1)),
        //model
        Container(
            width: 200,
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text("Model", style: _textHeader1)),
        //10.30
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(L.tr("10:30"), style: _textHeader1)),
        //12.30
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(L.tr("12:30"), style: _textHeader1)),
        //15.30
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(L.tr("15:30"), style: _textHeader1)),
        //17.30
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(L.tr("17:30"), style: _textHeader1)),
        //Ext.
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(L.tr("Ext"), style: _textHeader1)),
        //total
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text("Total", style: _textHeader1)),
        //PAST
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(L.tr("Past"), style: _textHeader1)),
        //plan
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text("Plan", style: _textHeader1)),
        SizedBox.fromSize(size: const Size(100, 0)),
        //Prod
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t3,
            alignment: Alignment.center,
            child: Text(L.tr("Prod"), style: _textHeader2)),
        //Stock
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t3,
            alignment: Alignment.center,
            child: Text(L.tr("Stock"), style: _textHeader2)),
        //Pref
        Container(
            width: 130,
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(L.tr("Perf(%)"), style: _textHeader2)),
      ],
    );
  }

  Widget _tableRow(ModelRow r) {
    return Row(
      children: [
        //line
        Container(
            width: 150,
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t5,
            alignment: Alignment.center,
            child: Text(r.line!, style: _textLine)),
        //brand
        Container(
            width: 200,
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t5,
            alignment: Alignment.center,
            child: Text(r.brand!, style: _textTableHeader)),
        //model
        Container(
            width: 200,
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t5,
            alignment: Alignment.center,
            child: Text(r.Model!, style: _textTableHeader)),
        //10.30
        Container(
            width: 100,
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t6,
            alignment: Alignment.center,
            child: Text(r.t1030!, style: _textTableHeader)),
        //12.30
        Container(
            width: 100,
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t6,
            alignment: Alignment.center,
            child: Text(r.t1230!, style: _textTableHeader)),
        //15.30
        Container(
            width: 100,
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t6,
            alignment: Alignment.center,
            child: Text(r.t1530!, style: _textTableHeader)),
        //17.30
        Container(
            width: 100,
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t6,
            alignment: Alignment.center,
            child: Text(r.t1730!, style: _textTableHeader)),
        //Ext.
        Container(
            width: 100,
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t6,
            alignment: Alignment.center,
            child: Text(r.Ext!, style: _textTableHeader)),
        //total
        Container(
            width: 100,
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t7,
            alignment: Alignment.center,
            child: Text(r.Total!, style: _textTotal)),
        //PAST
        Container(
            width: 100,
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t5,
            alignment: Alignment.center,
            child: Text(r.Past!, style: _textTableHeader)),
        //plan
        Container(
            width: 100,
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t8,
            alignment: Alignment.center,
            child: Text(r.Plan!, style: _textPlan)),
        SizedBox.fromSize(size: const Size(100, 0)),
        //PAST
        Container(
            width: 100,
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t3,
            alignment: Alignment.center,
            child: Text(r.Prod!, style: _textTableHeader)),
        //plan
        Container(
            width: 100,
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t3,
            alignment: Alignment.center,
            child: Text(r.Magaz!, style: _textTableHeader)),
        //perf
        Container(
            width: 130,
            height: rowHeight,
            padding: _standartPadding,
            decoration: _t9,
            alignment: Alignment.center,
            child: Text(r.Pref!, style: _textTableHeader)),
      ],
    );
  }

  Widget _totalRow() {
    return Row(
      children: [
        //line
        Container(
            width: 550,
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(L.tr("Grand total"), style: _textHeader3)),

        //10.30
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.t1030!, style: _textHeader3)),
        //12.30
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.t1230!, style: _textHeader3)),
        //15.30
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.t1530!, style: _textHeader3)),
        //17.30
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.t1730!, style: _textHeader3)),
        //Ext.
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.Ext!, style: _textHeader3)),
        //total
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.Total!, style: _textHeader3)),
        //PAST
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.Past!, style: _textHeader3)),
        //plan
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.Plan!, style: _textHeader3)),
        SizedBox.fromSize(size: const Size(100, 0)),
        //PAST
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.Prod!, style: _textHeader3)),
        //plan
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.Magaz!, style: _textHeader3)),
        //perf
        Container(
            width: 130,
            padding: _standartPadding,
            decoration: _t4,
            alignment: Alignment.center,
            child: Text(_model.totalRow.Pref!, style: _textHeader3)),
      ],
    );
  }
}
