import 'package:flutter/cupertino.dart';
import 'package:sartex/data/data_sizes.dart';
import 'package:sartex/screen/preloading/preloading_size.dart';
import 'package:sartex/utils/translator.dart';

class PreloadingItem {
  final TextEditingController brand = TextEditingController();
  final TextEditingController model = TextEditingController();
  final TextEditingController commesa = TextEditingController();
  final TextEditingController color = TextEditingController();
  final TextEditingController variant = TextEditingController();
  final TextEditingController country = TextEditingController();

  final List<TextEditingController> sizes = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    //total
    TextEditingController(text: L.tr('Total')),
  ];
  final List<TextEditingController> remains = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    //total
    TextEditingController(),
  ];
  final List<TextEditingController> newvalues = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    //total
    TextEditingController(),
  ];
  final List<TextEditingController> pahest = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    //total
    TextEditingController(),
  ];
  PreloadingSize? preSize;

  String sumOfMnacord() {
    return sumOfList(remains);
  }

  String sumOfPahest() {
    return sumOfList(pahest);
  }

  String sumOfNewValues() {
    return sumOfList(newvalues);
  }

  String sumOfList(List<TextEditingController> l) {
    int total = 0;
    for (int i = 0; i < l.length - 1; i++) {
      total += int.tryParse(l[i].text) ?? 0;
    }
    return total.toString();
  }
}