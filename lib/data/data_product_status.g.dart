// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_product_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductStatus _$$_ProductStatusFromJson(Map<String, dynamic> json) =>
    _$_ProductStatus(
      id: json['id'] as String,
      branch: json['branch'] as String,
      checkStatus: json['checkStatus'] as String,
      prod_status: json['prod_status'] as String,
    );

Map<String, dynamic> _$$_ProductStatusToJson(_$_ProductStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch': instance.branch,
      'checkStatus': instance.checkStatus,
      'prod_status': instance.prod_status,
    };

_$_ProductStatusList _$$_ProductStatusListFromJson(Map<String, dynamic> json) =>
    _$_ProductStatusList(
      productStatuses: (json['productStatuses'] as List<dynamic>)
          .map((e) => ProductStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ProductStatusListToJson(
        _$_ProductStatusList instance) =>
    <String, dynamic>{
      'productStatuses': instance.productStatuses,
    };
