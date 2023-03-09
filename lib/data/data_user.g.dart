// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DataUser _$$_DataUserFromJson(Map<String, dynamic> json) => _$_DataUser(
      id: json['id'] as int,
      branch: json['branch'] as String,
      active: json['active'] as String,
      department: json['department'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      middleName: json['middleName'] as String,
      position: json['position'] as String,
    );

Map<String, dynamic> _$$_DataUserToJson(_$_DataUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch': instance.branch,
      'active': instance.active,
      'department': instance.department,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'middleName': instance.middleName,
      'position': instance.position,
    };
