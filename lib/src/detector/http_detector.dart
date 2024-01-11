part of '../detector.dart';

class HttpDetector extends DdnsDetector {
  final Map<DdnsRecordType, Uri> urls;
  final Map<DdnsRecordType, RegExp> _exps;
  final HttpClient _client;

  HttpDetector({
    required this.urls,
  })  : _exps = {
          DdnsRecordType.a: ipv4Exp,
          DdnsRecordType.aaaa: ipv6Exp,
        },
        _client = HttpClient();

  factory HttpDetector.fromConfig(HttpDetectorConfig config) {
    return HttpDetector(
      urls: config.urls.map((name, urlValue) {
        final type =
            DdnsRecordType.values.firstWhere((type) => type.name == name);
        final url = Uri.parse(urlValue);
        return MapEntry(type, url);
      }),
    );
  }

  HttpDetectorConfig toConfig() {
    return HttpDetectorConfig(
      urls: urls.map((type, url) => MapEntry(type.name, url.toString())),
    );
  }

  @override
  Future<String> _detect(DdnsRecordType type) async {
    final url = urls[type];
    if (url == null) {
      throw ArgumentError.notNull('url');
    }
    final text = await _client.getUrlAsString(url);
    final exp = _exps[type];
    if (exp == null) {
      throw ArgumentError.notNull('exp');
    }
    final match = exp.firstMatch(text);
    if (match == null) {
      throw FormatException('Match failed.', text);
    }
    return match[0]!;
  }
}

@JsonSerializable(includeIfNull: false)
class HttpDetectorConfig {
  final Map<String, String> urls;

  HttpDetectorConfig({
    required this.urls,
  });

  factory HttpDetectorConfig.fromJson(Map<String, dynamic> json) =>
      _$HttpDetectorConfigFromJson(json);

  Map<String, dynamic> toJson() => _$HttpDetectorConfigToJson(this);
}
