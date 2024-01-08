// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dns_record_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DDNSRecordConfigJSONObject _$DDNSRecordConfigJSONObjectFromJson(
        Map<String, dynamic> json) =>
    DDNSRecordConfigJSONObject(
      name: json['name'] as String,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DDNSRecordConfigJSONObjectToJson(
        DDNSRecordConfigJSONObject instance) =>
    <String, dynamic>{
      'name': instance.name,
      'types': instance.types,
    };
