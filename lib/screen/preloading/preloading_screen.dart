import 'package:flutter/material.dart';
import 'package:sartex/screen/preloading/preloading_model.dart';
import 'package:sartex/screen/preloading/preloading_widgets.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:sartex/widgets/svg_button.dart';

class PreloadingScreen extends EditWidget {
  final PreloadingModel _model = PreloadingModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Header
        Row(children: [Expanded(child: Text(L.tr('Preloading'), textAlign: TextAlign.center, style: tsDialogHeader))]),
        Row(children: [
          textFieldColumn(
              context: context,
              title: 'Date',
              textEditingController: _model.editDate,
              onTap: () {
                dateDialog(context, _model.editDate);
              }),
          textFieldColumn(
              context: context,
              title: 'Track',
              textEditingController: _model.editTruck),
          textFieldColumn(
              context: context,
              title: 'Store',
              textEditingController: _model.editStore),
          textFieldColumn(
              context: context,
              title: 'Receipant',
              textEditingController: _model.editReceipant),
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
                    Navigator.pop(context);
                  });
                }, () {});
              },
              assetPath: 'svg/save.svg')
        ]),
        const Divider(height: 20, color: Colors.transparent),
        //MainWindow
        DefaultTabController(
            length: 2,
            child: SizedBox(
                height: 800,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Scaffold(
                  appBar: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black45,
                    tabs: [
                      Text(L.tr('New preloading')),
                      Text(L.tr('Preloading list'))
                    ],
                  ),
                  body: TabBarView(
                    children: [
                      Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: PreloadingLine(model: _model)),
                      Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: PreloadingLines(model: _model)),
                    ],
                  ),
                ))),
      ],
    );
  }

  @override
  String getTable() {
    return '';
  }
}

class PreloadingLine extends StatefulWidget {
  final PreloadingModel model;

  PreloadingLine({required this.model});

  @override
  State<StatefulWidget> createState() => _PreloadingLine();
}

class _PreloadingLine extends State<PreloadingLine> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: const BoxDecoration(color: Colors.blueAccent),
            child: Row(children: [
              Expanded(child: LineDropdownButton(model: widget.model)),
              SvgButton(
                  onTap: () {
                    setState(() {
                      widget.model.prLine.items.add(PreloadingItem());
                    });
                  },
                  assetPath: 'svg/plus.svg'),
              SvgButton(
                  onTap: () {
                    appDialogYesNo(context, L.tr('Is data ready?'), () {
                      String err = '';
                      if (widget.model.prLine.prLine.isEmpty) {
                        err += L.tr('Select line');
                      }
                      if (err.isNotEmpty) {
                        appDialog(context, err);
                        return;
                      }
                      widget.model.prReadyLines.add(widget.model.prLine);
                      widget.model.prLine = PreloadingFullItem();
                      setState(() {});
                    }, () {});
                  },
                  assetPath: 'svg/save.svg')
            ])),
        Expanded(
            child: PreloadingItemsContainer(
                item: widget.model.prLine, model: widget.model))
      ],
    );
  }
}

class PreloadingLines extends StatefulWidget {
  final PreloadingModel model;

  PreloadingLines({required this.model});

  @override
  State<StatefulWidget> createState() => _PreloadingLines();
}

class _PreloadingLines extends State<PreloadingLines> {
  final TextStyle tsLine = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 20, color: Colors.transparent),
        for (var e in widget.model.prReadyLines) ...[
          Row(
            children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: const BoxDecoration(color: Colors.blueAccent),
                      child: Text(e.prLine, style: tsLine))),
              const Divider(height: 20, color: Colors.transparent),
            ],
          ),
          PreloadingItemsContainer(item: e),
          const Divider(height: 20, color: Colors.transparent),
        ]
      ],
    ));
  }
}
