import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sartex/data/order_row.dart';
import 'package:sartex/screen/orderdoc/orderdoc_bloc.dart';
import 'package:sartex/screen/orderdoc/orderdoc_event.dart';
import 'package:sartex/screen/orderdoc/orderdoc_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

import '../../data/sql.dart';
import '../../utils/translator.dart';
import '../../widgets/svg_button.dart';
import 'orderdoc_state.dart';

class OrderDocScreen extends EditWidget {
  final List<double> columnWidths = [
    200,
    100,
    80,
    80,
    80,
    80,
    80,
    80,
    80,
    80,
    80,
    80,
    100,
    120,
  ];

  final OrderDocModel _model = OrderDocModel();

  OrderDocScreen(
      {super.key, required OrderRowDatasource datasource, String? orderId}) {
    _model.orderId = orderId;
    _model.datasource = datasource;
  }

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    var bloc = OrderDocBloc(OrderDocStateNone());
    if (_model.orderId != null && _model.orderId!.isNotEmpty) {
      _model.loadOrder().then((value) => bloc.add(OrderDocLoaded()));
    }
    return BlocProvider<OrderDocBloc>(
        create: (_) => bloc,
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocListener<OrderDocBloc, OrderDocState>(
                    listenWhen: (previos, current) => current is OrderDocStateLoaded,
                    listener: (context, state) {
                      if (_model.details.isNotEmpty) {
                        _model.brandController.removeListener(() { });
                        _model.modelCodController.removeListener(() { });
                        final OrderRow or = _model.details.first;
                        _model.orderIdController.text = or.PatverN ?? '???';
                        _model.dateCreateController.text = DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(or.date ?? DateFormat('yyyy-MM-dd').format(DateTime.now())));
                        _model.dateForController.text = DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(or.PatverDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now())));
                        _model.brandController.text = or.brand ?? '';
                        _model.modelCodController.text = or.ModelCod ?? '';
                        _model.modelController.text = or.Model ?? '';
                        _model.sizeStandartController.text = or.size_standart ?? '';
                        _model.executorController.text = or.Katarox ?? '';
                        _model.countryController.text = or.country ?? '';
                        bloc.add(OrderDocNewRow());
                        bloc.add(OrderDocShortChanged());
                      }
                    },
                    child: Container()),
                Row(children: [
                  textFieldColumn(
                      context: context,
                      title: 'Order num',
                      textEditingController: _model.orderIdController,
                  enabled: _model.orderId!.isEmpty),
                  textFieldColumn(
                      context: context,
                      title: 'Create date',
                      textEditingController: _model.dateCreateController,
                      enabled: _model.orderId!.isEmpty,
                      onTap: _model.orderId!.isEmpty ? () {
                        _changeDate(context, _model.dateCreateController);
                      } : null),
                  textFieldColumn(
                      context: context,
                      title: 'Execute date',
                      textEditingController: _model.dateForController,
                      enabled: _model.orderId!.isEmpty,
                      onTap: _model.orderId!.isEmpty ? () {
                        _changeDate(context, _model.dateForController);
                      } : null,
                  )
                ]),
                Row(
                  children: [
                    textFieldColumn(
                        context: context,
                        title: 'Executor',
                        textEditingController: _model.executorController,
                        enabled: _model.orderId!.isEmpty,
                        list: _model.datasource.executors),
                    textFieldColumn(
                        context: context,
                        title: 'Country',
                        textEditingController: _model.countryController,
                        enabled: _model.orderId!.isEmpty),
                  ],
                ),
                Row(
                  children: [
                    textFieldColumn(
                      context: context,
                      title: 'Brand',
                      textEditingController: _model.brandController
                        ..addListener(_model.orderId!.isEmpty ? () {
                          bloc.add(OrderDocBrandChanged());
                        } : (){print('NO BRAND LISTENER');}),
                      list: _model.orderId!.isEmpty ? _model.datasource.shortCodeOfBrand.keys.toList() : null,
                        enabled: _model.orderId!.isEmpty,
                    ),
                    BlocBuilder<OrderDocBloc, OrderDocState>(
                        buildWhen: (previos, current) =>
                            current is OrderDocStateBrand,
                        builder: (context, state) {
                          _model.modelCodController.clear();
                          return textFieldColumn(
                              context: context,
                              title: 'Model code',
                              textEditingController: _model.modelCodController
                                ..addListener(_model.orderId!.isEmpty ? () {
                                  bloc.add(OrderDocShortChanged());
                                } : (){}),
                              list: _model.orderId!.isEmpty ? _model
                                  .shortCodeOf(_model.brandController.text) : null,
                              enabled: _model.orderId!.isEmpty);
                        }),
                    BlocListener<OrderDocBloc, OrderDocState>(
                        listenWhen: (previose, current) =>
                            current is OrderDocStateShort,
                        listener: (context, state) {
                          if (_model.modelCodController.text.isEmpty) {
                            _model.modelController.clear();
                            _model.sizeStandartController.clear();
                          } else {
                            _model.modelController.text = _model
                                .datasource
                                .modelAndSizeOfShort[
                                    _model.modelCodController.text]!
                                .elementAt(0);
                            _model.sizeStandartController.text = _model
                                .datasource
                                .modelAndSizeOfShort[
                                    _model.modelCodController.text]!
                                .elementAt(1);
                          }
                        },
                        child: Container()),
                    textFieldColumn(
                        context: context,
                        title: 'Model',
                        textEditingController: _model.modelController,
                        list: []),
                    textFieldColumn(
                        context: context,
                        title: 'Size standart',
                        textEditingController: _model.sizeStandartController,
                        list: []),
                  ],
                ),
                const Divider(height: 30, color: Colors.transparent),
                BlocBuilder<OrderDocBloc, OrderDocState>(
                    buildWhen: (previos, current) =>
                        current is OrderDocStateShort,
                    builder: (context, state) {
                      return _detailsHeader(
                          context,
                          _model.datasource.sizesOfModel[
                                  _model.sizeStandartController.text] ??
                              [
                                '?',
                                '?',
                                '?',
                                '?',
                                '?',
                                '?',
                                '?',
                                '?',
                                '?',
                                '?'
                              ]);
                    }),
                Expanded(
                  child: BlocBuilder<OrderDocBloc, OrderDocState>(
                      buildWhen: (previous, current) =>
                          current is OrderDocStateNewRow,
                      builder: (context, state) {
                        return SingleChildScrollView(
                            child: Column(children: _orderDetails(context)));
                      }),
                ),
                const Divider(height: 30, color: Colors.transparent),
                saveWidget(context, Object())
              ],
            )));
  }

  Widget _detailsHeader(
      BuildContext context, List<String> values) {
    const double rowheight = 45;
    const TextStyle ts = TextStyle(color: Colors.white, fontSize: 18);
    const Border border =
        Border.fromBorderSide(BorderSide(color: Color(0x00cccccc)));
    const decoration = BoxDecoration(gradient: bg_gradient, border: border);
    List<Widget> r = [];
    for (int i = 0; i < columnWidths.length; i++) {
      switch (i) {
        case 0:
          r.add(Container(
              height: rowheight,
              width: columnWidths[i],
              decoration: decoration,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(L.tr('Type'), style: ts))));
          break;
        case 1:
          r.add(Container(
              height: rowheight,
              width: columnWidths[i],
              decoration: decoration,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(L.tr('Color'), style: ts))));
          break;
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
          r.add(Container(
              height: rowheight,
              width: columnWidths[i],
              decoration: decoration,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(values[i - 2], style: ts))));
          break;
        case 12:
          r.add(Container(
              height: rowheight,
              width: columnWidths[i],
              decoration: decoration,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(L.tr('Total'), style: ts))));
          break;
        case 13:
          r.add(Container(
              height: rowheight,
              width: columnWidths[i],
              decoration: decoration,
              child: Align(
                  alignment: Alignment.center,
                  child: SvgButton(
                    onTap: () {
                      _model.details.add(OrderRow(
                          id: '',
                          branch: 'branch',
                          action: 'add',
                          User: 'User',
                          date: _model.dateCreateController.text,
                          IDPatver: _model.orderId,
                          status: 'inProgress',
                          PatverN: _model.orderIdController.text,
                          PatverDate: _model.dateCreateController.text,
                          parent_id: '0',
                          Katarox: _model.executorController.text,
                          Patviratu: '',
                          Model: _model.modelController.text,
                          ModelCod: _model.modelCodController.text,
                          brand: _model.brandController.text,
                          short_code: '',
                          size_standart: _model.sizeStandartController.text,
                          country: _model.countryController.text,
                          variant_prod: '',
                          Colore: '',
                          line: '',
                          Size01: '',
                          Size02: '',
                          Size03: '',
                          Size04: '',
                          Size05: '',
                          Size06: '',
                          Size07: '',
                          Size08: '',
                          Size09: '',
                          Size10: '',
                          Total: '0',
                      discarded: '',
                      appended: ''));
                      _model.rowEditMode = _model.details.length - 1;
                      BlocProvider.of<OrderDocBloc>(context)
                          .add(OrderDocNewRow());
                    },
                    assetPath: 'svg/plusfolder.svg',
                  ))));
          break;
      }
    }
    //r.add(const Divider(height: 2, color: Colors.transparent));
    return Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 2), child: Row(children: r));
  }

  List<Widget> _orderDetails(BuildContext context) {
    const EdgeInsets padding = EdgeInsets.all(2);
    const TextStyle ts = TextStyle(color: Colors.white, fontSize: 18);
    const Border border =
        Border.fromBorderSide(BorderSide(color: Color(0x00cccccc), width: 0.3));
    const double rowheight = 40;
    final List<Widget> l = [];
    for (int i = 0; i < _model.details.length; i++) {
      List<Widget> onerow = [];
      for (int j = 0; j < columnWidths.length; j++) {
        final OrderRow or = _model.details[i];
        final Color bgcolor =
            or.id.isEmpty ? const Color(0xffcccccc) : (or.action == 'add' ? const Color(0xff4c6b8b) : const Color(0xffefb6b6));
        final BoxDecoration boxDecoration =
            BoxDecoration(color: bgcolor, border: border);
        if (i == _model.rowEditMode) {
          _model.detailsControllers[0].text = or.variant_prod!;
          _model.detailsControllers[0].selection = TextSelection.fromPosition(
              TextPosition(offset: or.variant_prod!.length));
          _model.detailsControllers[1].text = or.Colore!;
          _model.detailsControllers[1].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Colore!.length));
          _model.detailsControllers[2].text = or.Size01!;
          _model.detailsControllers[2].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size01!.length));
          _model.detailsControllers[3].text = or.Size02!;
          _model.detailsControllers[3].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size02!.length));
          _model.detailsControllers[4].text = or.Size03!;
          _model.detailsControllers[4].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size03!.length));
          _model.detailsControllers[5].text = or.Size04!;
          _model.detailsControllers[5].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size04!.length));
          _model.detailsControllers[6].text = or.Size05!;
          _model.detailsControllers[6].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size05!.length));
          _model.detailsControllers[7].text = or.Size06!;
          _model.detailsControllers[7].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size06!.length));
          _model.detailsControllers[8].text = or.Size07!;
          _model.detailsControllers[8].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size07!.length));
          _model.detailsControllers[9].text = or.Size08!;
          _model.detailsControllers[9].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size08!.length));
          _model.detailsControllers[10].text = or.Size09!;
          _model.detailsControllers[10].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size09!.length));
          _model.detailsControllers[11].text = or.Size10!;
          _model.detailsControllers[11].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size10!.length));
        }
        switch (j) {
          case 0:
            onerow.add(Container(
              alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: _model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          _model.details[i] = or.copyWith(variant_prod: text);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        controller: _model.detailsControllers[j],
                      )
                    : Text(or.variant_prod!, textAlign: TextAlign.center, style: ts)));
            break;
          case 1:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: _model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          _model.details[i] = or.copyWith(Colore: text);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        controller: _model.detailsControllers[j])
                    : Text(or.Colore!, textAlign: TextAlign.center, style: ts)));
            break;
          case 2:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: _model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          _model.details[i] = or.copyWith(Size01: text);
                          _model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _model.detailsControllers[j])
                    : Text(or.Size01!, textAlign: TextAlign.center, style: ts)));
            break;
          case 3:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: _model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          _model.details[i] = or.copyWith(Size02: text);
                          _model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _model.detailsControllers[j],
                      )
                    : Text(or.Size02!, textAlign: TextAlign.center, style: ts)));
            break;
          case 4:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: _model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          _model.details[i] = or.copyWith(Size03: text);
                          _model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _model.detailsControllers[j],
                      )
                    : Text(or.Size03!, textAlign: TextAlign.center, style: ts)));
            break;
          case 5:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: _model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          _model.details[i] = or.copyWith(Size04: text);
                          _model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _model.detailsControllers[j],
                      )
                    : Text(or.Size04!, textAlign: TextAlign.center,  style: ts)));
            break;
          case 6:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: _model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          _model.details[i] = or.copyWith(Size05: text);
                          _model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _model.detailsControllers[j],
                      )
                    : Text(or.Size05!, textAlign: TextAlign.center, style: ts)));
            break;
          case 7:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: _model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          _model.details[i] = or.copyWith(Size06: text);
                          _model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _model.detailsControllers[j],
                      )
                    : Text(or.Size06!, textAlign: TextAlign.center, style: ts)));
            break;
          case 8:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: _model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          _model.details[i] = or.copyWith(Size07: text);
                          _model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _model.detailsControllers[j],
                      )
                    : Text(or.Size07!, textAlign: TextAlign.center, style: ts)));
            break;
          case 9:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: _model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          _model.details[i] = or.copyWith(Size08: text);
                          _model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _model.detailsControllers[j],
                      )
                    : Text(or.Size08!, textAlign: TextAlign.center, style: ts)));
            break;
          case 10:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: _model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          _model.details[i] = or.copyWith(Size09: text);
                          _model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _model.detailsControllers[j],
                      )
                    : Text(or.Size09!, textAlign: TextAlign.center, style: ts)));
            break;
          case 11:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: _model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          _model.details[i] = or.copyWith(Size10: text);
                          _model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _model.detailsControllers[j],
                      )
                    : Text(or.Size10!, textAlign: TextAlign.center, style: ts)));
            break;
          case 12:
            onerow.add(BlocBuilder<OrderDocBloc, OrderDocState>(
              builder: (context, state) {
                return Container(
                    alignment: Alignment.center,
                    padding: padding,
                    height: rowheight,
                    width: columnWidths[j],
                    decoration: boxDecoration,
                    child: Text(or.Total!, textAlign: TextAlign.center, style: ts));
              },
            ));
            break;
          case 13:
            if (i == _model.rowEditMode) {
              onerow.add(Container(
                  alignment: Alignment.center,
                  padding: padding,
                  height: rowheight,
                  width: columnWidths[j],
                  decoration: boxDecoration,
                  child: SvgButton(
                    onTap: () {
                      _model.rowEditMode = -1;
                      BlocProvider.of<OrderDocBloc>(context)
                          .add(OrderDocNewRow());
                    },
                    assetPath: 'svg/save.svg',
                    darkMode: false,
                  )));
            } else {
              onerow.add(Container(
                  alignment: Alignment.center,
                  padding: padding,
                  height: rowheight,
                  width: columnWidths[j],
                  decoration: boxDecoration,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        or.id.isEmpty ? SizedBox(
                            height: rowheight,
                            child: SvgButton(
                                onTap: () {
                                  _model.rowEditMode = i;
                                  BlocProvider.of<OrderDocBloc>(context)
                                      .add(OrderDocNewRow());
                                },
                                assetPath: 'svg/edit.svg',
                                darkMode: false))
                        : SizedBox(
                            height: rowheight,
                            child: SvgButton(
                                onTap: () {
                                  OrderRow r = or.copyWith(id:'', Size01:'', Size02: '', Size03: '', Size04: '', Size05: '', Size06: '', Size07:'', Size08:'', Size09:'', Size10: '', parent_id: or.id, variant_prod: or.variant_prod);
                                  _model.details.insert(i + 1, r);
                                  _model.rowEditMode = i + 1;
                                  BlocProvider.of<OrderDocBloc>(context)
                                      .add(OrderDocNewRow());
                                },
                                assetPath: 'svg/plus.svg',
                                darkMode: false)) ,
                        SizedBox(
                            height: rowheight,
                            child: SvgButton(
                                onTap: () {
                                  if (or.id.isEmpty) {
                                    _model.details.removeAt(i);
                                    _model.rowEditMode = -1;
                                  } else {
                                    _model.details.insert(
                                        i + 1, or.copyWith(action: 'cancel', parent_id: or.id, Size01: '', Size02: '', Size03: '', Size04: '', Size05: '',
                                    Size06: '', Size07: '', Size08: '', Size09:'', Size10: '', variant_prod: or.variant_prod));
                                    _model.rowEditMode = i + 1;
                                  }
                                  BlocProvider.of<OrderDocBloc>(context)
                                      .add(OrderDocNewRow());
                                },
                                assetPath: 'svg/minus.svg',
                                darkMode: false))
                      ])));
            }
            break;
        }
      }
      l.add(Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: onerow)));
    }

    return l;
  }

  @override
  Future<void> save(BuildContext context, String table, Object? o) async {
    List<String> error = [];
    String uuid;
    if (_model.orderId == null || _model.orderId!.isEmpty) {
      uuid = const Uuid().v1();
    } else {
      uuid = _model.orderId!;
    }
    if (_model.orderIdController.text.isEmpty) {
      error.add(L.tr('Order id cannot be empty'));
    }
    if (_model.executorController.text.isEmpty) {
      error.add(L.tr('Select executor'));
    }
    if (_model.brandController.text.isEmpty) {
      error.add(L.tr('Select brand'));
    }
    if (_model.modelController.text.isEmpty) {
      error.add(L.tr('Select model'));
    }
    if (error.isNotEmpty) {
      showDialog(
          context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              children: [
                for (var s in error) Padding(padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: Text(s, style: const TextStyle(fontSize: 18))),
                const SizedBox(height: 30),
                Padding(padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
          child: OutlinedButton(style: outlined_button_style, onPressed: (){Navigator.pop(context);}, child: Text(L.tr('Close'))))
              ]);
        });
      return;
    }
    _model.rowEditMode = -1;
    for (var e in _model.details) {
      OrderRow or = e.copyWith(
          brand: _model.brandController.text,
          Patviratu: '',
          date: DateFormat('yyyy-MM-dd').format(
              DateFormat('dd/MM/yyyy').parse(_model.dateCreateController.text)),
          PatverDate: DateFormat('yyyy-MM-dd').format(
              DateFormat('dd/MM/yyyy').parse(_model.dateCreateController.text)),
          IDPatver: uuid,
          Katarox: _model.executorController.text,
          Model: _model.modelController.text,
          ModelCod: _model.modelCodController.text,
          size_standart: _model.sizeStandartController.text);
      String sql = '';
      Map<String, dynamic> s = or.toJson();
      s.remove('appended');
      s.remove('discarded');
      if (or.id.isEmpty) {
        s.remove('id');
        sql = Sql.insert('patver_data', s);
      } else {
        sql = Sql.update('patver_data', s);
      }
      await HttpSqlQuery.get(sql);
      int index = _model.details.indexOf(e);
      _model.details[index] = or;
    }
    await appDialog(context, L.tr('Saved'));
    Navigator.pop(context, 1);
  }

  @override
  String getTable() {
    return "";
  }

  void _changeDate(BuildContext context, TextEditingController controller) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(children: [
            SizedBox(
                width: 200,
                child: TableCalendar(
                  focusedDay: DateFormat('dd/MM/yyyy').parse(controller.text),
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(const Duration(days: 700)),
                  onDaySelected: (d1, d2) {
                    controller.text = DateFormat('dd/MM/yyyy').format(d1);
                    Navigator.pop(context);
                  },
                ))
          ]);
        });
  }
}
