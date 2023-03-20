import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sartex/data/order_row.dart';
import 'package:sartex/screen/orderdoc/orderdoc_bloc.dart';
import 'package:sartex/screen/orderdoc/orderdoc_event.dart';
import 'package:sartex/screen/orderdoc/orderdoc_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/translator.dart';
import '../../widgets/svg_button.dart';
import 'orderdoc_state.dart';

class OrderDocScreen extends EditWidget {
  final OrderDocModel _model = OrderDocModel();

  OrderDocScreen(
      {super.key, required OrderRowDatasource datasource, String? orderId}) {
    _model.orderId = orderId;
    _model.datasource = datasource;
  }

  @override
  Widget build(BuildContext context) {
    var bloc = OrderDocBloc(OrderDocStateNone());
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
                      return _detailsHeader(context,
                          _model.datasource.sizesOfModel[
                                  _model.sizeStandartController.text] ??
                              ['?', '?', '?', '?', '?', '?', '?', '?', '?', '?'],
                          color_header_background);
                    }),
                Expanded(child: Column(
                  children: _orderDetails(context),
                )),
                const Divider(height: 30, color: Colors.transparent),
                saveWidget(context, Object())
              ],
            )));
  }

  Widget _detailsHeader(BuildContext context, List<String> values, Color backgroundColor) {
    const TextStyle ts = TextStyle(color: Colors.white, fontSize: 18);
    const Border border =
        Border.fromBorderSide(BorderSide(color: Colors.black26));
    List<Widget> r = [];
    List<double> columnWidths = [
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
      100,
    ];
    for (int i = 0; i < columnWidths.length; i++) {
      switch (i) {
        case 0:
          r.add(Container(
              height: 30,
              width: columnWidths[i],
              decoration: BoxDecoration(color: backgroundColor, border: border),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(L.tr('Type'), style: ts))));
          break;
        case 1:
          r.add(Container(
              height: 30,
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
              height: 30,
              width: columnWidths[i],
              decoration: BoxDecoration(color: backgroundColor, border: border),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(values[i - 2], style: ts))));
          break;
        case 12:
          r.add(Container(
              height: 30,
              width: columnWidths[i],
              decoration: BoxDecoration(color: backgroundColor, border: border),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(L.tr('Total'), style: ts))));
          break;
        case 13:
          r.add(Container(
              height: 30,
              width: columnWidths[i],
              decoration: BoxDecoration(color: backgroundColor, border: border),
              child: Align(
                  alignment: Alignment.center,
                  child: SvgButton(onTap: (){}, assetPath: 'svg/plus.svg',)))
          );
          break;
      }
    }
    return Padding(
        padding: const EdgeInsets.only(left: 10), child: Row(children: r));
  }

  List<Widget> _orderDetails(BuildContext context) {
    final List<Widget> l = [];
    return l;
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
