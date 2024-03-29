import 'package:bloc/bloc.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';

abstract class UserRoleState {}
class UserRoleLoading extends UserRoleState {}
class UserRoleData extends UserRoleState {
  final String name;
  final Map<String, Map<String, String>> check;
  UserRoleData(this.name, this.check);
}

abstract class UserRoleEvent {}
class UserRoleGetEvent extends UserRoleEvent{
  final String id;
  UserRoleGetEvent(this.id);
}

class UserRoleBloc extends Bloc<UserRoleEvent, UserRoleState> {
  UserRoleBloc() : super(UserRoleLoading()) {
    on<UserRoleGetEvent>((event, emit) => _loadData(event));
  }

  Future<void> _loadData(UserRoleGetEvent e) async {
    Map<String, Map<String, String>> checkMap = {};
    checkMap.addAll(roleMap);
    var result = await HttpSqlQuery.post({'sl': "select name from RoleNames where id=${e.id}"});
    if (result.isEmpty) {
      emit(UserRoleData('', checkMap));
      return;
    }
    String name = result[0]['name'];
    result = await HttpSqlQuery.post({'sl': "select action, read_flag, write_flag from RoleData where role_id=${e.id}"});
    for (var e in result) {
      Map<String, String> v = {'read_flag': e['read_flag'], 'write_flag': e['write_flag']};
      checkMap[e['action']] = v;
    }
    emit (UserRoleData(name, checkMap));
  }

}