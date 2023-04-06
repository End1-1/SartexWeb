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

  void buildModelList(String brand) {
    HttpSqlQuery.post({
      "sl":
      "select distinct(pd.Model) from Apranq a left join patver_data pd on pd.id=a.pid where pd.status='inProgress' and brand='$brand'"
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
      "select distinct(pd.PatverN) from Apranq a left join patver_data pd on pd.id=a.pid where pd.status='inProgress' and brand='$brand' and Model='$model'"
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
      "select distinct(pd.Colore) from Apranq a left join patver_data pd on pd.id=a.pid where pd.status='inProgress' and brand='$brand' and Model='$model' and PatverN='$commesa'"
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
      "select distinct(pd.variant_prod) from Apranq a left join patver_data pd on pd.id=a.pid where pd.status='inProgress' and brand='$brand' and Model='$model' and PatverN='$commesa' and Colore='$color'"
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
      "select pd.country, pd.size_standart, pd.id from Apranq a left join patver_data pd on pd.id=a.pid where pd.status='inProgress' and brand='$brand' and Model='$model' and PatverN='$commesa'"
    });
    if (l.isNotEmpty) {
      Map<String, dynamic> m = l[0];
      sizeStandart = m['size_standart'];
      country = m['country'];
      pid = m['id'];
    }
    l = await HttpSqlQuery.post({'sl':'select * from patver_data where id=$pid'});
    for (int i = 1; i < 13; i++) {
      s.sizes[i - 1].text = l[0]['Size${i.toString().padLeft(2, '0')}'];
    }
    l = await HttpSqlQuery.post({
      "sl": "select a.apr_id,  m.mnacord as pahest_mnac, a.size_number from Apranq a inner join Mnacord m on m.apr_id=a.apr_id where pid='$pid'"
    });
    s.preSize ??= PreloadingSize();
    for (var e in l) {
      int index = int.tryParse(e['size_number'].substring(e['size_number'].length - 2)) ?? -1;
      s.preSize!.aprId[index] = e['apr_id'];
      s.preSize!.size[index] = e['pat_mnac'] ?? '0';
      s.remains[index].text = e['pat_mnac'] ?? '0';
      s.pahest[index].text = e['pahest_mnacord'] ?? '0';
    }
    s.remains[s.remains.length - 1].text = s.sumOfMnacord();
    s.pahest[s.pahest.length - 1].text = s.sumOfPahest();
  }

}