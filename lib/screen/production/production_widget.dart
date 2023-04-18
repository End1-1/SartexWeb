import 'package:flutter/material.dart';
import 'package:sartex/screen/production/production_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:sartex/widgets/svg_button.dart';

class ProductionWidget extends EditWidget {
  final _model = ProductionModel();

  final InputDecoration labelDecor = const InputDecoration(
      isDense: true,
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(3, 5, 3, 5));
  final InputDecoration formDecor = const InputDecoration(
      isDense: true,
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(5, 15, 5, 15));

  ProductionWidget({super.key}) {

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(children: [
          headerRow1(context),
          Expanded(child: SingleChildScrollView(child: lines(context))),
        ]));
  }

  @override
  String getTable() {
    return 'Production';
  }

  Widget headerRow1(BuildContext context) {
    return Row(children: [
      Expanded(child: Container()),
      SvgButton(
          darkMode: false,
          onTap: () {
            appDialogYesNo(context, L.tr('Close document?'), () {
              Navigator.pop(context);
            }, () {});
          },
          assetPath: 'svg/cancel.svg'),
      SvgButton(
          darkMode: false,
          onTap: () {
            appDialogYesNo(context, L.tr('Save document?'), () {
              _model.save().then((value) {
                if (value.isNotEmpty) {
                  appDialog(context, value);
                  return;
                }

              });
            }, () {});
          },
          assetPath: 'svg/save.svg')
    ]);
  }

  Widget lines(BuildContext context) {
    return StreamBuilder(
        stream: _model.linesController.stream,
        builder: (context, snapshot) {
          return Column(
            children: [
              for (var e in _model.lines) ...[
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: const BoxDecoration(color: Colors.blueAccent),
                    child: Row(
                      children: [
                        Text(L.tr('Line')),
                        const SizedBox(width: 10),
                        Expanded(child: DropdownLine(productionLine: e)),
                        SvgButton(
                            onTap: () {
                              e.items.add(ProductionItem());
                              _model.linesController.add(null);
                            },
                            assetPath: 'svg/plus.svg'),
                        const SizedBox(width: 10),
                      ],
                    )),
                Column(children: [
                  for (var l in e.items) ...[
                    Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //BRAND
                              Container(
                                width: 120,
                                decoration: const BoxDecoration(
                                    color: Colors.black12,
                                    border: Border.fromBorderSide(BorderSide(
                                        color: Colors.black26, width: 0.2))),
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black12,
                                            border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black26,
                                                    width: 0.2))),
                                        child: TextFormField(
                                          readOnly: true,
                                          decoration: labelDecor,
                                          initialValue: L.tr('Brand'),
                                        )),
                                    Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black12,
                                            border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black26,
                                                    width: 0.2))),
                                        child: TextFormField(
                                          decoration: formDecor,
                                          controller: l.editBrand,
                                          onTap: () {
                                            valueOfList(context, l.brandLevel,
                                                l.editBrand, done: () {
                                              l.clearAfterBrand();
                                              l
                                                  .buildModelLevel(
                                                      l.editBrand.text)
                                                  .then((value) {
                                                if (l.modelLevel.length == 1) {
                                                  l.editModel.text =
                                                      l.modelLevel.first;
                                                }
                                              });
                                            });
                                          },
                                        ))
                                  ],
                                ),
                              ),
                              //MODEL
                              Container(
                                width: 200,
                                decoration: const BoxDecoration(
                                    color: Colors.black12,
                                    border: Border.fromBorderSide(BorderSide(
                                        color: Colors.black26, width: 0.2))),
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black12,
                                            border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black26,
                                                    width: 0.2))),
                                        child: TextFormField(
                                          readOnly: true,
                                          decoration: labelDecor,
                                          initialValue: L.tr('Model'),
                                        )),
                                    Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black12,
                                            border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black26,
                                                    width: 0.2))),
                                        child: TextFormField(
                                          decoration: formDecor,
                                          controller: l.editModel
                                            ..addListener(() {
                                              l.clearAfterModel();
                                              if (l.editModel.text.isNotEmpty) {
                                              l
                                                  .buildCommesaLevel(
                                                      l.editBrand.text,
                                                      l.editModel.text)
                                                  .then((value) {
                                                if (l.commesaLevel.length ==
                                                    1) {
                                                  l.editCommesa.text =
                                                      l.commesaLevel.first;
                                                }
                                              });}
                                            }),
                                          onTap: () {
                                            valueOfList(context, l.modelLevel,
                                                l.editModel, done: () {
                                              l.clearAfterModel();
                                              l
                                                  .buildCommesaLevel(
                                                      l.editBrand.text,
                                                      l.editModel.text)
                                                  .then((value) {
                                                if (l.commesaLevel.length ==
                                                    1) {
                                                  l.editCommesa.text =
                                                      l.commesaLevel.first;
                                                }
                                              });
                                            });
                                          },
                                        ))
                                  ],
                                ),
                              ),
                              //COMMES
                              Container(
                                width: 100,
                                decoration: const BoxDecoration(
                                    color: Colors.black12,
                                    border: Border.fromBorderSide(BorderSide(
                                        color: Colors.black26, width: 0.2))),
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black12,
                                            border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black26,
                                                    width: 0.2))),
                                        child: TextFormField(
                                          readOnly: true,
                                          decoration: labelDecor,
                                          initialValue: L.tr('Order'),
                                        )),
                                    Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black12,
                                            border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black26,
                                                    width: 0.2))),
                                        child: TextFormField(
                                          decoration: formDecor,
                                          controller: l.editCommesa
                                            ..addListener(() {
                                              l.clearAfterCommesa();
                                              if (l.editCommesa.text.isNotEmpty) {
                                              l
                                                  .buildCountryLevel(
                                                      l.editBrand.text,
                                                      l.editModel.text,
                                                      l.editCommesa.text)
                                                  .then((value) {
                                                if (l.countryLevel.length ==
                                                    1) {
                                                  l.editCountry.text =
                                                      l.countryLevel.first;
                                                }
                                              });}
                                            }),
                                          onTap: () {
                                            valueOfList(context, l.commesaLevel,
                                                l.editCommesa, done: () {
                                              l.clearAfterCommesa();
                                              l
                                                  .buildCountryLevel(
                                                      l.editBrand.text,
                                                      l.editModel.text,
                                                      l.editCommesa.text)
                                                  .then((value) {
                                                if (l.countryLevel.length ==
                                                    1) {
                                                  l.editCountry.text =
                                                      l.countryLevel.first;
                                                }
                                              });
                                            });
                                          },
                                        ))
                                  ],
                                ),
                              ),
                              //COUNTRY
                              Container(
                                width: 100,
                                decoration: const BoxDecoration(
                                    color: Colors.black12,
                                    border: Border.fromBorderSide(BorderSide(
                                        color: Colors.black26, width: 0.2))),
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black12,
                                            border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black26,
                                                    width: 0.2))),
                                        child: TextFormField(
                                          readOnly: true,
                                          decoration: labelDecor,
                                          initialValue: L.tr('Country'),
                                        )),
                                    Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black12,
                                            border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black26,
                                                    width: 0.2))),
                                        child: TextFormField(
                                          decoration: formDecor,
                                          controller: l.editCountry
                                            ..addListener(() {
                                              l.clearAfterCountry();
                                              if (l.editCountry.text.isNotEmpty) {
                                              l
                                                  .buildColorLevel(
                                                      l.editBrand.text,
                                                      l.editModel.text,
                                                      l.editCommesa.text,
                                                      l.editCountry.text)
                                                  .then((value) {
                                                if (l.colorLevel.length == 1) {
                                                  l.editColor.text =
                                                      l.colorLevel.first;
                                                }
                                              });}
                                            }),
                                          onTap: () {
                                            valueOfList(context, l.countryLevel,
                                                l.editCountry, done: () {
                                              l.clearAfterCountry();
                                              l
                                                  .buildColorLevel(
                                                      l.editBrand.text,
                                                      l.editModel.text,
                                                      l.editCommesa.text,
                                                      l.editCountry.text)
                                                  .then((value) {
                                                if (l.colorLevel.length == 1) {
                                                  l.editColor.text =
                                                      l.colorLevel.first;
                                                }
                                              });
                                            });
                                          },
                                        ))
                                  ],
                                ),
                              ),
                              //COLOR
                              Container(
                                width: 100,
                                decoration: const BoxDecoration(
                                    color: Colors.black12,
                                    border: Border.fromBorderSide(BorderSide(
                                        color: Colors.black26, width: 0.2))),
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black12,
                                            border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black26,
                                                    width: 0.2))),
                                        child: TextFormField(
                                          readOnly: true,
                                          decoration: labelDecor,
                                          initialValue: L.tr('Color'),
                                        )),
                                    Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black12,
                                            border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black26,
                                                    width: 0.2))),
                                        child: TextFormField(
                                          decoration: formDecor,
                                          controller: l.editColor
                                            ..addListener(() {
                                              l.clearAfterColor();
                                              if (l.editColor.text.isNotEmpty) {
                                              l
                                                  .buildVariantLevel(
                                                      l.editBrand.text,
                                                      l.editModel.text,
                                                      l.editCommesa.text,
                                                      l.editCountry.text,
                                                      l.editColor.text)
                                                  .then((value) {
                                                if (l.variantLevel.length ==
                                                    1) {
                                                  l.editVariant.text =
                                                      l.variantLevel.first;
                                                }
                                              });}
                                            }),
                                          onTap: () {
                                            valueOfList(context, l.colorLevel,
                                                l.editColor, done: () {
                                              l.clearAfterColor();
                                              l
                                                  .buildVariantLevel(
                                                      l.editBrand.text,
                                                      l.editModel.text,
                                                      l.editCommesa.text,
                                                      l.editCountry.text,
                                                      l.editColor.text)
                                                  .then((value) {
                                                if (l.variantLevel.length ==
                                                    1) {
                                                  l.editVariant.text =
                                                      l.variantLevel.first;
                                                }
                                              });
                                            });
                                          },
                                        ))
                                  ],
                                ),
                              ),
                              //VARIANT
                              Container(
                                width: 100,
                                decoration: const BoxDecoration(
                                    color: Colors.black12,
                                    border: Border.fromBorderSide(BorderSide(
                                        color: Colors.black26, width: 0.2))),
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black12,
                                            border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black26,
                                                    width: 0.2))),
                                        child: TextFormField(
                                          readOnly: true,
                                          decoration: labelDecor,
                                          initialValue: L.tr('Variant'),
                                        )),
                                    Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black12,
                                            border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black26,
                                                    width: 0.2))),
                                        child: TextFormField(
                                          decoration: formDecor,
                                          controller: l.editVariant
                                            ..addListener(() {
                                              l.clearAfterVariant();
                                              if (l.editVariant.text
                                                  .isNotEmpty) {
                                                l
                                                    .getSizes(
                                                        l.editBrand.text,
                                                        l.editModel.text,
                                                        l.editCommesa.text,
                                                        l.editCountry.text,
                                                        l.editColor.text,
                                                        l.editVariant.text)
                                                    .then((value) {});
                                              }
                                            }),
                                          onTap: () {
                                            valueOfList(context, l.variantLevel,
                                                l.editVariant, done: () {
                                              l.clearAfterVariant();
                                              l
                                                  .getSizes(
                                                      l.editBrand.text,
                                                      l.editModel.text,
                                                      l.editCommesa.text,
                                                      l.editCountry.text,
                                                      l.editColor.text,
                                                      l.editVariant.text)
                                                  .then((value) {});
                                            });
                                          },
                                        ))
                                  ],
                                ),
                              ),
                              //SIZES
                              for (int i = 0; i < 13; i++) ...[
                                Container(
                                  width: i == 12 ? 100 : 60,
                                  decoration: const BoxDecoration(
                                      color: Colors.black12,
                                      border: Border.fromBorderSide(BorderSide(
                                          color: Colors.black26, width: 0.2))),
                                  child: Column(
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          width: i == 12 ? 100 : 60,
                                          decoration: const BoxDecoration(
                                              color: Colors.black12,
                                              border: Border.fromBorderSide(
                                                  BorderSide(
                                                      color: Colors.black26,
                                                      width: 0.2))),
                                          child: TextFormField(
                                            readOnly: true,
                                            decoration: labelDecor,
                                            controller: l.sizes[i],
                                          )),
                                      Container(
                                          width: i == 12 ? 100 : 60,
                                          decoration: const BoxDecoration(
                                              color: Colors.yellow,
                                              border: Border.fromBorderSide(
                                                  BorderSide(
                                                      color: Colors.black26,
                                                      width: 0.2))),
                                          child: MouseRegion(
                                              child: InkWell(
                                                  onTap: () {
                                                    if (i < 12) {
                                                      l.newvalues[i].text =
                                                          l.remains[i].text;
                                                    } else {
                                                      for (int n = 0;
                                                          n < 12;
                                                          n++) {
                                                        l.newvalues[n].text =
                                                            l.remains[n].text;
                                                      }
                                                    }
                                                  },
                                                  child: IgnorePointer(
                                                      ignoring: true,
                                                      child: TextFormField(
                                                          readOnly: true,
                                                          decoration: formDecor,
                                                          controller:
                                                              l.remains[i]))))),
                                      Container(
                                          width: i == 12 ? 100 : 60,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              border: Border.fromBorderSide(
                                                  BorderSide(
                                                      color: Colors.black26,
                                                      width: 0.2))),
                                          child: TextFormField(
                                              readOnly: i > 11,
                                              decoration: formDecor,
                                              controller: l.newvalues[i]
                                                ..addListener(() {
                                                  l
                                                          .newvalues[l.newvalues
                                                                  .length -
                                                              1]
                                                          .text =
                                                      l.sumOfNewValues();
                                                  if ((int.tryParse(l
                                                              .newvalues[i]
                                                              .text) ??
                                                          0) >
                                                      (int.tryParse(l.remains[i]
                                                              .text) ??
                                                          0)) {
                                                    l.newvalues[i].clear();
                                                  }
                                                })))
                                    ],
                                  ),
                                )
                              ]
                            ]))
                  ],
                ])
              ],
              plusButton(),
            ],
          );
        });
  }

  Widget plusButton() {
    return Row(
      children: [
        Expanded(
            child: Align(
                alignment: Alignment.center,
                child: SvgButton(
                  onTap: () {
                    _model.lines
                        .add(ProductionLine()..items.add(ProductionItem()));
                    _model.linesController.add(null);
                  },
                  assetPath: 'svg/plus.svg',
                  darkMode: false,
                )))
      ],
    );
  }
}

class DropdownLine extends StatefulWidget {
  ProductionLine productionLine;

  DropdownLine({super.key, required this.productionLine});

  @override
  State<StatefulWidget> createState() => _DropdownLine();
}

class _DropdownLine extends State<DropdownLine> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        underline: const SizedBox(),
        isExpanded: true,
        value: widget.productionLine.name,
        items: Lines.map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (value) {
          widget.productionLine.name = value!;
          setState(() {});
        });
  }
}
