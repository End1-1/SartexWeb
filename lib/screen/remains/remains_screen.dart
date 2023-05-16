import 'package:sartex/screen/app_grid_window/app_grid_screen.dart';
import 'package:sartex/screen/remains/model.dart';
import 'package:sartex/utils/translator.dart';

class RemainsScreen extends AppGridScreen {
  RemainsScreen() : super(title: L.tr('Remains'), model: RemainsModel(), plusButton: false);

}