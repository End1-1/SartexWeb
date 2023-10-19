// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartnerImpl _$$PartnerImplFromJson(Map<String, dynamic> json) =>
    _$PartnerImpl(
      id: json['id'] as String,
      branch: json['branch'] as String,
      country: json['country'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$PartnerImplToJson(_$PartnerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch': instance.branch,
      'country': instance.country,
      'name': instance.name,
      'type': instance.type,
    };

_$PartnerListImpl _$$PartnerListImplFromJson(Map<String, dynamic> json) =>
    _$PartnerListImpl(
      partners: (json['partners'] as List<dynamic>)
          .map((e) => Partner.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PartnerListImplToJson(_$PartnerListImpl instance) =>
    <String, dynamic>{
      'partners': instance.partners,
    };
