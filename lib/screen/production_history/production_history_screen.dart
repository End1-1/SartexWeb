import 'package:sartex/screen/app_grid_window/app_grid_screen.dart';
import 'package:sartex/screen/production_history/production_history_model.dart';
import 'package:sartex/utils/translator.dart';

class ProductionHistoryScreen extends AppGridScreen {
  ProductionHistoryScreen() : super(title: L.tr('Production'), model: ProductionHistoryModel());

}