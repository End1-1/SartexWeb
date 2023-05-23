import 'package:sartex/screen/app_grid_window/app_grid_screen.dart';
import 'package:sartex/screen/product_type_code/product_type_code_model.dart';
import 'package:sartex/utils/translator.dart';

class ProductTypeCodeScreen extends AppGridScreen {
  ProductTypeCodeScreen() : super(title: L.tr('Product type code'), model: ProductTypeCodeModel());

}