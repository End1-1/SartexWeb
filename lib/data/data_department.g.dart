// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DataDepartment _$$_DataDepartmentFromJson(Map<String, dynamic> json) =>
    _$_DataDepartment(
      id: json['id'] as String,
      branch: json['branch'] as String,
      department: json['department'] as String,
      patasxanatu: json['patasxanatu'] as String,
      short_name: json['short_name'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$_DataDepartmentToJson(_$_DataDepartment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch': instance.branch,
      'department': instance.department,
      'patasxanatu': instance.patasxanatu,
      'short_name': instance.short_name,
      'type': instance.type,
    };

_$_DataDepartmentList _$$_DataDepartmentListFromJson(
        Map<String, dynamic> json) =>
    _$_DataDepartmentList(
      departments: (json['departments'] as List<dynamic>)
          .map((e) => DataDepartment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_DataDepartmentListToJson(
        _$_DataDepartmentList instance) =>
    <String, dynamic>{
      'departments': instance.departments,
    };
