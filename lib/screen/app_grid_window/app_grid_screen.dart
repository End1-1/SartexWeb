import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sartex/screen/app/app_bloc.dart';
import 'package:sartex/screen/app/app_screen.dart';
import 'package:sartex/screen/patver_data/filter_widget.dart';
import 'package:sartex/widgets/svg_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

abstract class AppGridScreen extends App {
  final bool plusButton;
  final bool filterButton;

  AppGridScreen(
      {super.key,
      required super.model,
      required super.title,
      this.plusButton = true,
      this.filterButton = false});

  @override
  Widget body(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      if (state is GSIdle) {
        BlocProvider.of<AppBloc>(context).add(GELoadData(model.sql()));
      }
      if (state is GSData) {
        model.createDatasource();
        model.datasource.addRows(state.data);
        return SfDataGridTheme(
            data: SfDataGridThemeData(
              headerColor: const Color(0xff00ab7c),
                rowHoverColor: Colors.yellow,
                rowHoverTextStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                )),
            child: SfDataGrid(
                allowColumnsResizing: true,
                allowFiltering: true,
                allowSorting: true,
                isScrollbarAlwaysShown: true,
                onCellDoubleTap: (details) {
                  var id = model.datasource
                      .effectiveRows[details.rowColumnIndex.rowIndex - 1]
                      .getCells()[0]
                      .value;
                  model.datasource.editData(context, id).then((value) {
                    refreshData(context);
                  });
                },
                columnWidthMode: state.data.isEmpty ? ColumnWidthMode.fitByColumnName : ColumnWidthMode.auto,
                source: model!.datasource,
                columns: model!.datasource.columns));
      }
      return const Align(
          alignment: Alignment.center, child: CircularProgressIndicator());
    });
  }

  @override
  List<Widget> titleWidget(BuildContext context) {
    return [
      if (plusButton) ...[
        SvgButton(
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      children: [model!.datasource.getEditWidget(context, '')],
                    );
                  }).then((value) {
                if (value != null) {
                  refreshData(context);
                }
              });
            },
            assetPath: 'svg/plusfolder.svg')
      ],
      if (filterButton) ...[
        SvgButton(
            onTap: () {
              showFilter(context);
            },
            assetPath: 'svg/filter.svg')
      ]
    ];
  }

  void showFilter(BuildContext context) {

  }

  void refreshData(BuildContext context) {
    BlocProvider.of<AppBloc>(context).add(GELoadData(model.sql()));
  }
}
