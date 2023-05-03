import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:sartex/utils/http_sql.dart';

abstract class AppState {}
class GSIdle extends AppState {}
class GSLoading extends AppState {}
class GSData extends AppState{
  final dynamic data;
  GSData(this.data);
}

abstract class AppEvent {}
class GELoadData extends AppEvent {
  final String query;
  GELoadData(this.query);
}

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(super.initialState) {
    on<GELoadData>((event, emit) => _loadData(event));
  }

  Future<void> _loadData(GELoadData e) async {
    emit (GSLoading());
    String s = await HttpSqlQuery.postString({'sl': e.query});
    emit(GSData(jsonDecode(s)));
  }

}