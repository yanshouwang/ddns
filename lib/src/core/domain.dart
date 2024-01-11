part of '../core.dart';

class Domain {
  final String name;
  final DDNS ddns;

  Domain({
    required this.name,
    required this.ddns,
  });

  factory Domain.fromConfig(DomainConfig config) {
    return Domain(
      name: config.name,
      ddns: DDNS.fromConfig(config.ddns),
    );
  }

  DomainConfig toConfig() {
    return DomainConfig(
      name: name,
      ddns: ddns.toConfig(),
    );
  }

  @override
  operator ==(Object other) {
    return other is Domain && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

@JsonSerializable(includeIfNull: false)
class DomainConfig {
  final String name;
  final DdnsConfig ddns;

  DomainConfig({
    required this.name,
    required this.ddns,
  });

  factory DomainConfig.fromJson(Map<String, dynamic> json) =>
      _$DomainConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DomainConfigToJson(this);
}
