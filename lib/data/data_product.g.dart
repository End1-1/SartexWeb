// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      branch: json['branch'] as String?,
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      modelCode: json['modelCode'] as String?,
      size_standart: json['size_standart'] as String?,
      Packaging: json['Packaging'] as String?,
      ProductsTypeCode: json['ProductsTypeCode'] as String?,
      productTypeName: json['productTypeName'] as String?,
      Netto: json['Netto'] as String?,
      Brutto: json['Brutto'] as String?,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch': instance.branch,
      'brand': instance.brand,
      'model': instance.model,
      'modelCode': instance.modelCode,
      'size_standart': instance.size_standart,
      'Packaging': instance.Packaging,
      'ProductsTypeCode': instance.ProductsTypeCode,
      'productTypeName': instance.productTypeName,
      'Netto': instance.Netto,
      'Brutto': instance.Brutto,
    };

_$ProductListImpl _$$ProductListImplFromJson(Map<String, dynamic> json) =>
    _$ProductListImpl(
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProductListImplToJson(_$ProductListImpl instance) =>
    <String, dynamic>{
      'products': instance.products,
    };
