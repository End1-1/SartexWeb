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
  final PreloadingModel model;

  PreloadingItemsContainer({super.key, required this.model});

  @override
  State<StatefulWidget> createState() => _PreloadingItemsContainer();
}

class _PreloadingItemsContainer extends State<PreloadingItemsContainer> {
  final BoxDecoration headerDecor = const BoxDecoration(color: Colors.black45);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var e in widget.model.prLine.items) ...[
            const Divider(height: 10, color: Colors.white),
            Row(children: [
              SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: headerDecor, child: Row(children: [Expanded(child: Text(L.tr('Brand')))])),
                      TextFormField(
                        controller: e.brand,
                        onTap: () {
                          valueOfList(context, widget.model.data.brandLevel, e.brand, done: () {
                            widget.model.data.buildModelList(e.brand.text);
                          });
                        }
                      )
                    ],
                  )),
              SizedBox(width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: headerDecor, child: Text(L.tr('Model'))),
                    TextFormField(controller: e.model,
                      onTap: (){
                        valueOfList(context, widget.model.data.modelLevel, e.model, done: () {
                          //widget.model.data.buildModelList(e.brand.text);
                        });
                      },
                    )
                  ],
                ),
              )
            ])
          ]
        ],
      ),
    );
  }
}
