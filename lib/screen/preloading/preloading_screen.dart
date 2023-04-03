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
        Row(children: [Text(L.tr('Preloading'))]),
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
              title: 'Receipant',
              textEditingController: _model.editReceipant)
        ]),
        const Divider(height: 20, color: Colors.blueAccent),
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
                      Container()
                    ],
                  ),
                )))
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
              SvgButton(onTap: () {
                setState(() {
                  widget.model.prLine.items.add(PreloadingItem());
                });
              }, assetPath: 'svg/plus.svg')
            ])),
        Expanded(child: PreloadingItemsContainer(model: widget.model))
      ],
    );
  }

}
