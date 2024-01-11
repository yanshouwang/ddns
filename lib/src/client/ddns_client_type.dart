part of '../client.dart';

enum DdnsClientType {
  goDaddy('goDaddy');

  final String name;

  const DdnsClientType(this.name);
}
