import 'package:json_annotation/json_annotation.dart';

import '../model.dart';

part 'dns_record_config.g.dart';

class DNSRecordConfig {
  final String name;
  final List<DNSRecordType> types;

  DNSRecordConfig({
    required this.name,
    required this.types,
  });

  factory DNSRecordConfig.fromJSON(Map<String, dynamic> json) {
    final obj = DDNSRecordConfigJSONObject.fromJson(json);
    return DNSRecordConfig.formJSONObject(obj);
  }

  factory DNSRecordConfig.formJSONObject(DDNSRecordConfigJSONObject obj) {
    return DNSRecordConfig(
      name: obj.name,
      types: obj.types
          .map((typeObj) =>
              DNSRecordType.values.firstWhere((type) => type.name == typeObj))
          .toList(),
    );
  }

  Map<String, dynamic> toJSON() {
    final obj = toJSONObject();
    return obj.toJson();
  }

  DDNSRecordConfigJSONObject toJSONObject() {
    return DDNSRecordConfigJSONObject(
      name: name,
      types: types.map((type) => type.name).toList(),
    );
  }
}

@JsonSerializable(includeIfNull: false)
class DDNSRecordConfigJSONObject {
  final String name;
  final List<String> types;

  DDNSRecordConfigJSONObject({
    required this.name,
    required this.types,
  });

  factory DDNSRecordConfigJSONObject.fromJson(Map<String, dynamic> json) =>
      _$DDNSRecordConfigJSONObjectFromJson(json);

  Map<String, dynamic> toJson() => _$DDNSRecordConfigJSONObjectToJson(this);
}
