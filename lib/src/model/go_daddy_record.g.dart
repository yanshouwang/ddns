// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'go_daddy_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoDaddyRecordJSONObject _$GoDaddyRecordJSONObjectFromJson(
        Map<String, dynamic> json) =>
    GoDaddyRecordJSONObject(
      data: json['data'] as String,
      name: json['name'] as String,
      port: json['port'] as int?,
      priority: json['priority'] as int?,
      protocol: json['protocol'] as String?,
      service: json['service'] as String?,
      ttl: json['ttl'] as int?,
      type: json['type'] as String,
      weight: json['weight'] as int?,
    );

Map<String, dynamic> _$GoDaddyRecordJSONObjectToJson(
    GoDaddyRecordJSONObject instance) {
  final val = <String, dynamic>{
    'data': instance.data,
    'name': instance.name,
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
  val['type'] = instance.type;
  writeNotNull('weight', instance.weight);
  return val;
}
