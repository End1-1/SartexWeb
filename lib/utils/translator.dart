import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/utils/consts.dart';
part 'translator.freezed.dart';
part 'translator.g.dart';

@freezed
class TranslatorItem with _$TranslatorItem {
  TranslatorItem._();
  final TextEditingController amController = TextEditingController();
  final TextEditingController itController = TextEditingController();
  factory TranslatorItem({required String key, required String am, required String it}) = _TranslatorItem;
  factory TranslatorItem.fromJson(Map<String, dynamic> json) => _$TranslatorItemFromJson(json);
}

@freezed
class TranslatorItemList with _$TranslatorItemList {
  const factory TranslatorItemList({required List<TranslatorItem> list}) = _TranslatorItemList;
  factory TranslatorItemList.fromJson(Map<String,dynamic> json) => _$TranslatorItemListFromJson(json);
}

final Translator L = Translator();

class Translator {
  Map<String, TranslatorItem> items = {};
  String language = '';
  String tr(String s) {
    if (!items.containsKey(s)) {
      items[s.toLowerCase()] = TranslatorItem(key: s, am: s, it: s);
    }
    switch (language) {
      case key_language_am:
        return items[s]?.am ?? s;
      case key_language_it:
        return items[s]?.it ?? s;
      default:
        return s;
    }
  }
}