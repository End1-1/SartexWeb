import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_user.freezed.dart';

part 'data_user.g.dart';

@freezed
class DataUser with _$DataUser {
  const factory DataUser(
      {required int id,
      required String branch,
      required String active,
      required String department,
      required String email,
      required String firstName,
      required String lastName,
      required String middleName,
      required String position}) = _DataUser;

  factory DataUser.fromJson(Map<String, Object?> json) =>
      _$DataUserFromJson(json);
}
