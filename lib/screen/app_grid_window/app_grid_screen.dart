import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/screen/app/app_bloc.dart';
import 'package:sartex/screen/app/app_screen.dart';
import 'package:sartex/widgets/svg_button.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

abstract class AppGridScreen extends App {
  final bool plusButton;
  final bool filterButton;
  final gridKey = GlobalKey<SfDataGridState>();
  final VoidCallback?  tapBack;


  AppGridScreen(
      {super.key,
      required super.model,
      required super.title,
      this.plusButton = true,
      this.filterButton = false,
      this.tapBack});

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
                  color: Colors.indigo,
                  fontSize: 12,
                )),
            child: SfDataGrid(
              key: gridKey,
                onQueryRowHeight: (details) {
                  return 30.0;
                },
                tableSummaryRows: (model!.datasource as SartexDataGridSource).sumRows,
                allowColumnsResizing: true,
                allowFiltering: true,
                allowSorting: true,
                isScrollbarAlwaysShown: true,
                onCellTap: (details) { cellTap(context, details);},
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
      ],
      if (tapBack != null)
        SvgButton(onTap: (){onTapBack(context);}, assetPath: 'svg/left.svg'),

      SvgButton(
          onTap: () async {

            final Workbook workbook =
            gridKey.currentState!.exportToExcelWorkbook();
            final List<int> bytes = workbook.saveAsStream();
            workbook.dispose();

            final blob = html.Blob([bytes]);
            final url = html.Url.createObjectUrlFromBlob(blob);
            final anchor = html.document.createElement('a') as html.AnchorElement
              ..href = url
              ..style.display = 'none'
              ..download = '$title.xlsx';
            html.document.body?.children.add(anchor);
            anchor.click();

            html.document.body?.children.remove(anchor);
            html.Url.revokeObjectUrl(url);


          },
          assetPath: 'svg/excel.svg')
    ];
  }

cellTap(BuildContext context, DataGridCellTapDetails details) {
  var id = model.datasource
      .effectiveRows[details.rowColumnIndex.rowIndex - 1]
      .getCells()[0]
      .value;
  model.datasource.editData(context, id).then((value) {
    refreshData(context);
  });
}

  void showFilter(BuildContext context) {

  }

  void refreshData(BuildContext context) {
    BlocProvider.of<AppBloc>(context).add(GELoadData(model.sql()));
  }

  void onTapBack(BuildContext context) {

  }
}
