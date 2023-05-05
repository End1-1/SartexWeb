import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    if ((prefs.getInt(key_user_id) ?? 0) == 0) {
      print(ModalRoute.of(context)?.settings.name);
      if (ModalRoute.of(context)?.settings.name != '/') {
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pushReplacementNamed(context, '/');
          return const SizedBox(
              height: 36, width: 36, child: CircularProgressIndicator());
        });
      }
    }
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
                  PopupMenuButton<int>(
                    onSelected: (v) {
                      switch (v) {
                        case 1:
                          prefs.setInt(key_user_id, 0);
                          Navigator.pushNamed(context, '/');
                      }
                    },
                    icon: SvgPicture.asset('svg/user.svg'),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(child: Text(prefs.getString(key_full_name)!)),
                        PopupMenuItem(value: 1, child: Text(L.tr('Logout'))),
                      ];
                  },
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
