// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_sizes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DataSize _$$_DataSizeFromJson(Map<String, dynamic> json) => _$_DataSize(
      id: json['id'] as String,
      code: json['code'] as String,
      country: json['country'] as String,
      name: json['name'] as String,
      size01: json['size01'] as String,
      size02: json['size02'] as String,
      size03: json['size03'] as String,
      size04: json['size04'] as String,
      size05: json['size05'] as String,
      size06: json['size06'] as String,
      size07: json['size07'] as String,
      size08: json['size08'] as String,
      size09: json['size09'] as String,
      size10: json['size10'] as String,
    );

Map<String, dynamic> _$$_DataSizeToJson(_$_DataSize instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'country': instance.country,
      'name': instance.name,
      'size01': instance.size01,
      'size02': instance.size02,
      'size03': instance.size03,
      'size04': instance.size04,
      'size05': instance.size05,
      'size06': instance.size06,
      'size07': instance.size07,
      'size08': instance.size08,
      'size09': instance.size09,
      'size10': instance.size10,
    };

_$_SizeList _$$_SizeListFromJson(Map<String, dynamic> json) => _$_SizeList(
      sizes: (json['sizes'] as List<dynamic>)
          .map((e) => DataSize.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_SizeListToJson(_$_SizeList instance) =>
    <String, dynamic>{
      'sizes': instance.sizes,
    };
