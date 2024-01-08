// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ddns_detector_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DDNSDetectorConfigJSONObject _$DDNSDetectorConfigJSONObjectFromJson(
        Map<String, dynamic> json) =>
    DDNSDetectorConfigJSONObject(
      duration: json['duration'] as int,
      times: json['times'] as int,
      urls: Map<String, String>.from(json['urls'] as Map),
    );

Map<String, dynamic> _$DDNSDetectorConfigJSONObjectToJson(
        DDNSDetectorConfigJSONObject instance) =>
    <String, dynamic>{
      'duration': instance.duration,
      'times': instance.times,
      'urls': instance.urls,
    };
