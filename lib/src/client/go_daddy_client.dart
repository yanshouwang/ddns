part of '../client.dart';

class GoDaddyClient extends DdnsClient {
  final String key;
  final String secret;
  final HttpClient _client;

  GoDaddyClient({
    required this.key,
    required this.secret,
    required super.domains,
  }) : _client = HttpClient()..findProxy = HttpClient.findProxyFromEnvironment;

  factory GoDaddyClient.fromConfig(GoDaddyClientConfig config) {
    return GoDaddyClient(
      key: config.key,
      secret: config.secret,
      domains: config.domains
          .map((domainConfig) => Domain.fromConfig(domainConfig))
          .toSet(),
    );
  }

  GoDaddyClientConfig toConfig() {
    return GoDaddyClientConfig(
      key: key,
      secret: secret,
      domains: domains.map((domain) => domain.toConfig()).toList(),
    );
  }

  @override
  Future<void> _updateRecord(
    Domain domain,
    DdnsRecord record,
    String value,
  ) async {
    final url = Uri.https(
      'api.godaddy.com',
      '/v1/domains/${domain.name}/records/${record.type}/${record.name}',
    );
    final headers = {
      HttpHeaders.contentTypeHeader: ContentType.json,
      HttpHeaders.authorizationHeader: 'sso-key $key:$secret',
    };
    final recordsJSON = [
      record
          .copyWith(
            value: value,
          )
          .toGoDaddyRecord()
          .toJson(),
    ];
    final recordsText = json.encode(recordsJSON);
    await _client.putUrlAsString(
      url,
      headers: headers,
      obj: recordsText,
    );
  }
}

@JsonSerializable(includeIfNull: false)
class GoDaddyClientConfig {
  final String key;
  final String secret;
  final List<DomainConfig> domains;

  GoDaddyClientConfig({
    required this.key,
    required this.secret,
    required this.domains,
  });

  factory GoDaddyClientConfig.fromJson(Map<String, dynamic> json) =>
      _$GoDaddyClientConfigFromJson(json);

  Map<String, dynamic> toJson() => _$GoDaddyClientConfigToJson(this);
}

extension on DdnsRecord {
  GoDaddyRecord toGoDaddyRecord() {
    return GoDaddyRecord(
      data: value,
      ttl: ttl,
    );
  }
}
