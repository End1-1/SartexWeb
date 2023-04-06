import 'package:flutter/material.dart';
import 'package:sartex/screen/preloading/preloading_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/translator.dart';

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
          width: 150,                      //and here
          child: Text(
            L.tr('Select line'),
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.start,
          ),
        ),
        style: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        value: widget.model.prLine.prLine,
        items: widget.model.lines.map((s) {
          return DropdownMenuItem<String>(value: s, child: Text(s, style: const TextStyle(color: Colors.black),));
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

  PreloadingItemsContainer(
      {super.key, required this.item, required this.showLine1, this.model});

  @override
  State<StatefulWidget> createState() => _PreloadingItemsContainer();
}

class _PreloadingItemsContainer extends State<PreloadingItemsContainer> {
  final BoxDecoration headerDecor1 = const BoxDecoration(
      color: Colors.black45,
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

  final InputDecoration labelDecor = const InputDecoration(
      isDense: true,
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(3, 5, 3, 5));

  final TextStyle headerLeft = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, height: 1.5);
  final EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(4, 5, 5, 5);

  final InputDecoration formDecor1 = const InputDecoration(
      isDense: true,
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(5, 15, 5, 15));
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
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
                  width: 200,
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
                                        widget.model!.data
                                            .buildModelList(e.brand.text);
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
                width: 200,
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
                          decoration: formDecor1,
                          controller: e.model,
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
                                      sz.text = '';
                                    }
                                    widget.model!.data.buildCommesaLevel(
                                        e.brand.text, e.model.text);
                                  });
                                },
                        ))
                  ],
                ),
              ),
              //Commesa
              SizedBox(
                  width: 100,
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
                                    initialValue: L.tr('Order'),
                                    style: headerLeft))
                          ])),
                      Container(
                          decoration: headerDecor1,
                          child: TextFormField(
                              decoration: formDecor1,
                              controller: e.commesa,
                              onTap: widget.model == null
                                  ? null
                                  : () {
                                      valueOfList(
                                          context,
                                          widget.model!.data.commesaLevel,
                                          e.commesa, done: () {
                                        e.color.clear();
                                        e.variant.clear();
                                        for (var sz in e.sizes) {
                                          sz.text = '';
                                        }
                                        widget.model!.data.buildColorLevel(
                                            e.brand.text,
                                            e.model.text,
                                            e.commesa.text);
                                      });
                                    })),
                    ],
                  )),
              //country
              SizedBox(
                  width: 80,
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
                              controller: e.country)),
                    ],
                  )),
              //Color
              SizedBox(
                  width: 100,
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
                              controller: e.color,
                              onTap: widget.model == null
                                  ? null
                                  : () {
                                      valueOfList(
                                          context,
                                          widget.model!.data.colorLevel,
                                          e.color, done: () {
                                        e.variant.clear();
                                        widget.model!.data.buildVariantLevel(
                                            e.brand.text,
                                            e.model.text,
                                            e.commesa.text,
                                            e.color.text);
                                      });
                                    })),
                    ],
                  )),
              //Variant
              SizedBox(
                  width: 100,
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
                                    initialValue: L.tr('Variant'),
                                    style: headerLeft))
                          ])),
                      Container(
                          decoration: headerDecor1,
                          child: TextFormField(
                              decoration: formDecor1,
                              controller: e.variant,
                              onTap: widget.model == null
                                  ? null
                                  : () {
                                      valueOfList(
                                          context,
                                          widget.model!.data.variantLevel,
                                          e.variant, done: () {
                                        widget.model!.data
                                            .getSizesAndCountry(e.brand.text,
                                                e.model.text, e.commesa.text, e)
                                            .then((value) {
                                          e.country.text =
                                              widget.model!.data.country ?? '';
                                          for (int i = 1; i < 11; i++) {
                                            e.sizes[i - 1].text +=
                                                ' / ${e.preSize!.aprId[i - 1]}';
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
                      for (int i = 1; i < 11; i++) ...[
                        SizedBox(
                            width: 70,
                            child: Container(
                                padding: padding,
                                decoration: headerDecor1,
                                child: Row(children: [
                                  Expanded(
                                      child: TextFormField(
                                          readOnly: true,
                                          decoration: labelDecor,
                                          controller: e.sizes[i - 1],
                                          style: headerLeft))
                                ]))),
                      ],
                      SizedBox(
                          width: 120,
                          child: Container(
                              padding: padding,
                              decoration: headerDecor1,
                              child: Row(children: [
                                Expanded(
                                    child: TextFormField(
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
                            for (int i = 1; i < 11; i++) ...[
                              SizedBox(
                                  width: 70,
                                  child: Container(
                                      decoration: headerDecor2,
                                      child: Row(children: [
                                        Expanded(
                                            child: TextFormField(
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
                                width: 120,
                                child: Container(
                                    decoration: headerDecor2,
                                    child: Row(children: [
                                      Expanded(
                                          child: TextFormField(
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
                  //Pahest row
                  Row(
                    children: [
                      for (int i = 1; i < 11; i++) ...[
                        SizedBox(
                            width: 70,
                            child: Container(
                                decoration: headerDecor4,
                                child: Row(children: [
                                  Expanded(
                                      child: TextFormField(
                                          readOnly: true,
                                          decoration: formDecor1,
                                          controller: e.pahest[i - 1],
                                          style: headerLeft))
                                ]))),
                      ],
                      SizedBox(
                          width: 120,
                          child: Container(
                              decoration: headerDecor4,
                              child: Row(children: [
                                Expanded(
                                    child: TextFormField(
                                        readOnly: true,
                                        decoration: formDecor1,
                                        controller:
                                            e.pahest[e.pahest.length - 1],
                                        style: headerLeft))
                              ]))),
                    ],
                  ),
                  //Input row
                  Row(
                    children: [
                      for (int i = 1; i < 11; i++) ...[
                        SizedBox(
                            width: 70,
                            child: Container(
                                decoration: headerDecor3,
                                child: Row(children: [
                                  Expanded(
                                      child: TextFormField(
                                        readOnly: !widget.showLine1,
                                          onChanged: (text) {
                                            int newvalue =
                                                int.tryParse(text) ?? 0;
                                            int remain = int.tryParse(
                                                    e.remains[i - 1].text) ??
                                                0;
                                            if (newvalue > remain) {
                                              e.newvalues[i - 1].clear();
                                            }
                                            e.newvalues[e.newvalues.length - 1]
                                                .text = e.sumOfNewValues();
                                          },
                                          decoration: formDecor1,
                                          controller: e.newvalues[i - 1],
                                          style: headerLeft))
                                ]))),
                      ],
                      SizedBox(
                          width: 120,
                          child: Container(
                              decoration: headerDecor3,
                              child: Row(children: [
                                Expanded(
                                    child: TextFormField(
                                        readOnly: true,
                                        decoration: formDecor1,
                                        controller:
                                            e.newvalues[e.newvalues.length - 1],
                                        style: headerLeft))
                              ]))),
                    ],
                  ),
                ],
              )
            ])
          ]
        ],
      ),
    );
  }
}
