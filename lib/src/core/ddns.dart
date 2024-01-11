part of '../core.dart';

class DDNS {
  final Set<DdnsRecord> records;

  DDNS({
    required this.records,
  });

  factory DDNS.fromConfig(DdnsConfig config) {
    return DDNS(
      records: config.records
          .map((recordConfig) => DdnsRecord.fromConfig(recordConfig))
          .toSet(),
    );
  }

  DdnsConfig toConfig() {
    return DdnsConfig(
      records: records.map((record) => record.toConfig()).toList(),
    );
  }
}

@JsonSerializable(includeIfNull: false)
class DdnsConfig {
  final List<DdnsRecordConfig> records;

  DdnsConfig({
    required this.records,
  });

  factory DdnsConfig.fromJson(Map<String, dynamic> json) =>
      _$DdnsConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DdnsConfigToJson(this);
}
