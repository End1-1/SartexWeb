import 'dart:js_util';

import 'package:bloc/bloc.dart';
import 'package:sartex/utils/http_sql.dart';

abstract class HttpBlocState {}
abstract class HttpBlocEvent {}
class HttpBlocStateIdle extends HttpBlocState {}
class HttpBlocStateLoading extends HttpBlocState {}
class HttpBlocStateRead extends HttpBlocState{
  final dynamic data;
  HttpBlocStateRead(this.data);
}
class HttpBlocEventQuery extends HttpBlocEvent {
  final String query;
  final String type;
  HttpBlocEventQuery(this.query, {this.type = 'sql'});
}

class HttpBlocEventGet extends HttpBlocEvent {
  final String query;
  HttpBlocEventGet(this.query);
}

class HttpBloc extends Bloc<HttpBlocEvent, HttpBlocState> {
  HttpBloc() : super(HttpBlocStateIdle()) {
    on<HttpBlocEventQuery>((event, emit) => _query(event));
    on<HttpBlocEventGet>((event, emit) => _queryGet(event));
  }

  Future<void> _query(HttpBlocEventQuery q) async {
    emit(HttpBlocStateLoading());
    final result = await HttpSqlQuery.post({"sl": q.query});
    emit(HttpBlocStateRead(result));
  }

  Future<void> _queryGet(HttpBlocEventGet q) async {
    emit(HttpBlocStateLoading());
    final result = await HttpSqlQuery.getStringT(type: q.query);
    emit(HttpBlocStateRead(result));
  }
}