// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Partner _$$_PartnerFromJson(Map<String, dynamic> json) => _$_Partner(
      id: json['id'] as String,
      branch: json['branch'] as String,
      country: json['country'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$_PartnerToJson(_$_Partner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch': instance.branch,
      'country': instance.country,
      'name': instance.name,
      'type': instance.type,
    };

_$_PartnerList _$$_PartnerListFromJson(Map<String, dynamic> json) =>
    _$_PartnerList(
      partners: (json['partners'] as List<dynamic>)
          .map((e) => Partner.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PartnerListToJson(_$_PartnerList instance) =>
    <String, dynamic>{
      'partners': instance.partners,
    };
