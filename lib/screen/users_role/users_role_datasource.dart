import 'package:flutter/cupertino.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/screen/users_role/users_role_edit.dart';
import 'package:sartex/utils/translator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'users_role_datasource.freezed.dart';
part 'users_role_datasource.g.dart';

@freezed
class UsersRole with _$UsersRole {
  const factory UsersRole({required String? id, required String? name}) = _UsersRole;
  factory UsersRole.fromJson(Map<String,dynamic> json) => _$UsersRoleFromJson(json);
}

class UsersRoleDatasource extends SartexDataGridSource {

  UsersRoleDatasource() {
    addColumn(L.tr('Id'));
    addColumn(L.tr('Name'));
  }

  @override
  void addRows(List d) {
    for (var e in d) {
      UsersRole ur = UsersRole.fromJson(e);
      int i = 0;
      rows.add(DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: ur.id),
        DataGridCell(columnName: columnNames[i++], value: ur.name),
      ]));
    }
  }

  @override
  Widget getEditWidget(BuildContext context, String id) {
    return UsersRoleEditWidget(id);
  }
}