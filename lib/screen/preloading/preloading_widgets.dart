import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sartex/data/sql.dart';
import 'package:sartex/screen/preloading/preloading_item.dart';
import 'package:sartex/screen/preloading/preloading_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/svg_button.dart';

class LineDropdownButton extends StatefulWidget {
  final PreloadingModel model;

  LineDropdownButton({super.key, required this.model});

  @override
  State<StatefulWidget> createState() => _LineDropdownButton();
}

class _LineDropdownButton extends State<LineDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        isExpanded: true,
        underline: const SizedBox(),
        hint: Container(
          width: 150, //and here
          child: Text(
            L.tr('Select line'),
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.start,
          ),
        ),
        style: TextStyle(
            color: Colors.black, fontSize: 18 * scale_factor, fontWeight: FontWeight.bold),
        value: widget.model.prLine.prLine,
        items: PreloadingModel.lines.map((s) {
          return DropdownMenuItem<String>(
              value: s,
              child: Text(
                s,
                style: const TextStyle(color: Colors.black),
              ));
        }).toList(),
        onChanged: (s) {
          setState(() {
            widget.model.prLine.prLine = s ?? '';
          });
        });
  }
}

class PreloadingItemsContainer extends StatefulWidget {
  final PreloadingFullItem item;
  PreloadingModel? model;
  final bool showLine1;
  VoidCallback parentState;
  PreloadingItem? editRow;
  bool readOnly = false;

  PreloadingItemsContainer(
      {super.key,
      required this.item,
      required this.showLine1,
      required this.model,
      required this.parentState,
      required this.readOnly});

  @override
  State<StatefulWidget> createState() => _PreloadingItemsContainer();
}

class _PreloadingItemsContainer extends State<PreloadingItemsContainer> {
  final BoxDecoration headerDecor1 = const BoxDecoration(
      color: Colors.black45,
      border: Border.fromBorderSide(BorderSide(width: 0.1)));
  final BoxDecoration headerRedDecor1 = const BoxDecoration(
      color: Colors.redAccent,
      border: Border.fromBorderSide(BorderSide(width: 0.1)));

  final BoxDecoration headerDecor2 = const BoxDecoration(
      color: Colors.yellow,
      border: Border.fromBorderSide(BorderSide(width: 0.1)));
  final BoxDecoration headerDecor3 = const BoxDecoration(
      color: Colors.white,
      border: Border.fromBorderSide(BorderSide(width: 0.1)));
  final BoxDecoration headerDecor4 = const BoxDecoration(
      color: Color(0xffb6f6b6),
      border: Border.fromBorderSide(BorderSide(width: 0.1)));
  final BoxDecoration headerDecor5 = const BoxDecoration(
      color: Color(0xfffdb0b0),
      border: Border.fromBorderSide(BorderSide(width: 0.1)));
  final BoxDecoration headerDecor6 = const BoxDecoration(
      color: Color(0xff9efff0),
      border: Border.fromBorderSide(BorderSide(width: 0.1)));

  final InputDecoration labelDecor = const InputDecoration(
      isDense: true,
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(3, 5, 3, 5));

  final InputDecoration labelRedDecor = const InputDecoration(
      isDense: true,
      border: InputBorder.none,
      fillColor: Colors.deepOrange,
      contentPadding: EdgeInsets.fromLTRB(3, 5, 3, 5));

  final TextStyle headerLeft =  TextStyle(
      color: Colors.black,fontSize: 12, fontWeight: FontWeight.bold, height: 1.5 * scale_factor);
  final EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(4, 5, 5, 5);

  final InputDecoration formDecor1 = const InputDecoration(
      isDense: true,
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10));
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final sizeColWidth = 50.0  * scale_factor;
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          for (var e in widget.item.items) ...[
            const Divider(height: 10, color: Colors.white),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //LEFT SIDE
              //brand
              SizedBox(
                  width: 200 * scale_factor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: padding,
                          decoration: headerDecor1,
                          child: Row(children: [
                            Expanded(
                                child: TextFormField(
                              readOnly: true,
                              decoration: labelDecor,
                              initialValue: L.tr('Brand'),
                              style: headerLeft,
                            ))
                          ])),
                      //model
                      Container(
                          decoration: headerDecor1,
                          child: TextFormField(
                              decoration: formDecor1,
                              controller: e.brand,
                              onTap: widget.model == null
                                  ? null
                                  : () {
                                      valueOfList(
                                          context,
                                          widget.model!.data.brandLevel,
                                          e.brand, done: () {
                                        widget.model!.data.buildModelList(
                                            e.brand.text,
                                            widget.model!.editStore.text);
                                        e.model.clear();
                                        e.commesa.clear();
                                        e.color.clear();
                                        e.variant.clear();
                                        e.country.clear();
                                        for (var sz in e.sizes) {
                                          sz.text = '';
                                        }
                                      });
                                    })),
                    ],
                  )),
              //Model
              SizedBox(
                width: 200 * scale_factor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: padding,
                        decoration: headerDecor1,
                        child: Row(children: [
                          Expanded(
                              child: TextFormField(
                                  readOnly: true,
                                  decoration: labelDecor,
                                  initialValue: L.tr('Model'),
                                  style: headerLeft))
                        ])),
                    Container(
                        decoration: headerDecor1,
                        child: TextFormField(
                          readOnly: true,
                          decoration: formDecor1,
                          controller: e.model
                            ..addListener(() {
                              if (e.model.text.isNotEmpty) {
                                widget.model!.data
                                    .buildCommesaLevel(
                                        e.brand.text,
                                        e.model.text,
                                        widget.model!.editStore.text)
                                    .then((value) {
                                  if (widget.model!.data.commesaLevel.length ==
                                      1) {
                                    e.commesa.text =
                                        widget.model!.data.commesaLevel.first;
                                  }
                                });
                              }
                            }),
                          onTap: widget.model == null
                              ? null
                              : () {
                                  valueOfList(
                                      context,
                                      widget.model!.data.modelLevel,
                                      e.model, done: () {
                                    e.commesa.clear();
                                    e.color.clear();
                                    e.variant.clear();
                                    e.country.clear();
                                    for (var sz in e.sizes) {
                                      sz.clear();
                                    }
                                    for (var rm in e.remains) {
                                      rm.clear();
                                    }
                                    widget.model!.data
                                        .buildCommesaLevel(
                                            e.brand.text,
                                            e.model.text,
                                            widget.model!.editStore.text)
                                        .then((value) {
                                      if (widget.model!.data.commesaLevel
                                              .length ==
                                          1) {
                                        e.commesa.text = widget
                                            .model!.data.commesaLevel.first;
                                      }
                                    });
                                  });
                                },
                        ))
                  ],
                ),
              ),
              //Commesa
              SizedBox(
                  width: 90 * scale_factor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: padding,
                          decoration: headerDecor1,
                          child: Row(children: [
                            Expanded(
                                child: TextFormField(
                                    readOnly: true,
                                    decoration: labelDecor,
                                    initialValue: 'Commesa',
                                    style: headerLeft))
                          ])),
                      Container(
                          decoration: headerDecor1,
                          child: TextFormField(
                              readOnly: true,
                              decoration: formDecor1,
                              controller: e.commesa
                                ..addListener(() {
                                  if (e.commesa.text.isNotEmpty) {
                                    widget.model!.data
                                        .buildCountryLevel(
                                            e.brand.text,
                                            e.model.text,
                                            e.commesa.text,
                                            widget.model!.editStore.text)
                                        .then((value) {
                                      if (widget.model!.data.countryLevel
                                              .length ==
                                          1) {
                                        e.country.text = widget
                                            .model!.data.countryLevel.first;
                                      }
                                    });
                                  }
                                }),
                              onTap: widget.model == null
                                  ? null
                                  : () {
                                      valueOfList(
                                          context,
                                          widget.model!.data.commesaLevel,
                                          e.commesa, done: () {
                                        e.color.clear();
                                        e.variant.clear();
                                        e.country.clear();
                                        for (var sz in e.sizes) {
                                          sz.clear();
                                        }
                                        for (var rm in e.remains) {
                                          rm.clear();
                                        }
                                        widget.model!.data
                                            .buildCountryLevel(
                                                e.brand.text,
                                                e.model.text,
                                                e.commesa.text,
                                                widget.model!.editStore.text)
                                            .then((value) {
                                          if (widget.model!.data.countryLevel
                                                  .length ==
                                              1) {
                                            e.country.text = widget
                                                .model!.data.countryLevel.first;
                                          }
                                        });
                                      });
                                    })),
                    ],
                  )),
              //country
              SizedBox(
                  width: 70 * scale_factor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: padding,
                          decoration: headerDecor1,
                          child: Row(children: [
                            Expanded(
                                child: TextFormField(
                                    readOnly: true,
                                    decoration: labelDecor,
                                    initialValue: L.tr('Country'),
                                    style: headerLeft))
                          ])),
                      Container(
                          decoration: headerDecor1,
                          child: TextFormField(
                              readOnly: true,
                              decoration: formDecor1,
                              controller: e.country
                                ..addListener(() {
                                  if (e.country.text.isNotEmpty) {
                                    widget.model!.data
                                        .buildColorLevel(
                                      e.brand.text,
                                      e.model.text,
                                      e.commesa.text,
                                      e.country.text,
                                      widget.model!.editStore.text,
                                    )
                                        .then((value) {
                                      if (widget
                                              .model!.data.colorLevel.length ==
                                          1) {
                                        e.color.text =
                                            widget.model!.data.colorLevel.first;
                                      }
                                    });
                                  }
                                }),
                              onTap: widget.model == null
                                  ? null
                                  : () {
                                      valueOfList(
                                          context,
                                          widget.model!.data.countryLevel,
                                          e.country, done: () {
                                        e.color.clear();
                                        e.variant.clear();
                                        for (var sz in e.sizes) {
                                          sz.clear();
                                        }
                                        for (var rm in e.remains) {
                                          rm.clear();
                                        }
                                        widget.model!.data
                                            .buildColorLevel(
                                                e.brand.text,
                                                e.model.text,
                                                e.commesa.text,
                                                e.country.text,
                                                widget.model!.editStore.text)
                                            .then((value) {
                                          if (widget.model!.data.colorLevel
                                                  .length ==
                                              1) {
                                            e.color.text = widget
                                                .model!.data.colorLevel.first;
                                          }
                                        });
                                      });
                                    })),
                    ],
                  )),
              //Color
              SizedBox(
                  width: 60 * scale_factor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: padding,
                          decoration: headerDecor1,
                          child: Row(children: [
                            Expanded(
                                child: TextFormField(
                                    readOnly: true,
                                    decoration: labelDecor,
                                    initialValue: L.tr('Color'),
                                    style: headerLeft))
                          ])),
                      Container(
                          decoration: headerDecor1,
                          child: TextFormField(
                              decoration: formDecor1,
                              controller: e.color
                                ..addListener(() {
                                  widget.model!.data
                                      .buildVariantLevel(
                                          e.brand.text,
                                          e.model.text,
                                          e.commesa.text,
                                          e.country.text,
                                          e.color.text,
                                          widget.model!.editStore.text)
                                      .then((value) {
                                    if (widget
                                            .model!.data.variantLevel.length ==
                                        1) {
                                      e.variant.text =
                                          widget.model!.data.variantLevel.first;
                                    }
                                  });
                                }),
                              onTap: widget.model == null
                                  ? null
                                  : () {
                                      valueOfList(
                                          context,
                                          widget.model!.data.colorLevel,
                                          e.color, done: () {
                                        e.variant.clear();
                                        for (var sz in e.sizes) {
                                          sz.clear();
                                        }
                                        for (var rm in e.remains) {
                                          rm.clear();
                                        }
                                        widget.model!.data
                                            .buildVariantLevel(
                                                e.brand.text,
                                                e.model.text,
                                                e.commesa.text,
                                                e.country.text,
                                                e.color.text,
                                                widget.model!.editStore.text)
                                            .then((value) {
                                          if (widget.model!.data.variantLevel
                                                  .length ==
                                              1) {
                                            e.variant.text = widget
                                                .model!.data.variantLevel.first;
                                          }
                                        });
                                      });
                                    })),
                    ],
                  )),
              //Variant
              SizedBox(
                  width: 80 * scale_factor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: padding,
                          decoration: headerDecor1,
                          child: Row(children: [
                            Expanded(
                                child: TextFormField(
                                    readOnly: true,
                                    decoration: labelDecor,
                                    initialValue: L.tr('Var.'),
                                    style: headerLeft))
                          ])),
                      Container(
                          decoration: headerDecor1,
                          child: TextFormField(
                              decoration: formDecor1,
                              controller: e.variant
                                ..addListener(() {
                                  if (e.variant.text.isNotEmpty) {
                                    widget.model!.data
                                        .getSizes(
                                            e.brand.text,
                                            e.model.text,
                                            e.commesa.text,
                                            e.country.text,
                                            e.color.text,
                                            e.variant.text,
                                            e,
                                            widget.model!.editStore.text)
                                        .then((value) {});
                                  }
                                }),
                              onTap: widget.model == null
                                  ? null
                                  : () {
                                      valueOfList(
                                          context,
                                          widget.model!.data.variantLevel,
                                          e.variant, done: () {
                                        widget.model!.data
                                            .getSizes(
                                                e.brand.text,
                                                e.model.text,
                                                e.commesa.text,
                                                e.country.text,
                                                e.color.text,
                                                e.variant.text,
                                                e,
                                                widget.model!.editStore.text)
                                            .then((value) {
                                          for (int i = 1; i < 13; i++) {
                                            e.sizes[i - 1].text;
                                          }
                                        });
                                      });
                                    })),
                    ],
                  )),
              //Sizes
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Size Row
                  Row(
                    children: [
                      for (int i = 1; i < 13; i++) ...[
                        //header
                        if (e.remains[i - 1].text.isEmpty)
                          InkWell(
                            onTap: () async {
                              HttpSqlQuery.post({"sl":"select a.apr_id as a, d.apr_id as d from Apranq a "
    "left join Docs d on a.apr_id=d.apr_id and docnum='${widget.model?.docNumber ?? ''}' and type='OUT' "
    "where a.pid in (Select id from patver_data "
                                  "where Brand='${e.brand.text}' and Model='${e.model.text}' and Country='${e.country.text}' and PatverN='${e.commesa.text}' "
                                  "and Colore='${e.color.text}' and variant_prod='${e.variant.text}') "}).then((value) async {
                                for (final eee in value) {
                                  if (eee['d'] == null) {
                                    Map<String, String> bind = {};
                                    bind['branch'] = prefs.getString(key_user_branch)!;
                                    bind['type'] = 'OUT';
                                    bind['mutq_elq'] = 'elq';
                                    bind['date'] = DateFormat('yyyy-MM-dd')
                                        .format(DateFormat('dd/MM/yyyy').parse(widget.model!.editDate.text));
                                    bind['docnum'] = widget.model!.docNumber!;
                                    bind['apr_id'] = eee['a'];
                                    bind['pahest'] = widget.model!.editStore.text;
                                    bind['qanak'] = '0';
                                    bind['status'] = 'draft';
                                    bind['avto'] = widget.model!.editTruck.text;
                                    bind['line'] = widget.item.prLine;
                                    bind['partner'] = widget.model!.editReceipant.text;
                                    String insertSql = Sql.insert('Docs', bind);
                                    await HttpSqlQuery.post({'sl': insertSql});
                                    //appDialog(context, eee['a']);
                                  }
                                }
                              });
                            },
                              child: SizedBox(
                            width: sizeColWidth,
                            child: Container(
                            padding: padding,
                            decoration: e.remains[i - 1].text.isEmpty ? headerRedDecor1 : headerDecor1,
                            child: Row(children: [
                            Expanded(
                            child: TextFormField(
                            textAlign: TextAlign.center,
                            readOnly: true,
                            decoration: labelDecor,
                            controller: e.sizes[i - 1],
                            style: headerLeft))
                          ]))))
                        else
                        SizedBox(
                            width: sizeColWidth,
                            child: Container(
                                padding: padding,
                                decoration: e.remains[i - 1].text.isEmpty ? headerRedDecor1 : headerDecor1,
                                child: Row(children: [
                                  Expanded(
                                      child: TextFormField(
                                          textAlign: TextAlign.center,
                                          readOnly: true,
                                          decoration: labelDecor,
                                          controller: e.sizes[i - 1],
                                          style: headerLeft))
                                ]))),
                      ],
                      SizedBox(
                          width: 100 * scale_factor,
                          child: Container(
                              padding: padding,
                              decoration: headerDecor1,
                              child: Row(children: [
                                Expanded(
                                    child: TextFormField(
                                        textAlign: TextAlign.center,
                                        readOnly: true,
                                        decoration: labelDecor,
                                        controller: e.sizes[e.sizes.length - 1],
                                        style: headerLeft))
                              ]))),
                    ],
                  ),
                  //Remain row
                  widget.showLine1
                      ? Row(
                          children: [
                            for (int i = 1; i < 13; i++) ...[
                              SizedBox(
                                  width: sizeColWidth,
                                  child: Container(
                                      decoration: headerDecor2,
                                      child: Row(children: [
                                        Expanded(
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                          onTap: () {
                                            e.newvalues[i - 1].text =
                                                e.remains[i - 1].text;
                                            e.newvalues[e.newvalues.length - 1]
                                                .text = e.sumOfNewValues();
                                          },
                                          readOnly: true,
                                          decoration: formDecor1,
                                          controller: e.remains[i - 1],
                                          style: headerLeft,
                                        ))
                                      ]))),
                            ],
                            SizedBox(
                                width: 100 * scale_factor,
                                child: Container(
                                    decoration: headerDecor2,
                                    child: Row(children: [
                                      Expanded(
                                          child: TextFormField(
                                              textAlign: TextAlign.center,
                                              onTap: () {
                                                for (int i = 0;
                                                    i < e.remains.length - 2;
                                                    i++) {
                                                  e.newvalues[i].text =
                                                      e.remains[i].text;
                                                }
                                                e
                                                    .newvalues[
                                                        e.newvalues.length - 1]
                                                    .text = e.sumOfNewValues();
                                              },
                                              readOnly: true,
                                              decoration: formDecor1,
                                              controller: e.remains[
                                                  e.remains.length - 1],
                                              style: headerLeft))
                                    ]))),
                          ],
                        )
                      : Container(),
                  //Input row
                  Row(
                    children: [
                      for (int i = 1; i < 13; i++) ...[
                        SizedBox(
                            width: sizeColWidth,
                            child: Container(
                                decoration: headerDecor3,
                                child: Row(children: [
                                  Expanded(
                                      child: TextFormField(
                                          textAlign: TextAlign.center,
                                          readOnly: !widget.showLine1 &&
                                              e != widget.editRow,
                                          onChanged: (text) {
                                            if (widget.editRow == null) {
                                              int newvalue =
                                                  int.tryParse(text) ?? 0;
                                              int remain = int.tryParse(
                                                      e.remains[i - 1].text) ??
                                                  0;
                                              if (newvalue > remain) {
                                                e.newvalues[i - 1].clear();
                                              }
                                              e
                                                  .newvalues[
                                                      e.newvalues.length - 1]
                                                  .text = e.sumOfNewValues();
                                            }
                                          },
                                          decoration: formDecor1,
                                          controller: e.newvalues[i - 1],
                                          style: headerLeft))
                                ]))),
                      ],
                      SizedBox(
                          width: 100 * scale_factor,
                          child: Container(
                              decoration: headerDecor3,
                              child: Row(children: [
                                Expanded(
                                    child: TextFormField(
                                        textAlign: TextAlign.center,
                                        readOnly: true,
                                        decoration: formDecor1,
                                        controller:
                                            e.newvalues[e.newvalues.length - 1],
                                        style: headerLeft))
                              ]))),
                    ],
                  ),
                  //Pahest row
                  Row(
                    children: [
                      for (int i = 1; i < 13; i++) ...[
                        SizedBox(
                            width: sizeColWidth,
                            child: Container(
                                decoration: headerDecor4,
                                child: Row(children: [
                                  Expanded(
                                      child: TextFormField(
                                          textAlign: TextAlign.center,
                                          readOnly: true,
                                          decoration: formDecor1,
                                          controller: e.pahest[i - 1],
                                          style: headerLeft))
                                ]))),
                      ],
                      SizedBox(
                          width: 100 * scale_factor,
                          child: Container(
                              decoration: headerDecor4,
                              child: Row(children: [
                                Expanded(
                                    child: TextFormField(
                                        textAlign: TextAlign.center,
                                        readOnly: true,
                                        decoration: formDecor1,
                                        controller:
                                            e.pahest[e.pahest.length - 1]
                                              ..text = e.sumOfList(e.pahest),
                                        style: headerLeft))
                              ]))),
                    ],
                  ),
                  //Diff row
                  widget.showLine1
                      ? Container()
                      : Row(
                          children: [
                            for (int i = 1; i < 13; i++) ...[
                              SizedBox(
                                  width: sizeColWidth,
                                  child: Container(
                                      decoration:
                                          (int.tryParse(e.pahest[i - 1].text) ??
                                                          0) -
                                                      (int.tryParse(e
                                                              .newvalues[i - 1]
                                                              .text) ??
                                                          0) <
                                                  0
                                              ? headerDecor5
                                              : headerDecor4,
                                      child: Row(children: [
                                        Expanded(
                                            child: TextFormField(
                                                textAlign: TextAlign.center,
                                                readOnly: true,
                                                decoration: formDecor1,
                                                initialValue: ((int.tryParse(e
                                                                .pahest[i - 1]
                                                                .text) ??
                                                            0) -
                                                        (int.tryParse(e
                                                                .newvalues[
                                                                    i - 1]
                                                                .text) ??
                                                            0))
                                                    .toString(),
                                                //controller: e.diff[i - 1],
                                                style: headerLeft))
                                      ]))),
                            ],
                            SizedBox(
                                width: 100 * scale_factor,
                                child: Container(
                                    decoration: (int.tryParse(e
                                                        .pahest[
                                                            e.pahest.length - 1]
                                                        .text) ??
                                                    0) -
                                                (int.tryParse(e
                                                        .newvalues[
                                                            e.newvalues.length -
                                                                1]
                                                        .text) ??
                                                    0) <
                                            0
                                        ? headerDecor5
                                        : headerDecor4,
                                    child: Row(children: [
                                      Expanded(
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                              readOnly: true,
                                              decoration: formDecor1,
                                              controller: e.diff[e.diff.length - 1]
                                                ..text = ((int.tryParse(e
                                                                .pahest[
                                                                    e.pahest.length -
                                                                        1]
                                                                .text) ??
                                                            0) -
                                                        (int.tryParse(e
                                                                .newvalues[e
                                                                        .newvalues
                                                                        .length -
                                                                    1]
                                                                .text) ??
                                                            0))
                                                    .toString(),
                                              style: headerLeft))
                                    ]))),
                          ],
                        ),

                  ///NOH_YED - DOCS.YANAK
                  widget.showLine1
                      ? Container()
                      : widget.model!.showMnac ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < 13; i++) ...[
                              Container(
                                  width: (i == 12 ? 100 : sizeColWidth) * scale_factor,
                                  child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: headerDecor6,
                                      child: Text(
                                        i < 12 ? e.mnac[i] : e.sumOfMnac(),
                                        textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)
                                      )))
                            ]
                          ],
                        ) : Container()
                ],
              ),
              //RemoveButton
              if (prefs.roleWrite('2') && !widget.readOnly)
                SizedBox(
                    width: 85 * scale_factor,
                    height: 115,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: padding,
                              decoration: headerDecor1,
                              child: Column(children: [
                                SvgButton(
                                  width: 40 * scale_factor,
                                  darkMode: false,
                                  onTap: () {
                                    appDialogYesNo(
                                        context, L.tr('Confirm to remove row'),
                                        () {
                                      if (widget.showLine1) {
                                        widget.item.items.remove(e);
                                        setState(() {});
                                      } else {
                                        var aprIds = '';
                                        var prodIds = '';
                                        for (final f in widget.item.items) {
                                          for (int i = 0; i < 12; i++) {
                                            int aprId = int.tryParse(
                                                    f.preSize?.aprIdOf(i) ??
                                                        '') ??
                                                0;
                                            int prodId = int.tryParse(
                                                    f.preSize?.prodIdOf(i) ??
                                                        '') ??
                                                0;
                                            if (prodId > 0) {
                                              if (prodIds.isNotEmpty) {
                                                prodIds += ",";
                                              }
                                              prodIds += prodId.toString();
                                            }
                                          }
                                        }
                                        if (prodIds.isEmpty) {
                                          prodIds = '-1';
                                        }
                                        HttpSqlQuery.post({
                                          'sl': "select pd.brand, pd.Model, pd.ModelCod, a.size, d.qanak "
                                              "from Docs d "
                                              "left join Apranq a on a.apr_id=d.apr_id "
                                              "left join patver_data pd on pd.id=a.pid "
                                              "where d.id in($prodIds) and d.status='ok'"
                                        }).then((value) {
                                          if (value.isEmpty) {
                                            HttpSqlQuery.post({
                                              'sl':
                                                  " delete from Docs where id in ($prodIds)"
                                            });
                                            widget.item.items.remove(e);
                                            if (widget.item.items.isEmpty) {
                                              widget.model?.prReadyLines
                                                  .remove(widget.item);
                                              widget.parentState();
                                            } else {
                                              setState(() {});
                                            }
                                          } else {
                                            Widget w = Column(children: [
                                              Row(children: [
                                                SizedBox(
                                                    width: 100 * scale_factor,
                                                    child: Text(L.tr('Size'))),
                                                SizedBox(
                                                    width: 100 * scale_factor,
                                                    child:
                                                        Text(L.tr('Quantity')))
                                              ]),
                                              for (final e in value) ...[
                                                Row(children: [
                                                  SizedBox(
                                                      width: 100 * scale_factor,
                                                      child: Text(e['size'])),
                                                  SizedBox(
                                                      width: 100 * scale_factor,
                                                      child: Text(e['qanak']))
                                                ])
                                              ]
                                            ]);
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return SimpleDialog(
                                                      alignment:
                                                          Alignment.center,
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      title: Text(L.tr(
                                                          'Cannot remove this row with OK status')),
                                                      children: [w]);
                                                });
                                          }
                                        });
                                      }
                                    }, null);
                                  },
                                  assetPath: 'svg/delete.svg',
                                ),
                                SvgButton(
                                    width: 40 * scale_factor,
                                    darkMode: false,
                                    onTap: () {
                                      setState(() {
                                        if (widget.editRow == null) {
                                          widget.editRow = e;
                                        } else {
                                          widget.model!.save(e);
                                          widget.editRow = null;
                                        }
                                      });
                                    },
                                    assetPath: widget.editRow == null
                                        ? 'svg/edit.svg'
                                        : 'svg/save.svg')
                              ]))
                        ])),
            ])
          ]
        ],
      ),
    );
  }
}
