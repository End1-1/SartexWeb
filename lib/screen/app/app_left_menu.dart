import 'package:flutter/cupertino.dart';
import 'package:sartex/utils/consts.dart';
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
                  SvgButton(
                      onTap: () {
                        setState(() {
                          expanded = false;
                          Navigator.pushNamed(context, route_tv);
                        });
                      },
                      assetPath: 'svg/management.svg'),
                  Expanded(
                      child: TextMouseButton(
                          onTap: () {}, caption: L.tr('Management')))
                ],
              ),
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
                SvgButton(onTap: () {}, assetPath: 'svg/reports.svg'),
                Expanded(
                    child:
                        TextMouseButton(onTap: () {}, caption: L.tr('Reports')))
              ]),
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
                            });
                          },
                          caption: L.tr('Directory')))
                ],
              ),
              AnimatedContainer(
                  height: expandedDirectory ? 40 * 7 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextMouseButton(
                            onTap: () {
                              Navigator.pushNamed(context, route_users);
                            },
                            caption: L.tr('Users')),
                        TextMouseButton(
                            onTap: () {
                              Navigator.pushNamed(context, route_department);
                            },
                            caption: L.tr('Departments')),
                        TextMouseButton(
                            onTap: () {
                              Navigator.pushNamed(context, route_product);
                            },
                            caption: L.tr('Products')),
                        TextMouseButton(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, route_product_statuses);
                            },
                            caption: L.tr('Products states')),
                        TextMouseButton(
                            onTap: () {
                              Navigator.pushNamed(context, route_partners);
                            },
                            caption: L.tr('Partners')),
                        TextMouseButton(
                            onTap: () {}, caption: L.tr('Permissions')),
                        TextMouseButton(
                            onTap: () {
                              Navigator.pushNamed(context, route_sizes);
                            },
                            caption: L.tr('Units'))
                      ],
                    ),
                  )),
              Row(
                children: [
                  SvgButton(
                      onTap: () {
                        setState(() {
                          expanded = !expanded;
                          expandedEarth = expanded;
                          expandedDirectory = false;
                        });
                      },
                      assetPath: 'svg/earth.svg'),
                  Expanded(
                      child: TextMouseButton(
                          onTap: () {
                            setState(() {
                              expandedEarth = !expandedEarth;
                              expandedDirectory = false;
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
