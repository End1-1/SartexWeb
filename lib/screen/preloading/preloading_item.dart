import 'package:flutter/cupertino.dart';
import 'package:sartex/data/data_sizes.dart';
import 'package:sartex/screen/preloading/preloading_size.dart';

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
  ];
  final List<TextEditingController> diffvalues = [
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
  ];
  DataSize? size;
  PreloadingSize? preSize;
}