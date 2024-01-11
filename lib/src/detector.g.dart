// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detector.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpDetectorConfig _$HttpDetectorConfigFromJson(Map<String, dynamic> json) =>
    HttpDetectorConfig(
      urls: Map<String, String>.from(json['urls'] as Map),
    );

Map<String, dynamic> _$HttpDetectorConfigToJson(HttpDetectorConfig instance) =>
    <String, dynamic>{
      'urls': instance.urls,
    };
