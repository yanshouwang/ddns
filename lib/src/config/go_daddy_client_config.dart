import 'package:json_annotation/json_annotation.dart';

import 'domain_config.dart';

part 'go_daddy_client_config.g.dart';

class GoDaddyClientConfig {
  final String key;
  final String secret;
  final List<DomainConfig> domains;

  GoDaddyClientConfig({
    required this.key,
    required this.secret,
    required this.domains,
  });

  factory GoDaddyClientConfig.fromJSON(Map<String, dynamic> json) {
    final obj = GoDaddyClientConfigJSONObject.fromJson(json);
    return GoDaddyClientConfig.fromJSONObject(obj);
  }

  factory GoDaddyClientConfig.fromJSONObject(
      GoDaddyClientConfigJSONObject obj) {
    return GoDaddyClientConfig(
      key: obj.key,
      secret: obj.secret,
      domains: obj.domains
          .map((domainObj) => DomainConfig.fromJSONObject(domainObj))
          .toList(),
    );
  }

  Map<String, dynamic> toJSON() {
    final obj = toJSONObject();
    return obj.toJson();
  }

  GoDaddyClientConfigJSONObject toJSONObject() {
    return GoDaddyClientConfigJSONObject(
      key: key,
      secret: secret,
      domains: domains.map((domain) => domain.toJSONObject()).toList(),
    );
  }
}

@JsonSerializable(includeIfNull: false)
class GoDaddyClientConfigJSONObject {
  final String key;
  final String secret;
  final List<DomainConfigJSONObject> domains;

  GoDaddyClientConfigJSONObject({
    required this.key,
    required this.secret,
    required this.domains,
  });

  factory GoDaddyClientConfigJSONObject.fromJson(Map<String, dynamic> json) =>
      _$GoDaddyClientConfigJSONObjectFromJson(json);

  Map<String, dynamic> toJson() => _$GoDaddyClientConfigJSONObjectToJson(this);
}
