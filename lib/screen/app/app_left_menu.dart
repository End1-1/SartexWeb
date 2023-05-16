import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/svg_button.dart';
import 'package:sartex/widgets/text_mouse_button.dart';

class LeftMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeftMenu();
}

class _LeftMenu extends State<LeftMenu> {
  var expanded = false;
  var expandedDirectory = false;
  var expandedEarth = false;
  var expandedReports = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        decoration: const BoxDecoration(gradient: bg_gradient),
        duration: const Duration(milliseconds: 200),
        width: expanded ? 240 : 60,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Row(
                children: [
                  SvgButton(
                      onTap: () {
                        setState(() {
                          expanded = !expanded;
                        });
                      },
                      assetPath: 'svg/dashboard.svg'),
                  Expanded(
                      child: TextMouseButton(
                          onTap: () {}, caption: L.tr('Dashboard')))
                ],
              ),
              Row(
                children: [
                  SvgButton(onTap: () {}, assetPath: 'svg/management.svg'),
                  Expanded(
                      child: TextMouseButton(
                          onTap: () {}, caption: L.tr('Management')))
                ],
              ),
              if (prefs.roleRead("4"))
                Row(
                  children: [
                    SvgButton(
                        onTap: () {
                          expanded = false;
                          Navigator.pushNamed(context, route_tv);
                        },
                        assetPath: 'svg/tv.svg'),
                    Expanded(
                        child: TextMouseButton(
                            onTap: () {
                              expanded = false;
                              Navigator.pushNamed(context, route_tv);
                            },
                            caption: L.tr('TV')))
                  ],
                ),
              if (prefs.roleRead("1"))
                Row(
                  children: [
                    SvgButton(
                        onTap: () {
                          expanded = false;
                          Navigator.pushNamed(context, route_patver_data);
                        },
                        assetPath: 'svg/document.svg'),
                    Expanded(
                        child: TextMouseButton(
                            onTap: () {
                              expanded = false;
                              Navigator.pushNamed(context, route_patver_data);
                            },
                            caption: L.tr('Orders')))
                  ],
                ),
              if (prefs.roleRead("2"))
                Row(
                  children: [
                    SvgButton(
                        onTap: () {
                          expanded = false;
                          Navigator.pushNamed(context, route_barcum);
                        },
                        assetPath: 'svg/truck.svg'),
                    Expanded(
                        child: TextMouseButton(
                            onTap: () {
                              expanded = false;
                              Navigator.pushNamed(context, route_barcum);
                            },
                            caption: L.tr('Loading')))
                  ],
                ),
              if (prefs.roleRead("3"))
                Row(
                  children: [
                    SvgButton(
                        onTap: () {
                          expanded = false;
                          Navigator.pushNamed(context, route_production);
                        },
                        assetPath: 'svg/calendar.svg'),
                    Expanded(
                        child: TextMouseButton(
                            onTap: () {
                              expanded = false;
                              Navigator.pushNamed(context, route_production);
                            },
                            caption: L.tr('Plans')))
                  ],
                ),
              Row(children: [
                SvgButton(
                    onTap: () {
                      setState(() {
                        expanded = !expanded;
                        if (expanded) {
                          expandedReports = true;
                          expandedEarth = false;
                          expandedDirectory = false;
                        } else {
                          expandedReports = false;
                          expandedEarth = false;
                          expandedDirectory = false;
                        }
                      });
                    },
                    assetPath: 'svg/reports.svg'),
                Expanded(
                    child: TextMouseButton(
                        onTap: () {
                          setState(() {
                            expandedReports = !expandedReports;
                            expandedEarth = false;
                            expandedDirectory = false;
                          });
                        },
                        caption: L.tr('Reports')))
              ]),
              AnimatedContainer(
                  height: expandedReports ? 40 * 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextMouseButton(
                            onTap: () {
                              Navigator.pushNamed(context, route_remains);
                            },
                            caption: L.tr('Remains')),
                      ],
                    ),
                  )),
              if (prefs.readDirectoriesCount() > 0)
                Row(
                  children: [
                    SvgButton(
                        onTap: () {
                          setState(() {
                            expanded = !expanded;
                            expandedDirectory = expanded;
                            expandedEarth = false;
                          });
                        },
                        assetPath: 'svg/folder.svg'),
                    Expanded(
                        child: TextMouseButton(
                            onTap: () {
                              setState(() {
                                expandedDirectory = !expandedDirectory;
                                expandedEarth = false;
                                expandedReports = false;
                              });
                            },
                            caption: L.tr('Directory')))
                  ],
                ),
              AnimatedContainer(
                  height:
                      expandedDirectory ? 40 * prefs.readDirectoriesCount() : 0,
                  duration: const Duration(milliseconds: 200),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (prefs.roleRead("6"))
                          TextMouseButton(
                              onTap: () {
                                Navigator.pushNamed(context, route_users);
                              },
                              caption: L.tr('Users')),
                        if (prefs.roleRead("7"))
                          TextMouseButton(
                              onTap: () {
                                Navigator.pushNamed(context, route_department);
                              },
                              caption: L.tr('Departments')),
                        if (prefs.roleRead("7"))
                          TextMouseButton(
                              onTap: () {
                                Navigator.pushNamed(context, route_product);
                              },
                              caption: L.tr('Products')),
                        if (prefs.roleRead("7"))
                          TextMouseButton(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, route_product_statuses);
                              },
                              caption: L.tr('Products states')),
                        if (prefs.roleRead("7"))
                          TextMouseButton(
                              onTap: () {
                                Navigator.pushNamed(context, route_partners);
                              },
                              caption: L.tr('Partners')),
                        if (prefs.roleRead("5"))
                          TextMouseButton(
                              onTap: () {
                                Navigator.pushNamed(context, route_users_role);
                              },
                              caption: L.tr('Permissions')),
                        if (prefs.roleRead("7"))
                          TextMouseButton(
                              onTap: () {
                                Navigator.pushNamed(context, route_sizes);
                              },
                              caption: L.tr('Units'))
                      ],
                    ),
                  )),
              if (prefs.roleRead("8"))
                Row(
                  children: [
                    SvgButton(
                        onTap: () {
                          setState(() {
                            expanded = !expanded;
                            expandedEarth = expanded;
                            expandedDirectory = false;
                            expandedReports = false;
                          });
                        },
                        assetPath: 'svg/earth.svg'),
                    Expanded(
                        child: TextMouseButton(
                            onTap: () {
                              setState(() {
                                expandedEarth = !expandedEarth;
                                expandedDirectory = false;
                                expandedReports = false;
                              });
                            },
                            caption: L.tr('Language')))
                  ],
                ),
              AnimatedContainer(
                  height: expandedEarth ? 40 * 3 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextMouseButton(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, route_language_editor);
                            },
                            caption: L.tr('Editor')),
                        TextMouseButton(
                            onTap: () {}, caption: L.tr('Armenian')),
                        TextMouseButton(onTap: () {}, caption: L.tr('Italy')),
                      ],
                    ),
                  )),
            ])));
  }
}
