import 'package:sartex/screen/app_grid_window/app_grid_screen.dart';
import 'package:sartex/screen/sizes/sizes_model.dart';
import 'package:sartex/utils/translator.dart';

class SizesScreen extends AppGridScreen {
  SizesScreen({super.key}) : super(model: SizesModel(), title: L.tr('Sizes'));

}