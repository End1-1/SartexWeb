import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/screen/preloading/preloading_item.dart';
import 'package:sartex/screen/preloading/preloading_model.dart';
import 'package:sartex/screen/preloading/preloading_size.dart';
import 'package:sartex/utils/http_sql.dart';

part 'preloading_bloc.freezed.dart';

abstract class PreloadingState {}

class PreloadingStateIdle extends PreloadingState {}

@freezed
class PreloadingStateOpenDoc extends PreloadingState
    with _$PreloadingStateOpenDoc {
  const factory PreloadingStateOpenDoc(
      {required List<PreloadingFullItem> items,
      required Map<String, String> header}) = _PreloadingStateOpenDoc;
}

@freezed
class PreloadingStateSummary extends PreloadingState with _$PreloadingStateSummary {
  const factory PreloadingStateSummary({required dynamic data}) = _PreloadingState;
}

abstract class PreloadingEvent {}

@freezed
class PreloadingEventOpenDoc extends PreloadingEvent
    with _$PreloadingEventOpenDoc {
  const factory PreloadingEventOpenDoc({required String? docnum}) =
      _PreloadingEventOpenDoc;
}

@freezed
class PreloadingEventSummary extends PreloadingEvent with _$PreloadingEventSummary {
  const factory PreloadingEventSummary({required String docnum}) = _PreloadingEventSummary;
}

class PreloadingBloc extends Bloc<PreloadingEvent, PreloadingState> {
  PreloadingBloc(super.initialState) {
    on<PreloadingEventOpenDoc>((event, emit) => _openDoc(event.docnum));
    on<PreloadingEventSummary>((event, emit) => _summaryDoc(event.docnum));
  }

  Future<void> _summaryDoc(String docnum) async {
    Map<String, List<dynamic>> result = {};
    result['bybrand'] = [];
    result['byline'] = [];
    result['bycommesa'] = [];
    dynamic d = await HttpSqlQuery.post({"sl":"select pd.brand, sum(d.qanak) as pqanak , sum(m.mnacord) as mqanak, "
      "sum(d.qanak)-sum(m.mnacord) as diff "
      "from Docs d "
      "left join Apranq a on a.apr_id=d.apr_id "
      "left join patver_data pd on pd.id=a.pid "
      "left join Mnacord m on m.apr_id=a.apr_id "
      "where docnum ='$docnum' "
      "group by pd.brand"});
    for (final e in d) {
      result['bybrand']!.add(e);
    }
    d = await HttpSqlQuery.post({"sl":"select d.line, sum(d.qanak) as pqanak , sum(m.mnacord) as mqanak, sum(d.qanak)-sum(m.mnacord) as diff "
        "from Docs d "
        "left join Apranq a on a.apr_id=d.apr_id "
        "left join patver_data pd on pd.id=a.pid "
        "left join Mnacord m on m.apr_id=a.apr_id "
        "where docnum ='$docnum' "
        "group by d.line"});
    for (final e in d) {
      result['byline']!.add(e);
    }
    d = await HttpSqlQuery.post({"sl":"select pd.PatverN as commesa, pd.Model, pd.country, sum(d.qanak) as pqanak , sum(coalesce(m.mnacord, 0)) as mqanak, "
        "sum(coalesce(d.qanak, 0))-sum(coalesce(m.mnacord, 0)) as diff "
        "from Docs d "
        "left join Apranq a on a.apr_id=d.apr_id "
        "left join patver_data pd on pd.id=a.pid "
        "left join Mnacord m on m.apr_id=a.apr_id "
        "where docnum ='$docnum' "
        "group by 1,2,3 "});
    for (final e in d) {
      result['bycommesa']!.add(e);
    }
    emit(PreloadingStateSummary(data: result));
  }

  Future<void> _openDoc(String? docnum) async {
    Map<String, String> header = {};
    List<PreloadingFullItem> items = [];
    if (docnum == null || docnum.isEmpty) {
      emit(PreloadingStateOpenDoc(items: items, header: header));
      return;
    }
    List<dynamic> data = await HttpSqlQuery.post({
      'sl': "select pd.brand, pd.Model, pd.PatverN, pd.Colore, pd.variant_prod,"
          "pd.country, a.pat_mnac, m.mnacord, "
          "a.size_number, a.pid, d.qanak, d.pahest, d.line, a.pahest_mnac, "
          "d.date, d.avto, d.partner, a.apr_id, pd.size_standart, d.id as prodId "
          "from Docs d left join Apranq a on a.apr_id=d.apr_id "
          "left join Mnacord m on m.apr_id=a.apr_id   "
          "left join patver_data pd on pd.id=a.pid "
          "where d.docNum='$docnum' "
          "order by cast(right(d.line, length(d.line)-1) as signed) "
    });

    Map<String, PreloadingItem> pid = {};
    for (var d in data) {
      if (header.isEmpty) {
        header['date'] = d['date'];
        header['truck'] = d['avto'];
        header['receipant'] = d['partner'] ?? '';
        header['store'] = d['pahest'];
      }

      PreloadingFullItem? p = items.firstWhere(
          (element) => element.prLine == d['line'],
          orElse: () => PreloadingFullItem());
      if (p.prLine.isEmpty) {
        p.prLine = d['line'] ?? '';
        items.add(p);
      }

      PreloadingItem i;
      if (pid.containsKey('${d['pid']}${d['line']}')) {
        i = pid['${d['pid']}${d['line']}']!;
      } else {
        i = PreloadingItem();
        i.preSize = PreloadingSize();
        await i.preSize!.loadSizes(d['size_standart']);
        pid['${d['pid']}${d['line']}'] = i;
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
      index--;
      i.preSize!.aprId[index] = d['apr_id']!;
      i.preSize!.prodId[index] = d['prodId']!;
      i.remains[index].text = d['pat_mnac'];
      i.newvalues[index].text = d['qanak'];
      i.pahest[index].text = d['mnacord'] ?? '0';

      for (int k = 1; k < 13; k++) {
        i.sizes[k - 1].text = i.preSize!.size[k - 1];
      }
    }

    for (var e in items) {
      for (var i in e.items) {
        i.newvalues[12].text = i.sumOfNewValues();
        i.pahest[12].text = i.sumOfPahest();
        i.remains[12].text = i.sumOfList(i.remains);
      }
    }
    emit(PreloadingStateOpenDoc(items: items, header: header));
  }
}
