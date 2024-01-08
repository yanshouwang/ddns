import 'package:json_annotation/json_annotation.dart';

part 'go_daddy_record.g.dart';

class GoDaddyRecord {
  final String data;
  final String name;
  final int? port;
  final int? priority;
  final String? protocol;
  final String? service;
  final int? ttl;
  final String type;
  final int? weight;

  GoDaddyRecord({
    required this.data,
    required this.name,
    this.port,
    this.priority,
    this.protocol,
    this.service,
    this.ttl,
    required this.type,
    this.weight,
  });

  factory GoDaddyRecord.fromJSON(Map<String, dynamic> json) {
    final obj = GoDaddyRecordJSONObject.fromJson(json);
    return GoDaddyRecord.fromJSONObject(obj);
  }

  factory GoDaddyRecord.fromJSONObject(GoDaddyRecordJSONObject obj) {
    return GoDaddyRecord(
      data: obj.data,
      name: obj.name,
      port: obj.port,
      priority: obj.priority,
      protocol: obj.protocol,
      service: obj.service,
      ttl: obj.ttl,
      type: obj.type,
      weight: obj.weight,
    );
  }

  Map<String, dynamic> toJSON() {
    final obj = toJSONObject();
    return obj.toJson();
  }

  GoDaddyRecordJSONObject toJSONObject() {
    return GoDaddyRecordJSONObject(
      data: data,
      name: name,
      port: port,
      priority: priority,
      protocol: protocol,
      service: service,
      ttl: ttl,
      type: type,
      weight: weight,
    );
  }
}

@JsonSerializable(includeIfNull: false)
class GoDaddyRecordJSONObject {
  final String data;
  final String name;
  final int? port;
  final int? priority;
  final String? protocol;
  final String? service;
  final int? ttl;
  final String type;
  final int? weight;

  GoDaddyRecordJSONObject({
    required this.data,
    required this.name,
    this.port,
    this.priority,
    this.protocol,
    this.service,
    this.ttl,
    required this.type,
    this.weight,
  });

  factory GoDaddyRecordJSONObject.fromJson(Map<String, dynamic> json) =>
      _$GoDaddyRecordJSONObjectFromJson(json);

  Map<String, dynamic> toJson() => _$GoDaddyRecordJSONObjectToJson(this);
}
