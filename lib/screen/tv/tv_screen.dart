import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sartex/screen/tv/tv_model.dart';
import 'package:sartex/utils/translator.dart';

class TVScreen extends StatelessWidget {
  final _model = TVModel();
  static const _color1 = Color(0xffd3ffaa);
  final _standartPadding = const EdgeInsets.all(10);
  final _textHeader1 = const TextStyle(color: Colors.white, fontSize: 20);
  final _textHeader2 = const TextStyle(color: Colors.black87, fontSize: 20);
  final _textTableHeader = const TextStyle(
      color: Colors.black87,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      height: 2);
  final _t1 = const BoxDecoration(
      color: Colors.white,
      border: Border.fromBorderSide(BorderSide(color: Colors.black12)));
  final _t2 = const BoxDecoration(
      color: Color(0xffd7e9ff),
      border: Border.fromBorderSide(BorderSide(color: Colors.black12)));
  final _t3 = const BoxDecoration(
      color: _color1,
      border: Border.fromBorderSide(BorderSide(color: Colors.black12)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: StreamBuilder<List<ModelRow>>(
          stream: _model.streamController.stream,
            builder: (context, snapshot) {
      return Column(
        children: [
          _header(),
          _tableHeader(),
          for (var e in snapshot.data ?? []) ... [
            _tableRow(e)
          ]
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
            decoration: const BoxDecoration(color: Color(0xffa1d1fa)),
            child: Text(DateFormat('dd/MM/yyyy').format(DateTime.now()),
                textAlign: TextAlign.center, style: _textHeader2)),
        SizedBox.fromSize(size: const Size(100, 0)),
        Container(
            width: 200,
            padding: _standartPadding,
            decoration: const BoxDecoration(color: _color1),
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
            child: Text(L.tr("Line"), style: _textTableHeader)),
        //brand
        Container(
            width: 200,
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(L.tr("Brand"), style: _textTableHeader)),
        //model
        Container(
            width: 200,
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(L.tr("Model"), style: _textTableHeader)),
        //10.30
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text(L.tr("10:30"), style: _textTableHeader)),
        //12.30
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text(L.tr("12:30"), style: _textTableHeader)),
        //15.30
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text(L.tr("15:30"), style: _textTableHeader)),
        //17.30
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text(L.tr("17:30"), style: _textTableHeader)),
        //Ext.
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text(L.tr("Ext."), style: _textTableHeader)),
        //total
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text(L.tr("Tot."), style: _textTableHeader)),
        //PAST
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text(L.tr("Past"), style: _textTableHeader)),
        //plan
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text(L.tr("Plan"), style: _textTableHeader)),
        SizedBox.fromSize(size: const Size(100, 0)),
        //PAST
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t3,
            alignment: Alignment.center,
            child: Text(L.tr("PROD."), style: _textTableHeader)),
        //plan
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t3,
            alignment: Alignment.center,
            child: Text(L.tr("MAGAZ."), style: _textTableHeader)),
      ],
    );
  }

  Widget _tableRow(ModelRow r) {
    return Row(
      children: [
        //line
        Container(
            width: 150,
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(r.line!, style: _textTableHeader)),
        //brand
        Container(
            width: 200,
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(r.brand!, style: _textTableHeader)),
        //model
        Container(
            width: 200,
            padding: _standartPadding,
            decoration: _t1,
            alignment: Alignment.center,
            child: Text(r.Model!, style: _textTableHeader)),
        //10.30
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text(r.t1030!, style: _textTableHeader)),
        //12.30
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text(r.t1230!, style: _textTableHeader)),
        //15.30
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text(r.t1530!, style: _textTableHeader)),
        //17.30
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text(r.t1730!, style: _textTableHeader)),
        //Ext.
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text(r.Ext!, style: _textTableHeader)),
        //total
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text(r.Total!, style: _textTableHeader)),
        //PAST
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text(r.Past!, style: _textTableHeader)),
        //plan
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t2,
            alignment: Alignment.center,
            child: Text(r.Plan!, style: _textTableHeader)),
        SizedBox.fromSize(size: const Size(100, 0)),
        //PAST
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t3,
            alignment: Alignment.center,
            child: Text(r.Prod!, style: _textTableHeader)),
        //plan
        Container(
            width: 100,
            padding: _standartPadding,
            decoration: _t3,
            alignment: Alignment.center,
            child: Text(r.Magaz!, style: _textTableHeader)),
      ],
    );
  }
}
