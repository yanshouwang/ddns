import 'package:json_annotation/json_annotation.dart';

import 'dns_record_config.dart';

part 'domain_config.g.dart';

class DomainConfig {
  final String name;
  final List<DNSRecordConfig> records;

  DomainConfig({
    required this.name,
    required this.records,
  });

  factory DomainConfig.fromJSON(Map<String, dynamic> json) {
    final obj = DomainConfigJSONObject.fromJson(json);
    return DomainConfig.fromJSONObject(obj);
  }

  factory DomainConfig.fromJSONObject(DomainConfigJSONObject obj) {
    return DomainConfig(
      name: obj.name,
      records: obj.records
          .map((recordObj) => DNSRecordConfig.formJSONObject(recordObj))
          .toList(),
    );
  }

  Map<String, dynamic> toJSON() {
    final obj = toJSONObject();
    return obj.toJson();
  }

  DomainConfigJSONObject toJSONObject() {
    return DomainConfigJSONObject(
      name: name,
      records: records.map((record) => record.toJSONObject()).toList(),
    );
  }
}

@JsonSerializable(includeIfNull: false)
class DomainConfigJSONObject {
  final String name;
  final List<DDNSRecordConfigJSONObject> records;

  DomainConfigJSONObject({
    required this.name,
    required this.records,
  });

  factory DomainConfigJSONObject.fromJson(Map<String, dynamic> json) =>
      _$DomainConfigJSONObjectFromJson(json);

  Map<String, dynamic> toJson() => _$DomainConfigJSONObjectToJson(this);
}
