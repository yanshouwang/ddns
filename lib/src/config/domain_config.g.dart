// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'domain_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DomainConfigJSONObject _$DomainConfigJSONObjectFromJson(
        Map<String, dynamic> json) =>
    DomainConfigJSONObject(
      name: json['name'] as String,
      records: (json['records'] as List<dynamic>)
          .map((e) =>
              DDNSRecordConfigJSONObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DomainConfigJSONObjectToJson(
        DomainConfigJSONObject instance) =>
    <String, dynamic>{
      'name': instance.name,
      'records': instance.records,
    };
