// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_product_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductStatusImpl _$$ProductStatusImplFromJson(Map<String, dynamic> json) =>
    _$ProductStatusImpl(
      id: json['id'] as String,
      branch: json['branch'] as String,
      checkStatus: json['checkStatus'] as String,
      prod_status: json['prod_status'] as String,
    );

Map<String, dynamic> _$$ProductStatusImplToJson(_$ProductStatusImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch': instance.branch,
      'checkStatus': instance.checkStatus,
      'prod_status': instance.prod_status,
    };

_$ProductStatusListImpl _$$ProductStatusListImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductStatusListImpl(
      productStatuses: (json['productStatuses'] as List<dynamic>)
          .map((e) => ProductStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProductStatusListImplToJson(
        _$ProductStatusListImpl instance) =>
    <String, dynamic>{
      'productStatuses': instance.productStatuses,
    };
