import 'package:json_annotation/json_annotation.dart';

import '../model.dart';

part 'ddns_detector_config.g.dart';

class DDNSDetectorConfig {
  static final undefined = DDNSDetectorConfig(
    duration: Duration(minutes: 10),
    times: 6,
    urls: {
      DNSRecordType.a: Uri.https('v4.ident.me'),
      DNSRecordType.aaaa: Uri.https('v6.ident.me'),
    },
  );

  final Duration duration;
  final int times;
  final Map<DNSRecordType, Uri> urls;

  DDNSDetectorConfig({
    required this.duration,
    required this.times,
    required this.urls,
  });

  factory DDNSDetectorConfig.fromJSON(Map<String, dynamic> json) {
    final obj = DDNSDetectorConfigJSONObject.fromJson(json);
    return DDNSDetectorConfig.fromJSONObject(obj);
  }

  factory DDNSDetectorConfig.fromJSONObject(DDNSDetectorConfigJSONObject obj) {
    return DDNSDetectorConfig(
      duration: Duration(seconds: obj.duration),
      times: obj.times,
      urls: obj.urls.map((typeObj, urlObj) {
        final type =
            DNSRecordType.values.firstWhere((type) => type.name == typeObj);
        final url = Uri.parse(urlObj);
        return MapEntry(type, url);
      }),
    );
  }

  Map<String, dynamic> toJSON() {
    final obj = toJSONObject();
    return obj.toJson();
  }

  DDNSDetectorConfigJSONObject toJSONObject() {
    return DDNSDetectorConfigJSONObject(
      duration: duration.inSeconds,
      times: times,
      urls: urls.map((type, url) {
        final typeObj = type.name;
        final urlObj = url.toString();
        return MapEntry(typeObj, urlObj);
      }),
    );
  }
}

@JsonSerializable(includeIfNull: false)
class DDNSDetectorConfigJSONObject {
  final int duration;
  final int times;
  final Map<String, String> urls;

  DDNSDetectorConfigJSONObject({
    required this.duration,
    required this.times,
    required this.urls,
  });

  factory DDNSDetectorConfigJSONObject.fromJson(Map<String, dynamic> json) =>
      _$DDNSDetectorConfigJSONObjectFromJson(json);

  Map<String, dynamic> toJson() => _$DDNSDetectorConfigJSONObjectToJson(this);
}
