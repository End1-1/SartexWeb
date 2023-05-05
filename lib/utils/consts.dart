import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sartex/screen/popup_values_screen.dart';
import 'package:sartex/utils/translator.dart';
import 'package:table_calendar/table_calendar.dart';

const server_http_address = 'https://app.sartex.am/mix/mservice.php';
final server_uri = Uri.parse(server_http_address);

const route_root = '/';
const route_dashboard = 'dashboard';
const route_tv = 'tv';
const route_patver_data = 'patver_data';
const route_barcum = 'barcum';
const route_production = 'production';
const route_users = 'users';
const route_department = 'department';
const route_product = 'products';
const route_product_statuses = 'product_statuses';
const route_partners = 'partners';
const route_sizes = 'sizes';
const route_language_editor = 'language_editor';
const route_users_role = 'users_role';

const key_error = 'key_error';
const key_empty = 'empty';
const key_session_id = 'session';
const key_language = 'language';
const key_language_am = 'language_am';
const key_language_it = 'language_it';

const key_user_id = 'key_user_id';
const key_user_branch = 'key_user_branch';
const key_user_is_active = 'key_user_is_active';
const key_user_firstname = 'key_user_firstname';
const key_user_lastname = 'key_user_lastname';
const key_user_position = 'key_user_position';
const key_user_role = 'key_user_role';
const key_full_name = "key_full_name";
const key_role = 'key_role';

const color_menu_background1 = Color(0xff1e2757);
const color_menu_background2 = Color(0xff042b4a);
const color_table_header = Color(0xff777777);
const color_table_header_border = Color(0xff362c2c);
const color_textbox_border = Color(0xff11182f);

final outlined_button_style = OutlinedButton.styleFrom(
    backgroundColor: color_menu_background1,
    textStyle: const TextStyle(color: Colors.white));
const bg_gradient = RadialGradient(
  colors: [color_menu_background1, color_menu_background2],
  center: Alignment.topLeft,
  radius: 0.8,
);
const bg_table_gradient = RadialGradient(
  colors: [Color(0xff004400), Color(0xff023802)],
  center: Alignment.topLeft,
  radius: 0.8,
);

const text_form_field_decoration = InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
    border: OutlineInputBorder(
        borderSide: BorderSide(color: color_textbox_border)));
const table_header_boxdecoration = BoxDecoration(
    gradient: bg_table_gradient,
    border: Border.fromBorderSide(BorderSide(color: Colors.white)));
const table_body_boxdecoration = BoxDecoration(
    color: Colors.white,
    border: Border.fromBorderSide(BorderSide(color: Colors.black12)));
const table_default_row_height = 40.0;
const text_style_white_bold =
    TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
const TextStyle tsDialogHeader = TextStyle(color: Color(0xff0000ff), fontSize: 30, fontWeight: FontWeight.bold);

Future<void> appDialog(BuildContext context, String msg) async {
  await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(children: [
                  Text(msg, style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(L.tr('Close')))
                ]))
          ],
        );
      });
}

Future<void> appDialogYesNo(BuildContext context, String msg, Function yes, Function? no) async {
  await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(children: [
                  Text(msg, style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  Row(children:[
                    Expanded(child: Container()),
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          if (yes != null) {
                            yes();
                          }
                        },
                        child: Text(L.tr('Yes'))),
                    const SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (no != null) {
                          no();
                        }
                      },
                      child: Text(L.tr('No'))),
                  Expanded(child: Container())])
                ]))
          ],
        );
      });
}

void dateDialog(BuildContext context, TextEditingController controller, {bool firstDay = true}) {
  showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(children: [
          SizedBox(
              width: 200,
              child: TableCalendar(
                focusedDay: controller.text.isEmpty
                    ? DateTime.now()
                    : DateFormat('dd/MM/yyyy').parse(controller.text),
                firstDay: firstDay ? DateTime.now() : DateTime.now().add(const Duration(days: -1000)),
                lastDay: DateTime.now().add(const Duration(days: 700)),
                onDaySelected: (d1, d2) {
                  controller.text = DateFormat('dd/MM/yyyy').format(d1);
                  Navigator.pop(context);
                },
              ))
        ]);
      });
}

void valueOfList(BuildContext context, List<String> list,
    TextEditingController textEditingController, {VoidCallback? done}) {
  showDialog(
      context: context,
      builder: (BuildContext contex) {
        return PopupValuesScreen(values: list);
      }).then((value) {
    if (value != null) {
      textEditingController.text = value;
      if (done != null) {
        done();
      }
    }
  });
}
