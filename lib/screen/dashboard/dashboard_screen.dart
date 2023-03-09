import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sartex/utils/consts.dart';

import '../../utils/prefs.dart';
import '../../utils/translator.dart';
import '../../widgets/svg_button.dart';
import '../../widgets/text_mouse_button.dart';
import 'dashboard_actions.dart';
import 'dashboard_bloc.dart';
import 'dashboard_state.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => DashboardBloc(DashboardStateDefault()),
        child: _SartexDashboardScreen());
  }
}

class _SartexDashboardScreen extends StatelessWidget {
  bool _hideMenu = true;
  bool _hideDirectory = true;
  bool _hideLanguage = true;
  VoidCallback? _onMenuAnimationEnd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<DashboardBloc, DashboardState>(
            listener: (context, state) {},
            child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 40,
                            width: double.infinity,
                            decoration:
                            const BoxDecoration(color: color_header_background),
                            child: Row(
                              children: [
                                Text(prefs.getString(key_user_branch)!,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                Text(state.locationName,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                Expanded(child: Container()),
                                SvgButton(
                                  onTap: () {},
                                  assetPath: 'svg/user.svg',
                                  caption: prefs.getString(key_full_name)!,
                                )
                              ],
                            )),
                        Expanded(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        AnimatedContainer(
                                            color: color_menu_background,
                                            onEnd: () {
                                              if (_onMenuAnimationEnd != null) {
                                                _onMenuAnimationEnd!();
                                              }
                                              _onMenuAnimationEnd = null;
                                            },
                                            duration:
                                            const Duration(milliseconds: 200),
                                            width: _hideMenu ? 60 : 240,
                                            height:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .height,
                                            child: ClipRect(
                                                child: Column(children: [
                                                  Row(
                                                    children: [
                                                      SvgButton(
                                                          onTap: () {
                                                            setState(() {
                                                              _hideMenu =
                                                              !_hideMenu;
                                                            });
                                                          },
                                                          assetPath:
                                                          'svg/dashboard.svg'),
                                                      TextMouseButton(
                                                          onTap: () {},
                                                          caption: L.tr(
                                                              'Dashboard'))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgButton(
                                                          onTap: () {
                                                            setState(() {
                                                              _hideMenu = true;
                                                            });
                                                          },
                                                          assetPath:
                                                          'svg/management.svg'),
                                                      TextMouseButton(
                                                          onTap: () {},
                                                          caption: L.tr(
                                                              'Management'))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgButton(
                                                          onTap: () {
                                                            setState(() {
                                                              _hideMenu = true;
                                                            });
                                                          },
                                                          assetPath: 'svg/tv.svg'),
                                                      TextMouseButton(
                                                          onTap: () {},
                                                          caption: L.tr('TV'))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgButton(
                                                          onTap: () {
                                                            setState(() {
                                                              _hideMenu = true;
                                                            });
                                                          },
                                                          assetPath:
                                                          'svg/document.svg'),
                                                      TextMouseButton(
                                                          onTap: () {},
                                                          caption: L.tr(
                                                              'Orders'))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgButton(
                                                          onTap: () {
                                                            setState(() {
                                                              _hideMenu = true;
                                                            });
                                                          },
                                                          assetPath: 'svg/truck.svg'),
                                                      TextMouseButton(
                                                          onTap: () {},
                                                          caption: L.tr(
                                                              'Loading'))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgButton(
                                                          onTap: () {
                                                            setState(() {
                                                              _hideMenu = true;
                                                            });
                                                          },
                                                          assetPath:
                                                          'svg/calendar.svg'),
                                                      TextMouseButton(
                                                          onTap: () {},
                                                          caption: L.tr(
                                                              'Plans'))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgButton(
                                                          onTap: () {
                                                            setState(() {
                                                              _hideMenu = true;
                                                            });
                                                          },
                                                          assetPath: 'svg/qrcode.svg'),
                                                      TextMouseButton(
                                                          onTap: () {},
                                                          caption: L.tr(
                                                              "Department of QR codes")),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgButton(
                                                          onTap: () {
                                                            setState(() {
                                                              _hideMenu = true;
                                                            });
                                                          },
                                                          assetPath:
                                                          'svg/storehouse.svg'),
                                                      TextMouseButton(
                                                          onTap: () {},
                                                          caption: L.tr(
                                                              "Storehouse"))
                                                    ],
                                                  ),
                                                  Row(children: [
                                                    SvgButton(
                                                        onTap: () {
                                                          setState(() {
                                                            _hideMenu = true;
                                                          });
                                                        },
                                                        assetPath: 'svg/reports.svg'),
                                                    TextMouseButton(
                                                        onTap: () {},
                                                        caption: L.tr(
                                                            'Reports'))
                                                  ]),
                                                  Row(
                                                    children: [
                                                      SvgButton(
                                                          onTap: () {
                                                            if (!_hideMenu) {
                                                              setState(() {
                                                                _hideDirectory =
                                                                true;
                                                                _hideMenu =
                                                                true;
                                                              });
                                                              return;
                                                            }
                                                            _onMenuAnimationEnd =
                                                                () {
                                                              setState(() {
                                                                _hideDirectory =
                                                                false;
                                                              });
                                                            };
                                                            setState(() {
                                                              _hideMenu = false;
                                                            });
                                                          },
                                                          assetPath: 'svg/folder.svg'),
                                                      TextMouseButton(
                                                          onTap: () {
                                                            setState(() {
                                                              _hideDirectory =
                                                              !_hideDirectory;
                                                            });
                                                          },
                                                          caption: L.tr(
                                                              'Directory'))
                                                    ],
                                                  ),
                                                  AnimatedContainer(
                                                      height:
                                                      _hideDirectory ? 0 : 40 *
                                                          7,
                                                      duration: const Duration(
                                                          milliseconds: 200),
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          children: [
                                                            TextMouseButton(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _hideDirectory =
                                                                    true;
                                                                    _hideMenu =
                                                                    true;
                                                                  });
                                                                },
                                                                caption: L.tr(
                                                                    'Users')),
                                                            TextMouseButton(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _hideDirectory =
                                                                    true;
                                                                    _hideMenu =
                                                                    true;
                                                                  });
                                                                },
                                                                caption: L
                                                                    .tr(
                                                                    'Departments')),
                                                            TextMouseButton(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _hideDirectory =
                                                                    true;
                                                                    _hideMenu =
                                                                    true;
                                                                  });
                                                                },
                                                                caption:
                                                                L.tr(
                                                                    'Products')),
                                                            TextMouseButton(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _hideDirectory =
                                                                    true;
                                                                    _hideMenu =
                                                                    true;
                                                                  });
                                                                },
                                                                caption: L.tr(
                                                                    'Products states')),
                                                            TextMouseButton(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _hideDirectory =
                                                                    true;
                                                                    _hideMenu =
                                                                    true;
                                                                  });
                                                                },
                                                                caption:
                                                                L.tr(
                                                                    'Partners')),
                                                            TextMouseButton(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _hideDirectory =
                                                                    true;
                                                                    _hideMenu =
                                                                    true;
                                                                  });
                                                                },
                                                                caption: L
                                                                    .tr(
                                                                    'Permissions')),
                                                            TextMouseButton(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _hideDirectory =
                                                                    true;
                                                                    _hideMenu =
                                                                    true;
                                                                  });
                                                                },
                                                                caption: L.tr(
                                                                    'Units'))
                                                          ],
                                                        ),
                                                      )),
                                                  Row(
                                                    children: [
                                                      SvgButton(
                                                          onTap: () {
                                                            if (!_hideMenu) {
                                                              setState(() {
                                                                _hideLanguage =
                                                                true;
                                                                _hideMenu =
                                                                true;
                                                              });
                                                              return;
                                                            }
                                                            _onMenuAnimationEnd =
                                                                () {
                                                              setState(() {
                                                                _hideLanguage =
                                                                false;
                                                              });
                                                            };
                                                            setState(() {
                                                              _hideMenu = false;
                                                            });
                                                          },
                                                          assetPath: 'svg/earth.svg'),
                                                      TextMouseButton(
                                                          onTap: () {
                                                            setState(() {
                                                              _hideLanguage =
                                                              !_hideLanguage;
                                                            });
                                                          },
                                                          caption: L.tr(
                                                              'Language'))
                                                    ],
                                                  ),
                                                  AnimatedContainer(
                                                      height:
                                                      _hideLanguage ? 0 : 40 *
                                                          2,
                                                      duration: const Duration(
                                                          milliseconds: 200),
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          children: [
                                                            TextMouseButton(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _hideLanguage =
                                                                    true;
                                                                    _hideMenu =
                                                                    true;
                                                                  });
                                                                },
                                                                caption:
                                                                L.tr(
                                                                    'Armenian')),
                                                            TextMouseButton(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _hideLanguage =
                                                                    true;
                                                                    _hideMenu =
                                                                    true;
                                                                  });
                                                                },
                                                                caption: L.tr(
                                                                    'Italy')),
                                                          ],
                                                        ),
                                                      )),
                                                ]))),
                                      ],
                                    ))))
                      ]);
                })));
  }
}
