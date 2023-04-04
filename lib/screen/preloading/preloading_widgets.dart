import 'package:flutter/material.dart';
import 'package:sartex/screen/preloading/preloading_model.dart';
import 'package:sartex/screen/preloading/preloading_size.dart';
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
        hint: Text(L.tr('Select line')),
        style: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        value: widget.model.prLine.prLine,
        items: widget.model.lines.map((s) {
          return DropdownMenuItem<String>(value: s, child: Text(s));
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

  PreloadingItemsContainer({super.key, required this.item, this.model});

  @override
  State<StatefulWidget> createState() => _PreloadingItemsContainer();
}

class _PreloadingItemsContainer extends State<PreloadingItemsContainer> {
  final BoxDecoration headerDecor = const BoxDecoration(
      color: Colors.black45,
      border: Border.fromBorderSide(BorderSide(width: 0.1)));
  final BoxDecoration headerDecor2 = const BoxDecoration(
      color: Colors.yellow,
      border: Border.fromBorderSide(BorderSide(width: 0.1)));
  
  final InputDecoration labelDecor = const InputDecoration(
    isDense: true,
      border: InputBorder.none,
  contentPadding: EdgeInsets.fromLTRB(3, 5, 3, 5));

  final BoxDecoration headerDecor3 = const BoxDecoration(
      color: Colors.white,
      border: Border.fromBorderSide(BorderSide(width: 0.1)));

  final BoxDecoration boxOk = const BoxDecoration(
      color: Color(0xffb6f6b6),
      border: Border.fromBorderSide(BorderSide(width: 0.1)));
  final BoxDecoration boxFail= const BoxDecoration(
      color: Color(0xfffa9e9e),
      border: Border.fromBorderSide(BorderSide(width: 0.1)));
  
  final TextStyle headerLeft =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, height: 1.5);
  final EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(4, 5, 5, 5);

  final InputDecoration formDecor1 =
      const InputDecoration(isDense: true, border: InputBorder.none, contentPadding: EdgeInsets.fromLTRB(5, 15, 5, 15));
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          for (var e in widget.item.items) ...[
            const Divider(height: 10, color: Colors.white),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              //LEFT SIDE
              //brand
              SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: padding,
                          decoration: headerDecor,
                          child: Row(children: [
                            Expanded(
                                child: TextFormField(readOnly: true, decoration: labelDecor, initialValue: L.tr('Brand'), style: headerLeft,))
                          ])),
                      //model
                      Container(
                          decoration: headerDecor,
                          child: TextFormField(
                              decoration: formDecor1,
                              controller: e.brand,
                              onTap: widget.model == null ? null : () {
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
                        decoration: headerDecor,
                        child: Row(children: [
                          Expanded(
                              child: TextFormField(readOnly: true, decoration: labelDecor, initialValue: L.tr('Model'), style: headerLeft))
                        ])),
                    Container(
                        decoration: headerDecor,
                        child: TextFormField(
                          decoration: formDecor1,
                          controller: e.model,
                          onTap: widget.model == null ? null : () {
                            valueOfList(
                                context, widget.model!.data.modelLevel, e.model,
                                done: () {
                              e.commesa.clear();
                              e.color.clear();
                              e.variant.clear();
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
                          decoration: headerDecor,
                          child: Row(children: [
                            Expanded(
                                child: TextFormField(readOnly: true, decoration: labelDecor, initialValue: L.tr('Order'), style: headerLeft))
                          ])),
                      Container(
                          decoration: headerDecor,
                          child: TextFormField(
                              decoration: formDecor1,
                              controller: e.commesa,
                              onTap: widget.model == null ? null : () {
                                valueOfList(context,
                                    widget.model!.data.commesaLevel, e.commesa,
                                    done: () {
                                      e.color.clear();
                                      e.variant.clear();
                                      widget.model!.data.buildColorLevel(e.brand.text, e.model.text, e.commesa.text);
                                    });
                              })),
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
                          decoration: headerDecor,
                          child: Row(children: [
                            Expanded(
                                child: TextFormField(readOnly: true, decoration: labelDecor, initialValue: L.tr('Color'), style: headerLeft))
                          ])),
                      Container(
                          decoration: headerDecor,
                          child: TextFormField(
                              decoration: formDecor1,
                              controller: e.color,
                              onTap: widget.model == null ? null : () {
                                valueOfList(context,
                                    widget.model!.data.colorLevel, e.color,
                                    done: () {
                                      e.variant.clear();
                                      widget.model!.data.buildVariantLevel(e.brand.text, e.model.text, e.commesa.text, e.color.text);
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
                              decoration: headerDecor,
                              child: Row(children: [
                                Expanded(
                                    child: TextFormField(readOnly: true, decoration: labelDecor, initialValue: L.tr('Variant'), style: headerLeft))
                              ])),
                          Container(
                              decoration: headerDecor,
                              child: TextFormField(
                                  decoration: formDecor1,
                                  controller: e.variant,
                                  onTap: widget.model == null ? null : () {
                                    valueOfList(context,
                                        widget.model!.data.variantLevel, e.variant,
                                        done: () {
                                          widget.model!.data.getSizesAndCountry(e.brand.text, e.model.text, e.commesa.text, e).then((value) {
                                              e.country.text = widget.model!.data.country ?? '';
                                              e.size = widget.model!.data.sizeStandartList[widget.model!.data.sizeStandart];
                                              for (int i = 1; i < 11; i++) {
                                                e.sizes[i - 1].text = e.size?.sizeOfIndex(i) ?? '';
                                              }
                                          });
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
                              decoration: headerDecor,
                              child: Row(children: [
                                Expanded(
                                    child: TextFormField(readOnly: true, decoration: labelDecor, initialValue: L.tr('Country'), style: headerLeft))
                              ])),
                          Container(
                              decoration: headerDecor,
                              child: TextFormField(
                                  readOnly: true,
                                  decoration: formDecor1,
                                  controller: e.country)),
                        ],
                      )),
              //Sizes
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Size Row
                  Row(
                    children: [
                      for (int i = 1; i < 11; i++)...[
                        SizedBox(width: 60, child: Container(
                            padding: padding,
                            decoration: headerDecor,
                            child: Row(children: [
                              Expanded(
                                  child: TextFormField(readOnly: true, decoration: labelDecor, controller: e.sizes[i - 1], style: headerLeft))
                            ]))),
                      ]
                    ],
                  ),
                  //Remain row
                  Row(
                    children: [
                      for (int i = 1; i < 11; i++)...[
                        SizedBox(width: 60, child: Container(
                            decoration: headerDecor2,
                            child: Row(children: [
                              Expanded(
                                  child: TextFormField(readOnly: true, decoration: formDecor1, controller: e.remains[i - 1], style: headerLeft,))
                            ]))),
                      ]
                    ],
                  ),
                  //Input row
                  Row(
                    children: [
                      for (int i = 1; i < 11; i++)...[
                        SizedBox(width: 60, child: Container(
                            padding: padding,
                            decoration: headerDecor3,
                            child: Row(children: [
                              Expanded(
                                  child: TextFormField(
                                    onChanged: (value) {
                                        if ((int.tryParse(e.preSize?.valueOf(i) ?? '0') ?? 0) < (int.tryParse(value) ?? 0)) {
                                          e.newvalues[i - 1].clear();
                                          e.diffvalues[i - 1].clear();
                                          return;
                                        }
                                        e.diffvalues[i - 1].text = ((int.tryParse(e.preSize?.valueOf(i) ?? '0') ?? 0) - (int.tryParse(value) ?? 0)).toString();
                                        setState((){});
                                    },
                                    decoration: formDecor1,
                                    controller: e.newvalues[i - 1],
                                  ))
                            ]))),
                      ]
                    ],
                  ),
                  //Difference row
                  Row(
                    children: [
                      for (int i = 1; i < 11; i++)...[
                        SizedBox(width: 60, child: Container(
                            padding: padding,
                            decoration: e.diffvalues[i - 1].text.isEmpty || int.tryParse(e.diffvalues[i - 1].text) == 0 ? boxOk : boxFail,
                            child: Row(children: [
                              Expanded(
                                  child: TextFormField(
                                    readOnly: true,
                                    decoration: formDecor1,
                                    controller: e.diffvalues[i - 1],
                                  ))
                            ]))),
                      ]
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
