import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_user.freezed.dart';
part 'data_user.g.dart';

@freezed
class DataUser {
  int? id;
  String? branch;
  String? active;
  String? department;
  String? email;
  String? firstName;
  String? lastName;
  String? middleName;
  String? position;

  factory DataUser.fromJson(Map<String, Object?> json) => _$DataUserFromJson(json);
}