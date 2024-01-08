// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'go_daddy_client_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoDaddyClientConfigJSONObject _$GoDaddyClientConfigJSONObjectFromJson(
        Map<String, dynamic> json) =>
    GoDaddyClientConfigJSONObject(
      key: json['key'] as String,
      secret: json['secret'] as String,
      domains: (json['domains'] as List<dynamic>)
          .map(
              (e) => DomainConfigJSONObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GoDaddyClientConfigJSONObjectToJson(
        GoDaddyClientConfigJSONObject instance) =>
    <String, dynamic>{
      'key': instance.key,
      'secret': instance.secret,
      'domains': instance.domains,
    };
