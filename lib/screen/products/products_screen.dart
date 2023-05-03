import 'package:sartex/screen/app_grid_window/app_grid_screen.dart';
import 'package:sartex/screen/products/products_model.dart';
import 'package:sartex/utils/translator.dart';

class ProductsScreen extends AppGridScreen {
  ProductsScreen({super.key}) : super(title: L.tr('Products'), model: ProductsModel());

}
