
import 'package:sartex/utils/http_sql.dart';

class PreloadingSize {
  List<String> prodId = ['', '', '', '', '', '', '', '', '', '', '', ''];
  List<String> aprId = ['0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'];
  List<String> size = ['0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'];

  String sizeOf(int index) {
    return size[index] ?? '';
  }

  String? aprIdOf(int index) {
    return aprId[index] ?? '';
  }

  Future<void> loadSizes(String standart) async {
    List<dynamic> l = await HttpSqlQuery.post({'sl': "select * from Sizes where code='$standart'"});
    for (int i = 1; i < 13; i++) {
      String key = i.toString().padLeft(2, '0');
      size[i - 1] = l[0]['size$key'] ?? '';
    }
  }
}