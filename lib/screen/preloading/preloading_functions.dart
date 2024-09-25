import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:sartex/screen/preloading/preloading_screen.dart';
import 'package:sartex/utils/translator.dart';

class PreloadingFunction {
  final PreloadingScreen widget;
  
  PreloadingFunction({required this.widget});


  
  void exportToExcel(BuildContext context) {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    CellStyle cellStyle = CellStyle(
        backgroundColorHex: ExcelColor.fromHexString('#1AFF1A'),
        fontFamily: getFontFamily(FontFamily.Calibri));

    CellStyle cellLine = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        backgroundColorHex: ExcelColor.fromHexString('#${Color(0xff31cafa).value.toRadixString(16)}'),
        fontFamily: getFontFamily(FontFamily.Calibri),
        bold: true,
        fontColorHex: ExcelColor.fromHexString("#FFFFFF"),
        fontSize: 20);

    CellStyle cellGray = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        backgroundColorHex: ExcelColor.fromHexString('#${Color(0xffb7b6b6).value.toRadixString(16)}'),
        fontFamily: getFontFamily(FontFamily.Calibri),
        bold: true,
        fontColorHex: ExcelColor.fromHexString("#000000"),
        fontSize: 14);

    CellStyle cellWhite = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        backgroundColorHex: ExcelColor.fromHexString('#${Color(0xffffffff).value.toRadixString(16)}'),
        fontFamily: getFontFamily(FontFamily.Calibri),
        bold: true,
        fontColorHex: ExcelColor.fromHexString("#000000"),
        fontSize: 14);

    CellStyle cellGreen = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        backgroundColorHex: ExcelColor.fromHexString('#${Color(0xff93ff7b).value.toRadixString(16)}'),
        fontFamily: getFontFamily(FontFamily.Calibri),
        bold: true,
        fontColorHex: ExcelColor.fromHexString("#000000"),
        fontSize: 14);

    CellStyle cellRed = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        backgroundColorHex: ExcelColor.fromHexString('#${Color(0xffff8e8e).value.toRadixString(16)}'),
        fontFamily: getFontFamily(FontFamily.Calibri),
        bold: true,
        fontColorHex: ExcelColor.fromHexString("#000000"),
        fontSize: 14);

    cellStyle.underline = Underline.Single;
    var cell = sheetObject.cell(CellIndex.indexByString('A1'));
    cell.value = TextCellValue(L.tr('DocNum')); // dynamic values support provided;
    cell.cellStyle = cellStyle;
    cell = sheetObject.cell(CellIndex.indexByString('A2'));
    cell.value = TextCellValue(widget.model.editDocNum.text);
    cell.cellStyle = cellStyle;

    cell = sheetObject.cell(CellIndex.indexByString('B1'));
    cell.value = TextCellValue(L.tr('Date')); // dynamic values support provided;
    cell.cellStyle = cellStyle;
    cell = sheetObject.cell(CellIndex.indexByString('B2'));
    cell.value = TextCellValue(widget.model.editDate.text);
    cell.cellStyle = cellStyle;

    cell = sheetObject.cell(CellIndex.indexByString('C1'));
    cell.value = TextCellValue(L.tr('Truck')); // dynamic values support provided;
    cell.cellStyle = cellStyle;
    cell = sheetObject.cell(CellIndex.indexByString('C2'));
    cell.value = TextCellValue(widget.model.editTruck.text);
    cell.cellStyle = cellStyle;

    cell = sheetObject.cell(CellIndex.indexByString('D1'));
    cell.value = TextCellValue(L.tr('Store')); // dynamic values support provided;
    cell.cellStyle = cellStyle;
    cell = sheetObject.cell(CellIndex.indexByString('D2'));
    cell.value = TextCellValue(widget.model.editStore.text);
    cell.cellStyle = cellStyle;

    cell = sheetObject.cell(CellIndex.indexByString('E1'));
    cell.value = TextCellValue(L.tr('Receipant')); // dynamic values support provided;
    cell.cellStyle = cellStyle;
    cell = sheetObject.cell(CellIndex.indexByString('E2'));
    cell.value = TextCellValue(widget.model.editReceipant.text);
    cell.cellStyle = cellStyle;

    int r = 4;
    for (final l in widget.model.prReadyLines) {
      cell = sheetObject.cell(CellIndex.indexByString('A$r'));
      cell.cellStyle = cellLine;
      cell.value = TextCellValue(l.prLine);
      sheetObject.merge(
          CellIndex.indexByString('A$r'), CellIndex.indexByString('S$r'));
      for (int i = 0; i < 17; i++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: r))
            .cellStyle = cellLine;
      }

      r++;
      for (final m in l.items) {
        //header
        cell = sheetObject.cell(CellIndex.indexByString('A$r'));
        cell.cellStyle = cellGray;
        cell.value =TextCellValue( L.tr('Brand'));

        cell = sheetObject.cell(CellIndex.indexByString('B$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(L.tr('Model'));

        cell = sheetObject.cell(CellIndex.indexByString('C$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(L.tr('Commesa'));

        cell = sheetObject.cell(CellIndex.indexByString('D$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(L.tr('Country'));

        cell = sheetObject.cell(CellIndex.indexByString('E$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(L.tr('Color'));

        cell = sheetObject.cell(CellIndex.indexByString('F$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(L.tr('Variant'));

        cell = sheetObject.cell(CellIndex.indexByString('G$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(m.preSize!.size[0]);

        cell = sheetObject.cell(CellIndex.indexByString('H$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(m.preSize!.size[1]);

        cell = sheetObject.cell(CellIndex.indexByString('I$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(m.preSize!.size[2]);

        cell = sheetObject.cell(CellIndex.indexByString('J$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(m.preSize!.size[3]);

        cell = sheetObject.cell(CellIndex.indexByString('K$r'));
        cell.cellStyle = cellGray;
        cell.value =TextCellValue( m.preSize!.size[4]);

        cell = sheetObject.cell(CellIndex.indexByString('L$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(m.preSize!.size[5]);

        cell = sheetObject.cell(CellIndex.indexByString('M$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(m.preSize!.size[6]);

        cell = sheetObject.cell(CellIndex.indexByString('N$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(m.preSize!.size[7]);

        cell = sheetObject.cell(CellIndex.indexByString('O$r'));
        cell.cellStyle = cellGray;
        cell.value =TextCellValue( m.preSize!.size[7]);

        cell = sheetObject.cell(CellIndex.indexByString('P$r'));
        cell.cellStyle = cellGray;
        cell.value =TextCellValue( m.preSize!.size[8]);

        cell = sheetObject.cell(CellIndex.indexByString('Q$r'));
        cell.cellStyle = cellGray;
        cell.value =TextCellValue( m.preSize!.size[10]);

        cell = sheetObject.cell(CellIndex.indexByString('R$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(m.preSize!.size[11]);

        cell = sheetObject.cell(CellIndex.indexByString('S$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(L.tr('Total'));
        r++;

        //model, brand text
        cell = sheetObject.cell(CellIndex.indexByString('A$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(m.brand.text);

        cell = sheetObject.cell(CellIndex.indexByString('B$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(m.model.text);

        cell = sheetObject.cell(CellIndex.indexByString('C$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(m.commesa.text);

        cell = sheetObject.cell(CellIndex.indexByString('D$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(m.country.text);

        cell = sheetObject.cell(CellIndex.indexByString('E$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(m.color.text);

        cell = sheetObject.cell(CellIndex.indexByString('F$r'));
        cell.cellStyle = cellGray;
        cell.value = TextCellValue(m.variant.text);

        //newvalues
        cell = sheetObject.cell(CellIndex.indexByString('G$r'));
        cell.cellStyle = cellGray;
        cell.value = IntCellValue(int.tryParse(m.newvalues[0].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('H$r'));
        cell.cellStyle = cellGray;
        cell.value = IntCellValue(int.tryParse(m.newvalues[1].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('I$r'));
        cell.cellStyle = cellGray;
        cell.value = IntCellValue(int.tryParse(m.newvalues[2].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('J$r'));
        cell.cellStyle = cellGray;
        cell.value = IntCellValue(int.tryParse(m.newvalues[3].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('K$r'));
        cell.cellStyle = cellGray;
        cell.value = IntCellValue(int.tryParse(m.newvalues[4].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('L$r'));
        cell.cellStyle = cellGray;
        cell.value = IntCellValue(int.tryParse(m.newvalues[5].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('M$r'));
        cell.cellStyle = cellGray;
        cell.value = IntCellValue(int.tryParse(m.newvalues[6].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('N$r'));
        cell.cellStyle = cellGray;
        cell.value = IntCellValue(int.tryParse(m.newvalues[7].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('O$r'));
        cell.cellStyle = cellGray;
        cell.value = IntCellValue(int.tryParse(m.newvalues[8].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('P$r'));
        cell.cellStyle = cellGray;
        cell.value = IntCellValue(int.tryParse(m.newvalues[9].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('Q$r'));
        cell.cellStyle = cellGray;
        cell.value = IntCellValue(int.tryParse(m.newvalues[10].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('R$r'));
        cell.cellStyle = cellGray;
        cell.value = IntCellValue(int.tryParse(m.newvalues[11].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('S$r'));
        cell.cellStyle = cellGray;
        cell.value = IntCellValue(int.tryParse(m.newvalues[12].text) ?? 0);
        r++;

        //remains
        cell = sheetObject.cell(CellIndex.indexByString('G$r'));
        cell.cellStyle = cellGreen;
        cell.value = IntCellValue(int.tryParse(m.pahest[0].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('H$r'));
        cell.cellStyle = cellGreen;
        cell.value = IntCellValue(int.tryParse(m.pahest[1].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('I$r'));
        cell.cellStyle = cellGreen;
        cell.value = IntCellValue(int.tryParse(m.pahest[2].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('J$r'));
        cell.cellStyle = cellGreen;
        cell.value = IntCellValue(int.tryParse(m.pahest[3].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('K$r'));
        cell.cellStyle = cellGreen;
        cell.value = IntCellValue(int.tryParse(m.pahest[4].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('L$r'));
        cell.cellStyle = cellGreen;
        cell.value = IntCellValue(int.tryParse(m.pahest[5].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('M$r'));
        cell.cellStyle = cellGreen;
        cell.value = IntCellValue(int.tryParse(m.pahest[6].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('N$r'));
        cell.cellStyle = cellGreen;
        cell.value = IntCellValue(int.tryParse(m.pahest[7].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('O$r'));
        cell.cellStyle = cellGreen;
        cell.value = IntCellValue(int.tryParse(m.pahest[8].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('P$r'));
        cell.cellStyle = cellGreen;
        cell.value = IntCellValue(int.tryParse(m.pahest[9].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('Q$r'));
        cell.cellStyle = cellGreen;
        cell.value = IntCellValue(int.tryParse(m.pahest[10].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('R$r'));
        cell.cellStyle = cellGreen;
        cell.value = IntCellValue(int.tryParse(m.pahest[11].text) ?? 0);

        cell = sheetObject.cell(CellIndex.indexByString('S$r'));
        cell.cellStyle = cellGreen;
        cell.value =IntCellValue( int.tryParse(m.pahest[12].text) ?? 0);
        r++;

        //diffs
        int diff = (int.tryParse(m.pahest[0].text) ?? 0) -
            (int.tryParse(m.newvalues[0].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('G$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = IntCellValue(diff);

        diff = (int.tryParse(m.pahest[1].text) ?? 0) -
            (int.tryParse(m.newvalues[1].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('H$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = IntCellValue(diff);

        diff = (int.tryParse(m.pahest[2].text) ?? 0) -
            (int.tryParse(m.newvalues[2].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('I$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = IntCellValue(diff);

        diff = (int.tryParse(m.pahest[3].text) ?? 0) -
            (int.tryParse(m.newvalues[3].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('J$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = IntCellValue(diff);

        diff = (int.tryParse(m.pahest[4].text) ?? 0) -
            (int.tryParse(m.newvalues[4].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('K$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = IntCellValue(diff);

        diff = (int.tryParse(m.pahest[5].text) ?? 0) -
            (int.tryParse(m.newvalues[5].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('L$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = IntCellValue(diff);

        diff = (int.tryParse(m.pahest[6].text) ?? 0) -
            (int.tryParse(m.newvalues[6].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('M$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = IntCellValue(diff);

        diff = (int.tryParse(m.pahest[7].text) ?? 0) -
            (int.tryParse(m.newvalues[7].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('N$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = IntCellValue(diff);

        diff = (int.tryParse(m.pahest[8].text) ?? 0) -
            (int.tryParse(m.newvalues[8].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('O$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = IntCellValue(diff);

        diff = (int.tryParse(m.pahest[9].text) ?? 0) -
            (int.tryParse(m.newvalues[9].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('P$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = IntCellValue(diff);

        diff = (int.tryParse(m.pahest[10].text) ?? 0) -
            (int.tryParse(m.newvalues[10].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('Q$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = IntCellValue(diff);

        diff = (int.tryParse(m.pahest[11].text) ?? 0) -
            (int.tryParse(m.newvalues[11].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('R$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = IntCellValue(diff);

        diff = (int.tryParse(m.pahest[12].text) ?? 0) -
            (int.tryParse(m.newvalues[12].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('S$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = IntCellValue(diff);
        r++;
        r++;
      }
      r++;
    }

    for (int i = 0; i < 17; i++) {
      sheetObject.setColumnAutoFit(i);
    }

    var fileBytes = excel.save(fileName: 'preloading.xlsx');  
  }
  
}