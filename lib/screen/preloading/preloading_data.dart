import 'package:sartex/data/data_sizes.dart';
import 'package:sartex/screen/preloading/preloading_item.dart';
import 'package:sartex/screen/preloading/preloading_size.dart';
import 'package:sartex/utils/http_sql.dart';

class PreloadingData {
  List<String> brandLevel = [];
  List<String> modelLevel = [];
  List<String> commesaLevel = [];
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
      "select distinct(pd.brand) from patver_data pd where pd.status='inProgress'"
    }).then((value) {
      brandLevel.clear();
      for (var e in value) {
        brandLevel.add(e['brand']);
      }
    });
    HttpSqlQuery.post({'sl': 'select * from Sizes'}).then((value) {
      SizeList sl = SizeList.fromJson({'sizes': value});
      for (var e in sl.sizes) {
        sizeStandartList[e.code] = e;
      }
    });
  }

  void buildModelList(String brand) {
    HttpSqlQuery.post({
      "sl":
      "select distinct(pd.Model) from patver_data pd where pd.status='inProgress' and brand='$brand'"
    }).then((value) {
      modelLevel.clear();
      for (var e in value) {
        modelLevel.add(e['Model']);
      }
    });
  }

  void buildCommesaLevel(String brand, String model) {
    HttpSqlQuery.post({
      "sl":
      "select distinct(pd.PatverN) from patver_data pd where pd.status='inProgress' and brand='$brand' and Model='$model'"
    }).then((value) {
      commesaLevel.clear();
      for (var e in value) {
        commesaLevel.add(e['PatverN']);
      }
    });
  }

  void buildColorLevel(String brand, String model, String commesa) {
    HttpSqlQuery.post({
      "sl":
      "select distinct(pd.Colore) from patver_data pd where pd.status='inProgress' and brand='$brand' and Model='$model' and PatverN='$commesa'"
    }).then((value) {
      colorLevel.clear();
      for (var e in value) {
        colorLevel.add(e['Colore']);
      }
    });
  }

  void buildVariantLevel(
      String brand, String model, String commesa, String color) {
    HttpSqlQuery.post({
      "sl":
      "select distinct(pd.variant_prod) from patver_data pd where pd.status='inProgress' and brand='$brand' and Model='$model' and PatverN='$commesa' and Colore='$color'"
    }).then((value) {
      variantLevel.clear();
      for (var e in value) {
        variantLevel.add(e['variant_prod']);
      }
    });
  }

  Future<void> getSizesAndCountry(
      String brand, String model, String commesa, PreloadingItem s) async {
    List<dynamic> l = await HttpSqlQuery.post({
      "sl":
      "select country, size_standart, id from patver_data pd where pd.status='inProgress' and brand='$brand' and Model='$model' and PatverN='$commesa'"
    });
    if (l.isNotEmpty) {
      Map<String, dynamic> m = l[0];
      sizeStandart = m['size_standart'];
      country = m['country'];
      pid = m['id'];
    }
    l = await HttpSqlQuery.post({
      "sl": "select apr_id, pat_mnac, size_number from Apranq where pid='$pid'"
    });
    s.preSize ??= PreloadingSize();
    for (var e in l) {
      switch (e['size_number']) {
        case 'size01':
          s.preSize!.aprId01 = e['apr_id'];
          s.preSize!.size01 = e['pat_mnac'];
          s.remains[0].text = e['pat_mnac'];
          break;
        case 'size02':
          s.preSize!.aprId02 = e['apr_id'];
          s.preSize!.size02 = e['pat_mnac'];
          s.remains[1].text = e['pat_mnac'];
          break;
        case 'size03':
          s.preSize!.aprId03 = e['apr_id'];
          s.preSize!.size03 = e['pat_mnac'];
          s.remains[2].text = e['pat_mnac'];
          break;
        case 'size04':
          s.preSize!.aprId04 = e['apr_id'];
          s.preSize!.size04 = e['pat_mnac'];
          s.remains[3].text = e['pat_mnac'];
          break;
        case 'size05':
          s.preSize!.aprId05 = e['apr_id'];
          s.preSize!.size05 = e['pat_mnac'];
          s.remains[4].text = e['pat_mnac'];
          break;
        case 'size06':
          s.preSize!.aprId06 = e['apr_id'];
          s.preSize!.size06 = e['pat_mnac'];
          s.remains[5].text = e['pat_mnac'];
          break;
        case 'size07':
          s.preSize!.aprId07 = e['apr_id'];
          s.preSize!.size07 = e['pat_mnac'];
          s.remains[6].text = e['pat_mnac'];
          break;
        case 'size08':
          s.preSize!.aprId08 = e['apr_id'];
          s.preSize!.size08 = e['pat_mnac'];
          s.remains[7].text = e['pat_mnac'];
          break;
        case 'size09':
          s.preSize!.aprId09 = e['apr_id'];
          s.preSize!.size09 = e['pat_mnac'];
          s.remains[8].text = e['pat_mnac'];
          break;
        case 'size10':
          s.preSize!.aprId10 = e['apr_id'];
          s.preSize!.size10 = e['pat_mnac'];
          s.remains[9].text = e['pat_mnac'];
          break;
      }
    }
  }

}