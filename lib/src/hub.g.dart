// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DdnsHubConfig _$DdnsHubConfigFromJson(Map<String, dynamic> json) =>
    DdnsHubConfig(
      duration: json['duration'] as int,
      times: json['times'] as int,
      detectorType: json['detectorType'] as String,
      recordTypes: (json['recordTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      detectors: DdnsDetectorsConfig.fromJson(
          json['detectors'] as Map<String, dynamic>),
      clients:
          DdnsClientsConfig.fromJson(json['clients'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DdnsHubConfigToJson(DdnsHubConfig instance) =>
    <String, dynamic>{
      'duration': instance.duration,
      'times': instance.times,
      'recordTypes': instance.recordTypes,
      'detectorType': instance.detectorType,
      'detectors': instance.detectors,
      'clients': instance.clients,
    };

DdnsDetectorsConfig _$DdnsDetectorsConfigFromJson(Map<String, dynamic> json) =>
    DdnsDetectorsConfig(
      http: json['http'] == null
          ? null
          : HttpDetectorConfig.fromJson(json['http'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DdnsDetectorsConfigToJson(DdnsDetectorsConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('http', instance.http);
  return val;
}

DdnsClientsConfig _$DdnsClientsConfigFromJson(Map<String, dynamic> json) =>
    DdnsClientsConfig(
      goDaddy: json['goDaddy'] == null
          ? null
          : GoDaddyClientConfig.fromJson(
              json['goDaddy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DdnsClientsConfigToJson(DdnsClientsConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('goDaddy', instance.goDaddy);
  return val;
}

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$DdnsHubRouter(DdnsHub service) {
  final router = Router();
  router.add(
    'GET',
    r'/version',
    service._getVersion,
  );
  return router;
}
