part of '../core.dart';

const int _kTTL = 600;

class DdnsRecord {
  final String name;
  final DdnsRecordType type;
  final String value;
  final int ttl;

  DdnsRecord({
    required this.name,
    required this.type,
    required this.value,
    required this.ttl,
  });

  factory DdnsRecord.fromConfig(DdnsRecordConfig config) {
    return DdnsRecord(
      name: config.name,
      type:
          DdnsRecordType.values.firstWhere((type) => type.name == config.type),
      value: '',
      ttl: config.ttl ?? _kTTL,
    );
  }

  DdnsRecordConfig toConfig() {
    return DdnsRecordConfig(
      name: name,
      type: type.name,
      ttl: ttl == _kTTL ? null : ttl,
    );
  }

  DdnsRecord copyWith({
    String? name,
    DdnsRecordType? type,
    String? value,
    int? ttl,
  }) {
    name ??= this.name;
    type ??= this.type;
    value ??= this.value;
    ttl ??= this.ttl;
    return DdnsRecord(
      name: name,
      type: type,
      value: value,
      ttl: ttl,
    );
  }

  @override
  operator ==(Object other) {
    return other is DdnsRecord && other.name == name && other.type == type;
  }

  @override
  int get hashCode => Object.hash(name, type);
}

@JsonSerializable(includeIfNull: false)
class DdnsRecordConfig {
  final String name;
  final String type;
  final int? ttl;

  DdnsRecordConfig({
    required this.name,
    required this.type,
    this.ttl,
  });

  factory DdnsRecordConfig.fromJson(Map<String, dynamic> json) =>
      _$DdnsRecordConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DdnsRecordConfigToJson(this);
}
