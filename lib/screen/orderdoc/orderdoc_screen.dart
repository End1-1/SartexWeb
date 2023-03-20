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
  Widget build(BuildContext context) {
    var bloc = OrderDocBloc(OrderDocStateNone());
    if (_model.orderId != null && _model.orderId!.isNotEmpty) {
      HttpSqlQuery.postString({'sl' : "select * from patver_data where IDPatver='${_model.orderId}'"}).then((value) {
        OrderRowList orl = OrderRowList.fromJson({'list' : jsonDecode(value)});
        for (var e in orl.list) {
          _model.details.add(e);
        }
        bloc.add(OrderDocLoaded());
      });
    }
    return BlocProvider<OrderDocBloc>(
        create: (_) => bloc,
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(children: [
                  textFieldColumn(
                      context: context,
                      title: 'Order num',
                      textEditingController: _model.orderIdController),
                  textFieldColumn(
                      context: context,
                      title: 'Create date',
                      textEditingController: _model.dateCreateController,
                      onTap: () {
                        _changeDate(context, _model.dateCreateController);
                      }),
                  textFieldColumn(
                      context: context,
                      title: 'Execute date',
                      textEditingController: _model.dateForContrller,
                      onTap: () {
                        _changeDate(context, _model.dateForContrller);
                      })
                ]),
                Row(
                  children: [
                    textFieldColumn(
                        context: context,
                        title: 'Customer',
                        textEditingController: _model.customerController,
                        list: _model.datasource.customers),
                    textFieldColumn(
                        context: context,
                        title: 'Executor',
                        textEditingController: _model.executorController,
                        list: _model.datasource.executors),
                    textFieldColumn(
                        context: context,
                        title: 'Country',
                        textEditingController: _model.countryController),
                  ],
                ),
                Row(
                  children: [
                    textFieldColumn(
                      context: context,
                      title: 'Brand',
                      textEditingController: _model.brandController
                        ..addListener(() {
                          bloc.add(OrderDocBrandChanged());
                        }),
                      list: _model.datasource.shortCodeOfBrand.keys.toList(),
                    ),
                    BlocBuilder<OrderDocBloc, OrderDocState>(
                        buildWhen: (previos, current) =>
                            current is OrderDocStateBrand,
                        builder: (context, state) {
                          _model.shortCodeController.clear();
                          return textFieldColumn(
                              context: context,
                              title: 'Short code',
                              textEditingController: _model.shortCodeController
                                ..addListener(() {
                                  bloc.add(OrderDocShortChanged());
                                }),
                              list: _model
                                  .shortCodeOf(_model.brandController.text));
                        }),
                    BlocListener<OrderDocBloc, OrderDocState>(
                      listenWhen: (previos, current) => current is OrderDocStateLoaded,
                        listener: (context, state) {
                          _model.orderIdController.text = '???';
                    },
                        child: Container()),
                    BlocListener<OrderDocBloc, OrderDocState>(
                        listenWhen: (previose, current) =>
                            current is OrderDocStateShort,
                        listener: (context, state) {
                          if (_model.shortCodeController.text.isEmpty) {
                            _model.modelController.clear();
                            _model.sizeStandartController.clear();
                          } else {
                            _model.modelController.text = _model
                                .datasource
                                .modelAndSizeOfShort[
                                    _model.shortCodeController.text]!
                                .elementAt(0);
                            _model.sizeStandartController.text = _model
                                .datasource
                                .modelAndSizeOfShort[
                                    _model.shortCodeController.text]!
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
                              ],
                          color_header_background);
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
      BuildContext context, List<String> values, Color backgroundColor) {
    const double rowheight = 45;
    const TextStyle ts = TextStyle(color: Colors.white, fontSize: 18);
    const Border border =
        Border.fromBorderSide(BorderSide(color: Colors.black26));
    List<Widget> r = [];
    for (int i = 0; i < columnWidths.length; i++) {
      switch (i) {
        case 0:
          r.add(Container(
              height: rowheight,
              width: columnWidths[i],
              decoration: BoxDecoration(color: backgroundColor, border: border),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(L.tr('Type'), style: ts))));
          break;
        case 1:
          r.add(Container(
              height: rowheight,
              width: columnWidths[i],
              decoration: BoxDecoration(color: backgroundColor, border: border),
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
              decoration: BoxDecoration(color: backgroundColor, border: border),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(values[i - 2], style: ts))));
          break;
        case 12:
          r.add(Container(
              height: rowheight,
              width: columnWidths[i],
              decoration: BoxDecoration(color: backgroundColor, border: border),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(L.tr('Total'), style: ts))));
          break;
        case 13:
          r.add(Container(
              height: rowheight,
              width: columnWidths[i],
              decoration: BoxDecoration(color: backgroundColor, border: border),
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
                          Patviratu: _model.customerController.text,
                          Model: _model.modelController.text,
                          ModelCod: _model.shortCodeController.text,
                          brand: _model.brandController.text,
                          short_code: _model.shortCodeController.text,
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
                          Total: '0'));
                      _model.rowEditMode = _model.details.length - 1;
                      BlocProvider.of<OrderDocBloc>(context)
                          .add(OrderDocNewRow());
                    },
                    assetPath: 'svg/plus.svg',
                  ))));
          break;
      }
    }
    return Padding(
        padding: const EdgeInsets.only(left: 10), child: Row(children: r));
  }

  List<Widget> _orderDetails(BuildContext context) {
    const EdgeInsets padding = EdgeInsets.all(2);
    const TextStyle ts = TextStyle(color: Colors.black, fontSize: 18);
    const Border border =
        Border.fromBorderSide(BorderSide(color: Colors.black26));
    const double rowheight = 40;
    final List<Widget> l = [];
    for (int i = 0; i < _model.details.length; i++) {
      List<Widget> onerow = [];
      for (int j = 0; j < columnWidths.length; j++) {
        final OrderRow or = _model.details[i];
        final Color bgcolor =
            or.action == 'add' ? Colors.black12 : const Color(0xffefb6b6);
        final BoxDecoration boxDecoration =
            BoxDecoration(color: bgcolor, border: border);
        if (i == _model.rowEditMode) {
          _model.detailsControllers[0].text = or.Model!;
          _model.detailsControllers[0].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Model!.length));
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
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: _model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          _model.details[i] = or.copyWith(Model: text);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        controller: _model.detailsControllers[j],
                      )
                    : Text(or.Model!, style: ts)));
            break;
          case 1:
            onerow.add(Container(
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
                    : Text(or.Colore!, style: ts)));
            break;
          case 2:
            onerow.add(Container(
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
                    : Text(or.Size01!, style: ts)));
            break;
          case 3:
            onerow.add(Container(
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
                    : Text(or.Size02!, style: ts)));
            break;
          case 4:
            onerow.add(Container(
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
                    : Text(or.Size03!, style: ts)));
            break;
          case 5:
            onerow.add(Container(
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
                    : Text(or.Size04!, style: ts)));
            break;
          case 6:
            onerow.add(Container(
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
                    : Text(or.Size05!, style: ts)));
            break;
          case 7:
            onerow.add(Container(
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
                    : Text(or.Size06!, style: ts)));
            break;
          case 8:
            onerow.add(Container(
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
                    : Text(or.Size07!, style: ts)));
            break;
          case 9:
            onerow.add(Container(
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
                    : Text(or.Size08!, style: ts)));
            break;
          case 10:
            onerow.add(Container(
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
                    : Text(or.Size09!, style: ts)));
            break;
          case 11:
            onerow.add(Container(
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
                    : Text(or.Size10!, style: ts)));
            break;
          case 12:
            onerow.add(BlocBuilder<OrderDocBloc, OrderDocState>(
              builder: (context, state) {
                return Container(
                    padding: padding,
                    height: rowheight,
                    width: columnWidths[j],
                    decoration: boxDecoration,
                    child: Text(or.Total!, style: ts));
              },
            ));
            break;
          case 13:
            if (i == _model.rowEditMode) {
              onerow.add(Container(
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
                  padding: padding,
                  height: rowheight,
                  width: columnWidths[j],
                  decoration: boxDecoration,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: rowheight,
                            child: SvgButton(
                                onTap: () {
                                  _model.rowEditMode = i;
                                  BlocProvider.of<OrderDocBloc>(context)
                                      .add(OrderDocNewRow());
                                },
                                assetPath: 'svg/edit.svg',
                                darkMode: false)),
                        SizedBox(
                            height: rowheight,
                            child: SvgButton(
                                onTap: () {
                                  _model.details.insert(
                                      i + 1, or.copyWith(action: 'cancel'));
                                  _model.rowEditMode = i + 1;
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
          padding: const EdgeInsets.only(left: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: onerow)));
    }

    return l;
  }

  @override
  void save(BuildContext context, String table, Object? o) {
    List<String> error = [];
    if (_model.orderId == null || _model.orderId!.isEmpty) {
      _model.orderId = Uuid().v1();
    }
    if (_model.orderIdController.text.isEmpty) {
      error.add(L.tr('Order id cannot be empty'));
    }
    _model.rowEditMode = -1;
    for (var e in _model.details) {
      OrderRow or = e.copyWith(
          brand: _model.brandController.text,
          Patviratu: _model.customerController.text,
          date: DateFormat('yyyy-MM-dd').format(
              DateFormat('dd/MM/yyyy').parse(_model.dateCreateController.text)),
          PatverDate: DateFormat('yyyy-MM-dd').format(
              DateFormat('dd/MM/yyyy').parse(_model.dateCreateController.text)),
          IDPatver: _model.orderId,
          Katarox: _model.executorController.text,
          Model: _model.modelController.text,
          ModelCod: _model.shortCodeController.text,
          size_standart: _model.sizeStandartController.text);
      String sql = '';
      if (or.id.isEmpty) {
        Map<String, dynamic> s = or.toJson();
        s.remove('id');
        sql = Sql.insert('patver_data', s);
      } else {
        sql = Sql.update('patver_data', or.toJson());
      }
      HttpSqlQuery.get(sql);
    }
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
