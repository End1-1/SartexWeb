import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sartex/screen/app/app_screen.dart';
import 'package:sartex/screen/language_editor/language_bloc.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/widgets/svg_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../utils/translator.dart';
import 'language_model.dart';
import 'language_state.dart';

class LanguageScreen extends App {
  LanguageScreen() : super(title: L.tr('Translator'), model: LanguageModel());

  @override
  Widget body(BuildContext context) {
    var bloc = BlocProvider<LanguageBloc>(
        create: (_) => LanguageBloc(LanguageStateIdle()));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _table()),
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 40, 40, 40),
            child: OutlinedButton(
                onPressed: () {
                  List<Map<String, String>> values = [];
                  L.items.forEach((key, value) {
                    values.add(
                        {'key': value.key, 'am': value.am, 'it': value.it});
                  });
                  String json = jsonEncode(values);
                  HttpSqlQuery.postString({
                    'sl':
                        "update app_conf set app_value='${json}' where app_key='tr'"
                  }).then((value) {
                    appDialog(context, L.tr('Saved!'));
                  });
                },
                style: outlined_button_style,
                child: Text(L.tr('Save'))))
      ],
    );
  }

  Widget _table() {
    return SfDataGrid(
        columnWidthMode: ColumnWidthMode.auto,
        allowEditing: true,
        selectionMode: SelectionMode.single,
        navigationMode: GridNavigationMode.cell,
        source: LanguageDatasource(),
        columns: [
          GridColumn(
              columnName: 'Key', label: Text('Key'), allowEditing: false),
          GridColumn(columnName: 'Am', label: Text('Am'), allowEditing: true),
          GridColumn(columnName: 'It', label: Text('It'), allowEditing: true),
        ]);
  }

  List<Widget> _children(BuildContext context) {
    List<Widget> l = [];
    final List<TranslatorItem> list = (model as LanguageModel).filteredItem();
    for (int i = 0; i < list.length; i++) {
      final e = list.elementAt(i);
      l.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            height: table_default_row_height,
            decoration: table_body_boxdecoration,
            width: 300,
            child: TextFormField(
              readOnly: true,
              decoration: text_form_field_decoration,
              initialValue: e.key,
            )),
        Container(
            height: table_default_row_height,
            decoration: table_body_boxdecoration,
            width: 300,
            child: Focus(
                onFocusChange: (f) {
                  if (!f) {
                    L.items[e.key] = e.copyWith(am: e.amController.text);
                  }
                },
                child: TextFormField(
                    decoration: text_form_field_decoration,
                    controller: e.amController..text = e.am))),
        Container(
            height: table_default_row_height,
            decoration: table_body_boxdecoration,
            width: 300,
            child: Focus(
                onFocusChange: (f) {
                  if (!f) {
                    L.items[e.key] = e.copyWith(it: e.itController.text);
                  }
                },
                child: TextFormField(
                    decoration: text_form_field_decoration,
                    controller: e.itController..text = e.it))),
        Container(
            height: table_default_row_height,
            width: 200,
            decoration: table_body_boxdecoration,
            child: (model as LanguageModel).editRowNumber == i
                ? SvgButton(onTap: () {}, assetPath: 'svg/save.svg')
                : SvgButton(onTap: () {}, assetPath: 'svg/edit.svg'))
      ]));
    }
    return l;
  }
}
