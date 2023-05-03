import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/screen/preloading/preloading_item.dart';
import 'package:sartex/screen/preloading/preloading_model.dart';
import 'package:sartex/screen/preloading/preloading_size.dart';
import 'package:sartex/utils/http_sql.dart';
part 'preloading_bloc.freezed.dart';

abstract class PreloadingState {}
class PreloadingStateIdle extends PreloadingState{}
@freezed
class PreloadingStateOpenDoc extends PreloadingState with _$PreloadingStateOpenDoc {
  const factory PreloadingStateOpenDoc({required List<PreloadingFullItem> items, required Map<String,String> header}) = _PreloadingStateOpenDoc;
}

abstract class PreloadingEvent {}
@freezed
class PreloadingEventOpenDoc extends PreloadingEvent with _$PreloadingEventOpenDoc {
  const factory PreloadingEventOpenDoc({required String? docnum}) = _PreloadingEventOpenDoc;
}

class PreloadingBloc extends Bloc<PreloadingEvent, PreloadingState> {
  PreloadingBloc(super.initialState) {
    on<PreloadingEventOpenDoc>((event, emit) => _openDoc(event.docnum));
  }

  Future<void> _openDoc(String? docnum) async {
    if (docnum ==  null || docnum.isEmpty) {
      return;
    }
    List<dynamic> data = await HttpSqlQuery.post({'sl': "select pd.brand, pd.Model, pd.PatverN, pd.Colore, pd.variant_prod, pd.country, a.pat_mnac, "
        + "a.size_number, a.pid, d.qanak, d.pahest, d.line, a.pahest_mnac, d.date, d.avto, d.partner, a.apr_id, pd.size_standart "
        + "from Docs d left join Apranq a on a.apr_id=d.apr_id left join patver_data pd on pd.id=a.pid where d.docNum='$docnum'"});
    Map<String,String> header = {};
    List<PreloadingFullItem> items = [];
    Map<String, PreloadingItem> pid = {};
    for (var d in data) {
      if (header.isEmpty) {
        header['date'] = d['date'];
        header['truck'] = d['avto'];
        header['receipant'] = d['partner'] ?? '';
        header['store'] = d['pahest'];
      }

      PreloadingFullItem? p = items.firstWhere((element) => element.prLine == d['line'], orElse: () => PreloadingFullItem());
      if (p.prLine.isEmpty) {
        p.prLine = d['line'] ?? '';
        items.add(p);
      }

      PreloadingItem i;
      if (pid.containsKey(d['pid'])) {
        i = pid[d['pid']]!;
      } else {
        i = PreloadingItem();
        i.preSize = PreloadingSize();
        await i.preSize!.loadSizes(d['size_standart']);
        pid[d['pid']] = i;
        p.items.add(i);
      }
      i.brand.text = d['brand'];
      i.model.text = d['Model'];
      i.country.text = d['country'];
      i.color.text = d['Colore'];
      i.variant.text = d['variant_prod'];
      i.commesa.text = d['PatverN'];
      String sizen = d['size_number'];
      int index = int.tryParse(sizen.substring(sizen.length - 2)) ?? -1;
      index --;
      i.preSize!.aprId[index] = d['apr_id']!;
      i.remains[index].text = d['pat_mnac'];
      i.newvalues[index].text = d['qanak'];
      i.pahest[index].text = d['pahest_mnac'] ?? '0';

      for (int k = 1; k < 13; k++) {
        i.sizes[k - 1].text = i.preSize!.size[k - 1];
      }
    }
    emit(PreloadingStateOpenDoc(items: items, header: header));
  }

}