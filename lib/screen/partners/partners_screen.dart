import 'package:sartex/screen/app_grid_window/app_grid_screen.dart';
import 'package:sartex/screen/partners/partners_model.dart';
import 'package:sartex/utils/translator.dart';

class PartnersScreen extends AppGridScreen{
  PartnersScreen({super.key}) : super(title: L.tr('Partners'), model: PartnersModel());

}