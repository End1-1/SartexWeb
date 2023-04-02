// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      id: json['id'] as String,
      branch: json['branch'] as String?,
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      modelCode: json['modelCode'] as String?,
      size_standart: json['size_standart'] as String?,
      Packaging: json['Packaging'] as String?,
      ProductsTypeCode: json['ProductsTypeCode'] as String?,
      Netto: json['Netto'] as String?,
      Brutto: json['Brutto'] as String?,
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch': instance.branch,
      'brand': instance.brand,
      'model': instance.model,
      'modelCode': instance.modelCode,
      'size_standart': instance.size_standart,
      'Packaging': instance.Packaging,
      'ProductsTypeCode': instance.ProductsTypeCode,
      'Netto': instance.Netto,
      'Brutto': instance.Brutto,
    };

_$_ProductList _$$_ProductListFromJson(Map<String, dynamic> json) =>
    _$_ProductList(
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ProductListToJson(_$_ProductList instance) =>
    <String, dynamic>{
      'products': instance.products,
    };
