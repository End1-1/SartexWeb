import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sartex/data/data_product.dart';
import 'package:sartex/data/order_row.dart';
import 'package:sartex/screen/orderdoc/orderdoc_bloc.dart';
import 'package:sartex/screen/orderdoc/orderdoc_event.dart';
import 'package:sartex/screen/orderdoc/orderdoc_header.dart';
import 'package:sartex/screen/orderdoc/orderdoc_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:uuid/uuid.dart';

import '../../data/sql.dart';
import '../../utils/translator.dart';
import '../../widgets/svg_button.dart';
import 'orderdoc_state.dart';

class OrderDocScreen extends EditWidget {
  final List<double> columnWidths = [
    200,
    100,
    50,
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
    80,
    80,
    100,
    120,
  ];

  final OrderDocModel model = OrderDocModel();

  OrderDocScreen(
      {super.key, required OrderRowDatasource datasource, String? orderId}) {
    model.orderId = orderId;
    model.datasource = datasource;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderDocBloc>(
        create: (_) => OrderDocBloc(OrderDocStateNone())
          ..add(model.orderId!.isEmpty
              ? OrderDocEventIdle()
              : OrderDocEventOpen(model.orderId!)),
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocListener<OrderDocBloc, OrderDocState>(
                    listener: (context, state) {
                      if (state is OrderDocStateLoaded) {
                        if (state.details.isNotEmpty) {
                          model.brandController.removeListener(() {});
                          model.modelController.removeListener(() {});
                          final OrderRow or = state.details.first;
                          model.orderIdController.text = or.PatverN ?? '???';
                          model.dateCreateController.text =
                              DateFormat('dd/MM/yyyy').format(
                                  DateFormat('yyyy-MM-dd').parse(or.date ??
                                      DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now())));
                          model.dateForController.text =
                              DateFormat('dd/MM/yyyy').format(
                                  DateFormat('yyyy-MM-dd').parse(
                                      or.PatverDate ??
                                          DateFormat('yyyy-MM-dd')
                                              .format(DateTime.now())));
                          model.brandController.text = or.brand ?? '';
                          model.modelCodeController.text = or.ModelCod ?? '';
                          model.modelController.text = or.Model ?? '';
                          model.sizeStandartController.text =
                              or.size_standart ?? '';
                          model.executorController.text = or.Katarox ?? '';
                          model.countryController.text = or.country ?? '';
                        }
                      }
                    },
                    child: Container()),
                for (var e in header(context)) ...[e],
                const Divider(height: 30, color: Colors.transparent),
                BlocBuilder<OrderDocBloc, OrderDocState>(
                    buildWhen: (previos, current) =>
                        current is OrderDocStateSizes,
                    builder: (context, state) {
                      model.sizesOfModel.clear();
                      if (state is OrderDocStateSizes) {
                        model.sizesOfModel.addAll(state.sizes);
                      }
                      if (model.sizesOfModel.isEmpty) {
                        model.sizesOfModel.addAll([
                          '?',
                          '?',
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
                      }
                      return _detailsHeader(context, model.sizesOfModel);
                    }),
                Expanded(
                  child: BlocBuilder<OrderDocBloc, OrderDocState>(
                      buildWhen: (previous, current) =>
                          current is OrderDocStateNewRow ||
                          current is OrderDocSubRowState ||
                          current is OrderDocStateLoaded,
                      builder: (context, state) {
                        if (state is OrderDocStateLoaded) {
                          model.details.clear();
                          model.details.addAll(state.details);
                        }
                        return SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _orderDetails(context, state)));
                      }),
                ),
                const Divider(height: 30, color: Colors.transparent),
                saveWidget(context, Object())
              ],
            )));
  }

  Widget _detailsHeader(BuildContext context, List<String> values) {
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
                alignment: Alignment.center, child: Text("+/-", style: ts)),
          ));
          break;
        case 2:
          r.add(Container(
              height: rowheight,
              width: columnWidths[i],
              decoration: decoration,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(L.tr('Color'), style: ts))));
          break;
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
          r.add(Container(
              height: rowheight,
              width: columnWidths[i],
              decoration: decoration,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(values[i - 3], style: ts))));
          break;
        case 15:
          r.add(Container(
              height: rowheight,
              width: columnWidths[i],
              decoration: decoration,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(L.tr('Total'), style: ts))));
          break;
        case 16:
          r.add(Container(
              height: rowheight,
              width: columnWidths[i],
              decoration: decoration,
              child: Align(
                  alignment: Alignment.center,
                  child: SvgButton(
                    onTap: () {
                      model.details.add(OrderRow(
                          main: '0',
                          id: '',
                          branch: 'branch',
                          action: 'add',
                          User: 'User',
                          date: model.dateCreateController.text,
                          IDPatver: model.orderId,
                          status: 'inProgress',
                          PatverN: model.orderIdController.text,
                          PatverDate: model.dateCreateController.text,
                          parent_id: '0',
                          Katarox: model.executorController.text,
                          Patviratu: '',
                          Model: model.modelController.text,
                          ModelCod: model.modelCodeController.text,
                          brand: model.brandController.text,
                          short_code: '',
                          size_standart: model.sizeStandartController.text,
                          country: model.countryController.text,
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
                          Size11: '',
                          Size12: '',
                          Total: '0',
                          discarded: '',
                          appended: ''));
                      model.rowEditMode = model.details.length - 1;
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
        padding: const EdgeInsets.only(left: 10, bottom: 2),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: r));
  }

  Color bgColor(OrderRow or) {
    if (or.id.isEmpty) {
      if (or.action == 'cancel') {
        return const Color(0xffefb6b6);
      }
      return const Color(0xffcccccc);
    }
    if (or.main == '0') {
      return const Color(0xff4c6b8b);
    }
    if (or.action == 'add') {
      return const Color(0xffcccccc);
    }
    return const Color(0xffefb6b6);
  }

  List<Widget> _orderDetails(BuildContext context, OrderDocState state) {
    const EdgeInsets padding = EdgeInsets.all(0);
    const TextStyle ts = TextStyle(color: Colors.white, fontSize: 18);
    const Border border =
        Border.fromBorderSide(BorderSide(color: Color(0x00cccccc), width: 0.3));
    const double rowheight = 40;
    final List<Widget> l = [];

    String showRow = state is OrderDocSubRowState ? state.row : '';

    for (int i = 0; i < model.details.length; i++) {
      final OrderRow or = model.details[i];
      if (or.id.isNotEmpty) {
        if (showRow.isNotEmpty) {
          if (showRow != or.parent_id && or.main != '0') {
            continue;
          }
        } else {
          if (or.main == '1') {
            continue;
          }
          if (or.parent_id != or.id) {
            continue;
          }
        }
      }
      List<Widget> onerow = [];

      for (int j = 0; j < columnWidths.length; j++) {
        final Color bgcolor = bgColor(or);
        final fontColor = bgcolor.value == const Color(0xff4c6b8b).value
            ? const Color(0xffffffff)
            : const Color(0xff4c6b8b);
        final TextStyle ts = TextStyle(color: fontColor, fontSize: 18);

        final BoxDecoration boxDecoration =
            BoxDecoration(color: bgcolor, border: border);
        if (i == model.rowEditMode) {
          model.detailsControllers[0].text = or.variant_prod!;
          model.detailsControllers[0].selection = TextSelection.fromPosition(
              TextPosition(offset: or.variant_prod!.length));
          model.detailsControllers[2].text = or.Colore!;
          model.detailsControllers[2].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Colore!.length));
          model.detailsControllers[3].text = or.Size01!;
          model.detailsControllers[3].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size01!.length));
          model.detailsControllers[4].text = or.Size02!;
          model.detailsControllers[4].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size02!.length));
          model.detailsControllers[5].text = or.Size03!;
          model.detailsControllers[5].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size03!.length));
          model.detailsControllers[6].text = or.Size04!;
          model.detailsControllers[6].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size04!.length));
          model.detailsControllers[7].text = or.Size05!;
          model.detailsControllers[7].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size05!.length));
          model.detailsControllers[8].text = or.Size06!;
          model.detailsControllers[8].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size06!.length));
          model.detailsControllers[9].text = or.Size07!;
          model.detailsControllers[9].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size07!.length));
          model.detailsControllers[10].text = or.Size08!;
          model.detailsControllers[10].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size08!.length));
          model.detailsControllers[11].text = or.Size09!;
          model.detailsControllers[11].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size09!.length));
          model.detailsControllers[12].text = or.Size10!;
          model.detailsControllers[12].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size10!.length));
          model.detailsControllers[13].text = or.Size11!;
          model.detailsControllers[13].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size11!.length));
          model.detailsControllers[14].text = or.Size12!;
          model.detailsControllers[14].selection = TextSelection.fromPosition(
              TextPosition(offset: or.Size12!.length));
        }

        switch (j) {
          case 0:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          model.details[i] = or.copyWith(variant_prod: text);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        controller: model.detailsControllers[j],
                      )
                    : Text(or.main == '0' ? or.variant_prod! : or.date!,
                        textAlign: TextAlign.center, style: ts)));
            break;
          case 1:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: Text(or.action == "add" ? "+" : "-",
                    textAlign: TextAlign.center, style: ts)));
            break;
          case 2:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          model.details[i] = or.copyWith(Colore: text);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        controller: model.detailsControllers[j])
                    : Text(or.Colore!,
                        textAlign: TextAlign.center, style: ts)));
            break;
          case 3:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          model.details[i] = or.copyWith(Size01: text);
                          model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: model.detailsControllers[j])
                    : Text(or.Size01!,
                        textAlign: TextAlign.center, style: ts)));
            break;
          case 4:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          model.details[i] = or.copyWith(Size02: text);
                          model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: model.detailsControllers[j],
                      )
                    : Text(or.Size02!,
                        textAlign: TextAlign.center, style: ts)));
            break;
          case 5:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          model.details[i] = or.copyWith(Size03: text);
                          model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: model.detailsControllers[j],
                      )
                    : Text(or.Size03!,
                        textAlign: TextAlign.center, style: ts)));
            break;
          case 6:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          model.details[i] = or.copyWith(Size04: text);
                          model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: model.detailsControllers[j],
                      )
                    : Text(or.Size04!,
                        textAlign: TextAlign.center, style: ts)));
            break;
          case 7:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          model.details[i] = or.copyWith(Size05: text);
                          model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: model.detailsControllers[j],
                      )
                    : Text(or.Size05!,
                        textAlign: TextAlign.center, style: ts)));
            break;
          case 8:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          model.details[i] = or.copyWith(Size06: text);
                          model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: model.detailsControllers[j],
                      )
                    : Text(or.Size06!,
                        textAlign: TextAlign.center, style: ts)));
            break;
          case 9:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          model.details[i] = or.copyWith(Size07: text);
                          model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: model.detailsControllers[j],
                      )
                    : Text(or.Size07!,
                        textAlign: TextAlign.center, style: ts)));
            break;
          case 10:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          model.details[i] = or.copyWith(Size08: text);
                          model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: model.detailsControllers[j],
                      )
                    : Text(or.Size08!,
                        textAlign: TextAlign.center, style: ts)));
            break;
          case 11:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          model.details[i] = or.copyWith(Size09: text);
                          model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: model.detailsControllers[j],
                      )
                    : Text(or.Size09!,
                        textAlign: TextAlign.center, style: ts)));
            break;
          case 12:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          model.details[i] = or.copyWith(Size10: text);
                          model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: model.detailsControllers[j],
                      )
                    : Text(or.Size10!,
                        textAlign: TextAlign.center, style: ts)));
            break;
          case 13:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          model.details[i] = or.copyWith(Size11: text);
                          model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: model.detailsControllers[j],
                      )
                    : Text(or.Size11!,
                        textAlign: TextAlign.center, style: ts)));
            break;
          case 14:
            onerow.add(Container(
                alignment: Alignment.center,
                padding: padding,
                height: rowheight,
                width: columnWidths[j],
                decoration: boxDecoration,
                child: model.rowEditMode == i
                    ? TextFormField(
                        onChanged: (text) {
                          model.details[i] = or.copyWith(Size12: text);
                          model.countTotalOfDetailsRow(i);
                          BlocProvider.of<OrderDocBloc>(context)
                              .add(OrderDocNewRow());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: model.detailsControllers[j],
                      )
                    : Text(or.Size12!,
                        textAlign: TextAlign.center, style: ts)));
            break;
          case 15:
            onerow.add(BlocBuilder<OrderDocBloc, OrderDocState>(
              builder: (context, state) {
                return Container(
                    alignment: Alignment.center,
                    padding: padding,
                    height: rowheight,
                    width: columnWidths[j],
                    decoration: boxDecoration,
                    child: Text(or.Total!,
                        textAlign: TextAlign.center, style: ts));
              },
            ));
            break;
          case 16:
            if (i == model.rowEditMode) {
              onerow.add(Container(
                  alignment: Alignment.center,
                  padding: padding,
                  height: rowheight,
                  width: columnWidths[j],
                  decoration: boxDecoration,
                  child: SvgButton(
                    onTap: () {
                      model.rowEditMode = -1;
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
                  child: or.main == '1'
                      ? Container()
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              or.id.isEmpty
                                  ? SizedBox(
                                      height: rowheight,
                                      child: SvgButton(
                                          onTap: () {
                                            model.rowEditMode = i;
                                            BlocProvider.of<OrderDocBloc>(
                                                    context)
                                                .add(OrderDocNewRow());
                                          },
                                          assetPath: 'svg/edit.svg',
                                          darkMode: false))
                                  : SizedBox(
                                      height: rowheight,
                                      child: SvgButton(
                                          width: 20,
                                          onTap: () {
                                            OrderRow r = or.copyWith(
                                                id: '',
                                                date: DateFormat('dd/MM/yyyy')
                                                    .format(DateTime.now()),
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
                                                Size11: '',
                                                Size12: '',
                                                Colore: or.Colore,
                                                parent_id: or.id,
                                                variant_prod: or.variant_prod);
                                            model.details.insert(i + 1, r);
                                            model.rowEditMode = i + 1;
                                            BlocProvider.of<OrderDocBloc>(
                                                    context)
                                                .add(OrderDocNewRow());
                                          },
                                          assetPath: 'svg/plus.svg',
                                          darkMode: false)),
                              SizedBox(
                                  height: rowheight,
                                  child: SvgButton(
                                      width: 20,
                                      onTap: () {
                                        if (or.id.isEmpty) {
                                          model.details.removeAt(i);
                                          model.rowEditMode = -1;
                                        } else {
                                          model.details.insert(
                                              i + 1,
                                              or.copyWith(
                                                  main: '',
                                                  id: '',
                                                  action: 'cancel',
                                                  parent_id: or.id,
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
                                                  Size11: '',
                                                  Size12: '',
                                                  Colore: or.Colore,
                                                  variant_prod:
                                                      or.variant_prod));
                                          model.rowEditMode = i + 1;
                                        }
                                        BlocProvider.of<OrderDocBloc>(context)
                                            .add(OrderDocNewRow());
                                      },
                                      assetPath: 'svg/minus.svg',
                                      darkMode: false)),
                              SizedBox(
                                  height: rowheight,
                                  child: SvgButton(
                                      width: 20,
                                      onTap: () {
                                        BlocProvider.of<OrderDocBloc>(context)
                                            .add(OrderDocSubRow(
                                                row: showRow.isEmpty ||
                                                        or.parent_id != showRow
                                                    ? or.id
                                                    : ''));
                                      },
                                      assetPath: 'svg/eye.svg',
                                      darkMode: false))
                            ])));
            }
            break;
        }
      }

      l.add(Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 2),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: onerow)));
    }

    if (state is OrderDocStateLoaded) {
      BlocProvider.of<OrderDocBloc>(context).add(OrderDocModelChanged(model.sizeStandartController.text));
    }
    return l;
  }

  @override
  Future<void> save(BuildContext context, String table, Object? o) async {
    List<String> error = [];
    String uuid;
    bool isNew = false;
    if (model.orderId == null || model.orderId!.isEmpty) {
      uuid = const Uuid().v1();
      isNew = true;
    } else {
      uuid = model.orderId!;
    }
    if (model.orderIdController.text.isEmpty) {
      error.add(L.tr('Order id cannot be empty'));
    }
    if (model.executorController.text.isEmpty) {
      error.add(L.tr('Select executor'));
    }
    if (model.brandController.text.isEmpty) {
      error.add(L.tr('Select brand'));
    }
    if (model.modelController.text.isEmpty) {
      error.add(L.tr('Select model'));
    }
    if (error.isNotEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(children: [
              for (var s in error)
                Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: Text(s, style: const TextStyle(fontSize: 18))),
              const SizedBox(height: 30),
              Padding(
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                  child: OutlinedButton(
                      style: outlined_button_style,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(L.tr('Close'))))
            ]);
          });
      return;
    }
    model.rowEditMode = -1;
    for (var e in model.details) {
      // if (e.main == '0') {
      //   continue;
      // }
      OrderRow or = e.copyWith(
        branch: prefs.getString(key_user_branch) ?? 'Unknown',
        brand: model.brandController.text,
        Patviratu: '',
        date: isNew
            ? DateFormat('yyyy-MM-dd').format(
                DateFormat('dd/MM/yyyy').parse(model.dateCreateController.text))
            : DateFormat('yyyy-MM-dd').format(DateTime.now()),
        PatverDate: DateFormat('yyyy-MM-dd').format(
            DateFormat('dd/MM/yyyy').parse(model.dateCreateController.text)),
        IDPatver: uuid,
        PatverN: model.orderIdController.text,
        Katarox: model.executorController.text,
        Model: model.modelController.text,
        ModelCod: model.modelCodeController.text,
        size_standart: model.sizeStandartController.text,
        Size01: e.Size01!.isEmpty ? '0' : e.Size01,
        Size02: e.Size02!.isEmpty ? '0' : e.Size02,
        Size03: e.Size03!.isEmpty ? '0' : e.Size03,
        Size04: e.Size04!.isEmpty ? '0' : e.Size04,
        Size05: e.Size05!.isEmpty ? '0' : e.Size05,
        Size06: e.Size06!.isEmpty ? '0' : e.Size06,
        Size07: e.Size07!.isEmpty ? '0' : e.Size07,
        Size08: e.Size08!.isEmpty ? '0' : e.Size08,
        Size09: e.Size09!.isEmpty ? '0' : e.Size09,
        Size10: e.Size10!.isEmpty ? '0' : e.Size10,
        Size11: e.Size11!.isEmpty ? '0' : e.Size11,
        Size12: e.Size12!.isEmpty ? '0' : e.Size12,
      );
      String sql = '';
      Map<String, dynamic> s = or.toJson();
      s.remove('appended');
      s.remove('discarded');
      s.remove('main');
      if (or.id.isEmpty) {
        s.remove('id');
        sql = Sql.insert('patver_data', s);
      } else {
        sql = Sql.update('patver_data', s);
      }
      await HttpSqlQuery.get(sql);
      int index = model.details.indexOf(e);
      model.details[index] = or;
    }
    await appDialog(context, L.tr('Saved'));
    Navigator.pop(context, uuid);
  }

  @override
  String getTable() {
    return "";
  }
}

class AnimatedContainerWithRow extends AnimatedContainer {
  final int row;
  bool show = true;

  AnimatedContainerWithRow(
      {super.key,
      required this.row,
      required super.duration,
      required super.height,
      required super.child,
      super.decoration,
      super.color,
      super.padding});
}
