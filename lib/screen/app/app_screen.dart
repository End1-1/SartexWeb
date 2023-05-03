import 'package:flutter/material.dart';
import 'package:sartex/screen/app/app_left_menu.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/svg_button.dart';

import 'app_model.dart';

abstract class App extends StatelessWidget {
  final String title;
  final AppModel model;

  App({super.key, required this.title, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(alignment: Alignment.topLeft, children: [
        Column(children: [
          Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              height: 40,
              width: double.infinity,
              decoration: const BoxDecoration(gradient: bg_gradient),
              child: Row(
                children: [
                  Text(prefs.getString(key_user_branch)!,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                  const VerticalDivider(
                    width: 30,
                    color: Colors.transparent,
                  ),
                  Text(L.tr(title),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                  for (final e in titleWidget(context)) ...[e],
                  Expanded(child: Container()),
                  SvgButton(
                    onTap: () {},
                    assetPath: 'svg/user.svg',
                    caption: prefs.getString(key_full_name)!,
                  )
                ],
              )),
          Expanded(
              child: Container(
                  margin: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                  child: body(context))),
        ]),
        LeftMenu(),
      ])),
    );
  }

  Widget body(BuildContext context);

  List<Widget> titleWidget(BuildContext context) {
    return [];
  }
}
