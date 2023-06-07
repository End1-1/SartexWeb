import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/translator.dart';

List<Widget> textField(
    {required BuildContext context,
      required String title,
      required TextEditingController textEditingController,
      required VoidCallback? onTap,
      double width = 200.0,
      ValueChanged<String>? onChange,
      List<String>? list,
      bool enabled = true}) {
  double w = width * scale_factor;
  final List<Widget> l = [];
  l.add(Padding(
      padding: EdgeInsets.only(top: 10 * scale_factor, left: 10 * scale_factor, right: 10 * scale_factor),
      child: Text(L.tr(title), style: TextStyle(fontSize: 18 * scale_factor))));
  l.add(Padding(
      padding: EdgeInsets.only(left: 10 * scale_factor, right: 10 * scale_factor),
      child: SizedBox(
          width: w,
          child: TextFormField(
            decoration: text_form_field_decoration,
            onChanged: onChange,
            enabled: enabled,
            onTap: onTap ??
                (list == null
                    ? null
                    : () {
                  if (list.isNotEmpty) {
                    valueOfList(context, list, textEditingController);
                  }
                }),
            readOnly: list != null || onTap != null || !enabled,
            controller: textEditingController,
          ))));
  return l;
}

Widget textFieldColumn(
    {required BuildContext context,
      required String title,
      required TextEditingController textEditingController,
      List<String>? list,
      double width = 300,
      bool enabled = true,
      VoidCallback? onTap,
      ValueChanged<String>? onChange}) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: textField(
          context: context,
          title: title,
          textEditingController: textEditingController,
          onTap: onTap,
          enabled: enabled,
          onChange: onChange,
          list: list,
          width: width));
}