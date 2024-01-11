// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoDaddyRecord _$GoDaddyRecordFromJson(Map<String, dynamic> json) =>
    GoDaddyRecord(
      data: json['data'] as String,
      port: json['port'] as int?,
      priority: json['priority'] as int?,
      protocol: json['protocol'] as String?,
      service: json['service'] as String?,
      ttl: json['ttl'] as int?,
      weight: json['weight'] as int?,
    );

Map<String, dynamic> _$GoDaddyRecordToJson(GoDaddyRecord instance) {
  final val = <String, dynamic>{
    'data': instance.data,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('port', instance.port);
  writeNotNull('priority', instance.priority);
  writeNotNull('protocol', instance.protocol);
  writeNotNull('service', instance.service);
  writeNotNull('ttl', instance.ttl);
  writeNotNull('weight', instance.weight);
  return val;
}

GoDaddyClientConfig _$GoDaddyClientConfigFromJson(Map<String, dynamic> json) =>
    GoDaddyClientConfig(
      key: json['key'] as String,
      secret: json['secret'] as String,
      domains: (json['domains'] as List<dynamic>)
          .map((e) => DomainConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GoDaddyClientConfigToJson(
        GoDaddyClientConfig instance) =>
    <String, dynamic>{
      'key': instance.key,
      'secret': instance.secret,
      'domains': instance.domains,
    };
