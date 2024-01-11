part of '../client.dart';

@JsonSerializable(includeIfNull: false)
class GoDaddyRecord {
  final String data;
  final int? port;
  final int? priority;
  final String? protocol;
  final String? service;
  final int? ttl;
  final int? weight;

  GoDaddyRecord({
    required this.data,
    this.port,
    this.priority,
    this.protocol,
    this.service,
    this.ttl,
    this.weight,
  });

  factory GoDaddyRecord.fromJson(Map<String, dynamic> json) =>
      _$GoDaddyRecordFromJson(json);

  Map<String, dynamic> toJson() => _$GoDaddyRecordToJson(this);
}
