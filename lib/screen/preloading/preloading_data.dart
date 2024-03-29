import 'package:sartex/data/data_sizes.dart';
import 'package:sartex/screen/preloading/preloading_item.dart';
import 'package:sartex/screen/preloading/preloading_size.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';

class PreloadingData {
  List<String> brandLevel = [];
  List<String> modelLevel = [];
  List<String> commesaLevel = [];
  List<String> countryLevel = [];
  List<String> colorLevel = [];
  List<String> variantLevel = [];
  Map<String, DataSize> sizeStandartList = {};
  String? country;
  String? sizeStandart;
  String? aprId;
  String? pid;

  PreloadingData() {
    HttpSqlQuery.post({
      "sl":
      "select distinct(pd.brand) from Apranq a left join patver_data pd on pd.id=a.pid where pd.status='inProgress'"
    }).then((value) {
      brandLevel.clear();
      for (var e in value) {
        brandLevel.add(e['brand']);
      }
    });
    HttpSqlQuery.post({'sl': 'select * from Sizes'}).then((value) {
      SizeList sl = SizeList.fromJson({'sizes': value});
      for (var e in sl.sizes) {
        sizeStandartList[e.code!] = e;
      }
    });
  }

  void buildModelList(String brand, String pahest) {
    HttpSqlQuery.post({
      "sl":
      "select distinct(pd.Model) from Apranq a left join Mnacord m on m.apr_id=a.apr_id "
          "left join patver_data pd on pd.id=a.pid where pd.status='inProgress' "
          "and brand='$brand' and a.branch='${prefs.branch()}' "
    }).then((value) {
      modelLevel.clear();
      for (var e in value) {
        modelLevel.add(e['Model']);
      }
    });
  }

  Future<void> buildCommesaLevel(String brand, String model, String pahest) async {
    var value = await HttpSqlQuery.post({
      "sl":
      "select distinct(pd.PatverN) from Apranq a left join Mnacord m on m.apr_id=a.apr_id "
          "left join patver_data pd on pd.id=a.pid "
          "where pd.status='inProgress' and brand='$brand' and Model='$model' "
          "and a.branch='${prefs.branch()}' "
    });
      commesaLevel.clear();
      for (var e in value) {
        commesaLevel.add(e['PatverN']);
      }
  }

  Future<void> buildCountryLevel(String brand, String model, String commesa, String pahest) async {
    var value = await HttpSqlQuery.post({
      "sl":
      "select distinct(pd.country) from Apranq a left join Mnacord m on m.apr_id=a.apr_id "
          " left join patver_data pd on pd.id=a.pid "
          "where pd.status='inProgress' and brand='$brand' and Model='$model' "
          "and PatverN='$commesa' and a.branch='${prefs.branch()}' "
    });
      countryLevel.clear();
      for (var e in value) {
        countryLevel.add(e['country']);
      }
  }

  Future<void> buildColorLevel(String brand, String model, String commesa, String country, String pahest) async {
    var value = await HttpSqlQuery.post({
      "sl":
      "select distinct(pd.Colore) from Apranq a "
          "left join Mnacord m on m.apr_id=a.apr_id "
          "left join patver_data pd on pd.id=a.pid where pd.status='inProgress' "
          "and brand='$brand' and Model='$model' and PatverN='$commesa' "
              "and country='$country' and a.branch='${prefs.branch()}' "
    });
      colorLevel.clear();
      for (var e in value) {
        colorLevel.add(e['Colore']);
      }
  }

  Future<void> buildVariantLevel(
      String brand, String model, String commesa, String country, String color, String pahest) async {
    var value = await HttpSqlQuery.post({
      "sl":
      "select distinct(pd.variant_prod) from Apranq a "
          "left join Mnacord m on m.apr_id=a.apr_id "
          "left join patver_data pd on pd.id=a.pid "
          "where pd.status='inProgress' "
          "and brand='$brand' and Model='$model' and PatverN='$commesa' "
              "and Colore='$color' and country='$country' and a.branch='${prefs.branch()}'"
    });
      variantLevel.clear();
      for (var e in value) {
        variantLevel.add(e['variant_prod']);
      }
  }

  Future<void> autoFillPatverCountryColorVariant(String brand, String model, String pahest) async {
    var value = await HttpSqlQuery.post({
      "sl":
      "select distinct(pd.country) as country from Apranq a "
          "left join Mnacord m on m.apr_id=a.apr_id "
          "left join patver_data pd on pd.id=a.pid "
          "where pd.status='inProgress' and m.pahest='${pahest}' "
          + "and brand='$brand' and Model='$model'  "
    });
    commesaLevel.clear();
    countryLevel.clear();
    colorLevel.clear();
    variantLevel.clear();
    if (value.length == 1){
      var e = value.first;
      countryLevel.add(e['country']);
    }
  }

  Future<void> autoFillCountryColorVariant(String brand, String model, String commesa, String pahest) async {
    var value = await HttpSqlQuery.post({
      "sl":
      "select distinct(pd.country)  from Apranq a "
          "left join Mnacord m on m.apr_id=a.apr_id "
          "left join patver_data pd on pd.id=a.pid "
          "where pd.status='inProgress' and m.pahest='${pahest}'"
          "and brand='$brand' and Model='$model' and PatverN='$commesa'  "
    });
    countryLevel.clear();
    colorLevel.clear();
    variantLevel.clear();
    if (value.length == 1) {
      for (var e in value) {
        countryLevel.add(e['country']);
      }
    }
  }

  Future<void> autoFillColorVariant(String brand, String model, String commesa, String country, String pahest) async {
    var value = await HttpSqlQuery.post({
      "sl":
      "select pd.Colore, pd.variant_prod "
          "from Apranq a "
          "left join Mnacord m on m.apr_id=a.apr_id "
          "left join patver_data pd on pd.id=a.pid "
          "where pd.status='inProgress' and m.pahest='${pahest}' "
          "and brand='$brand' and Model='$model' and PatverN='$commesa' and country='$country' "
    });
    if (value.length == 1) {
      colorLevel.clear();
      variantLevel.clear();
      for (var e in value) {
        colorLevel.add(e['Colore']);
        variantLevel.add(e['variant_prod']);
      }
    }
  }

  Future<void> getSizes(
      String brand, String model, String commesa, String country, String color, String variant, PreloadingItem s, String pahest) async {

    List<dynamic> notZero = await await HttpSqlQuery.post({
      "sl":
      "select pd.id, sum(a.pat_mnac) as pat_mnac "
          "from Apranq a "
          "left join Mnacord m on m.apr_id=a.apr_id  "
          "left join patver_data pd on pd.id=a.pid "
          "where pd.status='inProgress' "
          "and brand='$brand' and Model='$model' and PatverN='$commesa' "
          "and country='$country' and Colore='$color' and variant_prod='$variant' and a.branch='${prefs.branch()}' "
          "group by 1 "
          "having sum(a.pat_mnac)>0 "
    });
    var noZeroPid = '';
    if (notZero.isNotEmpty) {
      noZeroPid = notZero[0]['id'];
    }
    if (noZeroPid.isEmpty) {
      return;
    }

    List<dynamic> l = await HttpSqlQuery.post({
      "sl":
      "select pd.size_standart, pd.id "
          "from Apranq a "
          "left join Mnacord m on m.apr_id=a.apr_id  "
          "left join patver_data pd on pd.id=a.pid "
          "where pd.status='inProgress' and pd.id='$noZeroPid' "
          "and brand='$brand' and Model='$model' and PatverN='$commesa' "
          "and country='$country' and Colore='$color' and a.branch='${prefs.branch()}' "
    });
    if (l.isNotEmpty) {
      Map<String, dynamic> m = l[0];
      sizeStandart = m['size_standart'];
      pid = m['id'];
    }
    l = await HttpSqlQuery.post({'sl': "select * from Sizes where code='$sizeStandart'"});
    for (int i = 1; i < 13; i++) {
      s.sizes[i - 1].text = l[0]['size${i.toString().padLeft(2, '0')}'];
    }
    l = await HttpSqlQuery.post({
      "sl": "select a.apr_id, m.mnacord as pahest_mnac, a.pat_mnac, a.size_number "
          "from Apranq a "
          "left join Mnacord m on m.apr_id=a.apr_id "
          "where pid='$pid' and a.branch='${prefs.branch()}' "
    });
    s.preSize ??= PreloadingSize();
    for (var e in l) {
      int index = int.tryParse(e['size_number'].substring(e['size_number'].length - 2)) ?? -1;
      index--;
      s.preSize!.aprId[index] = e['apr_id'];
      s.preSize!.size[index] = e['pat_mnac'] ?? '0';
      s.remains[index].text = e['pat_mnac'] ?? '0';
      s.pahest[index].text = e['pahest_mnac'] ?? '0';
    }
    s.remains[s.remains.length - 1].text = s.sumOfMnacord();
    s.pahest[s.pahest.length - 1].text = s.sumOfPahest();
  }

}