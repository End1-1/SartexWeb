import 'package:sartex/utils/text_editing_controller.dart';

import '../../utils/translator.dart';

class LanguageModel {
  int editRowNumber = -1;
  List<TranslatorItem> filteredItem() {
    return L.items.values.toList();
  }
}