import 'package:sartex/screen/app_grid_window/app_grid_screen.dart';
import 'package:sartex/screen/store_docs/store_docs_model.dart';
import 'package:sartex/utils/translator.dart';

class StoreDocsScreen extends AppGridScreen {
  StoreDocsScreen({super.key})
      : super(title: L.tr('Store documents'), model: StoreDocsModel());
}
