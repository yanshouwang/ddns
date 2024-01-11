// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DdnsRecordConfig _$DdnsRecordConfigFromJson(Map<String, dynamic> json) =>
    DdnsRecordConfig(
      name: json['name'] as String,
      type: json['type'] as String,
      ttl: json['ttl'] as int?,
    );

Map<String, dynamic> _$DdnsRecordConfigToJson(DdnsRecordConfig instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'type': instance.type,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ttl', instance.ttl);
  return val;
}

DdnsConfig _$DdnsConfigFromJson(Map<String, dynamic> json) => DdnsConfig(
      records: (json['records'] as List<dynamic>)
          .map((e) => DdnsRecordConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DdnsConfigToJson(DdnsConfig instance) =>
    <String, dynamic>{
      'records': instance.records,
    };

DomainConfig _$DomainConfigFromJson(Map<String, dynamic> json) => DomainConfig(
      name: json['name'] as String,
      ddns: DdnsConfig.fromJson(json['ddns'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DomainConfigToJson(DomainConfig instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ddns': instance.ddns,
    };
