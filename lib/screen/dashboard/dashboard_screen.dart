import 'package:flutter/material.dart';
import 'package:sartex/data/data_partner.dart';
import 'package:sartex/data/data_product_status.dart';
import 'package:sartex/data/data_user.dart';
import 'package:sartex/screen/dashboard/dashboard_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sartex/utils/consts.dart';

import '../../data/data_department.dart';
import '../../data/data_product.dart';
import '../../data/data_sizes.dart';
import '../../data/sartex_datagridsource.dart';
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
  DashboardModel? _model;
  DashboardState _dashboardState = DashboardStateDefault();

  @override
  Widget build(BuildContext context) {
    _model ??= DashboardModel(EmptyDataSource(context: context));
    return Scaffold(
        body: BlocListener<DashboardBloc, DashboardState>(
            listener: (context, state) {
      if (state.data != null && state.data.isNotEmpty) {
        if (_dashboardState.locationName != state.locationName) {
          switch (state.locationName) {
            case locUsers:
              _model = DashboardModel(UserDataSource(context: context, userData: state.data));
              break;
            case locDepartement:
              _model =
                  DashboardModel(DepartmentDataSource(context: context, depData: state.data));
              break;
            case locProducts:
              _model =
                  DashboardModel(ProductsDatasource(context: context, productData: state.data));
              break;
            case locSizes:
              _model = DashboardModel(SizeDatasource(context: context, sizeData: state.data));
              break;
            case locPathners:
              _model =
                  DashboardModel(PartnerDatasource(context: context, partnerData: state.data));
              break;
            case locProductStatuses:
              _model = DashboardModel(ProductStatusDatasource(context: context, productStatuses: state.data));
              break;
            default:
              break;
          }
        } else {
          _model!.datasource.data.addAll(state.data);
        }
        _dashboardState = state;
      }
    }, child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            height: 40,
            width: double.infinity,
            decoration: const BoxDecoration(color: color_header_background),
            child: Row(
              children: [
                Text(prefs.getString(key_user_branch)!,
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
                Text(state.locationName,
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
                Expanded(child: Container()),
                SvgButton(
                  onTap: () {},
                  assetPath: 'svg/user.svg',
                  caption: prefs.getString(key_full_name)!,
                )
              ],
            )),
        Expanded(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              AnimatedContainer(
                  color: color_menu_background,
                  duration: const Duration(milliseconds: 200),
                  width: state.expandMenu ? 240 : 60,
                  height: MediaQuery.of(context).size.height,
                  child: ClipRect(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(children: [
                            Row(
                              children: [
                                SvgButton(
                                    onTap: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .eventToState(DashboardActionMenu(
                                              !state.expandMenu, false, false));
                                    },
                                    assetPath: 'svg/dashboard.svg'),
                                TextMouseButton(
                                    onTap: () {}, caption: L.tr('Dashboard'))
                              ],
                            ),
                            Row(
                              children: [
                                SvgButton(
                                    onTap: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .eventToState(DashboardActionMenu(
                                              false, false, false));
                                    },
                                    assetPath: 'svg/management.svg'),
                                TextMouseButton(
                                    onTap: () {}, caption: L.tr('Management'))
                              ],
                            ),
                            Row(
                              children: [
                                SvgButton(
                                    onTap: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .eventToState(DashboardActionMenu(
                                              false, false, false));
                                    },
                                    assetPath: 'svg/tv.svg'),
                                TextMouseButton(
                                    onTap: () {}, caption: L.tr('TV'))
                              ],
                            ),
                            Row(
                              children: [
                                SvgButton(
                                    onTap: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .eventToState(DashboardActionMenu(
                                              false, false, false));
                                    },
                                    assetPath: 'svg/document.svg'),
                                TextMouseButton(
                                    onTap: () {}, caption: L.tr('Orders'))
                              ],
                            ),
                            Row(
                              children: [
                                SvgButton(
                                    onTap: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .eventToState(DashboardActionMenu(
                                              false, false, false));
                                    },
                                    assetPath: 'svg/truck.svg'),
                                TextMouseButton(
                                    onTap: () {}, caption: L.tr('Loading'))
                              ],
                            ),
                            Row(
                              children: [
                                SvgButton(
                                    onTap: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .eventToState(DashboardActionMenu(
                                              false, false, false));
                                    },
                                    assetPath: 'svg/calendar.svg'),
                                TextMouseButton(
                                    onTap: () {}, caption: L.tr('Plans'))
                              ],
                            ),
                            Row(
                              children: [
                                SvgButton(
                                    onTap: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .eventToState(DashboardActionMenu(
                                              false, false, false));
                                    },
                                    assetPath: 'svg/qrcode.svg'),
                                TextMouseButton(
                                    onTap: () {},
                                    caption: L.tr("Department of QR codes")),
                              ],
                            ),
                            Row(
                              children: [
                                SvgButton(
                                    onTap: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .eventToState(DashboardActionMenu(
                                              false, false, false));
                                    },
                                    assetPath: 'svg/storehouse.svg'),
                                TextMouseButton(
                                    onTap: () {}, caption: L.tr("Storehouse"))
                              ],
                            ),
                            Row(children: [
                              SvgButton(
                                  onTap: () {
                                    BlocProvider.of<DashboardBloc>(context)
                                        .eventToState(DashboardActionMenu(
                                            false, false, false));
                                  },
                                  assetPath: 'svg/reports.svg'),
                              TextMouseButton(
                                  onTap: () {}, caption: L.tr('Reports'))
                            ]),
                            Row(
                              children: [
                                SvgButton(
                                    onTap: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .eventToState(DashboardActionMenu(
                                              !state.expandMenu,
                                              !state.expandMenu,
                                              false));
                                    },
                                    assetPath: 'svg/folder.svg'),
                                TextMouseButton(
                                    onTap: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .eventToState(DashboardActionMenu(
                                              state.expandMenu,
                                              !state.expandDirectory,
                                              false));
                                    },
                                    caption: L.tr('Directory'))
                              ],
                            ),
                            AnimatedContainer(
                                height: state.expandDirectory ? 40 * 7 : 0,
                                duration: const Duration(milliseconds: 200),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      TextMouseButton(
                                          onTap: () {
                                            BlocProvider.of<DashboardBloc>(
                                                    context)
                                                .eventToState(
                                                    DashboardActionLoadData(
                                                        locUsers));
                                          },
                                          caption: L.tr('Users')),
                                      TextMouseButton(
                                          onTap: () {
                                            BlocProvider.of<DashboardBloc>(
                                                    context)
                                                .eventToState(
                                                    DashboardActionLoadData(
                                                        locDepartement));
                                          },
                                          caption: L.tr('Departments')),
                                      TextMouseButton(
                                          onTap: () {
                                            BlocProvider.of<DashboardBloc>(
                                                    context)
                                                .eventToState(
                                                    DashboardActionLoadData(
                                                        locProducts));
                                          },
                                          caption: L.tr('Products')),
                                      TextMouseButton(
                                          onTap: () {
                                            BlocProvider.of<DashboardBloc>(
                                                context)
                                                .eventToState(
                                                DashboardActionLoadData(
                                                    locProductStatuses));
                                          },
                                          caption: L.tr('Products states')),
                                      TextMouseButton(
                                          onTap: () {
                                            BlocProvider.of<DashboardBloc>(
                                                    context)
                                                .eventToState(
                                                    DashboardActionLoadData(
                                                        locPathners));
                                          },
                                          caption: L.tr('Partners')),
                                      TextMouseButton(
                                          onTap: () {
                                            BlocProvider.of<DashboardBloc>(
                                                    context)
                                                .eventToState(
                                                    DashboardActionMenu(
                                                        false, false, false));
                                          },
                                          caption: L.tr('Permissions')),
                                      TextMouseButton(
                                          onTap: () {
                                            BlocProvider.of<DashboardBloc>(
                                                    context)
                                                .eventToState(
                                                    DashboardActionLoadData(
                                                        locSizes));
                                          },
                                          caption: L.tr('Units'))
                                    ],
                                  ),
                                )),
                            Row(
                              children: [
                                SvgButton(
                                    onTap: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .eventToState(DashboardActionMenu(
                                              !state.expandMenu,
                                              false,
                                              !state.expandMenu));
                                    },
                                    assetPath: 'svg/earth.svg'),
                                TextMouseButton(
                                    onTap: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .eventToState(DashboardActionMenu(
                                              state.expandMenu,
                                              false,
                                              !state.expandLanguage));
                                    },
                                    caption: L.tr('Language'))
                              ],
                            ),
                            AnimatedContainer(
                                height: state.expandLanguage ? 40 * 2 : 0,
                                duration: const Duration(milliseconds: 200),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      TextMouseButton(
                                          onTap: () {
                                            BlocProvider.of<DashboardBloc>(
                                                    context)
                                                .eventToState(
                                                    DashboardActionMenu(
                                                        false, false, false));
                                          },
                                          caption: L.tr('Armenian')),
                                      TextMouseButton(
                                          onTap: () {
                                            BlocProvider.of<DashboardBloc>(
                                                    context)
                                                .eventToState(
                                                    DashboardActionMenu(
                                                        false, false, false));
                                          },
                                          caption: L.tr('Italy')),
                                    ],
                                  ),
                                )),
                          ])))),
              Expanded(child: _dashboardDataChild(state.locationName))
            ]))
      ]);
    })));
  }

  Widget _dashboardDataChild(String location) {
    switch (location) {
      case locUsers:
      case locDepartement:
      case locProducts:
      case locSizes:
      case locPathners:
      case locProductStatuses:
        return SfDataGrid(
            source: _model!.datasource, columns: _model!.datasource.columns);
    }
    return Align(
      alignment: Alignment.center,
      child: Text(L.tr('Get started!')),
    );
  }
}
