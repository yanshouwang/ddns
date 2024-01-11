part of '../core.dart';

enum DdnsRecordType {
  a('A'),
  aaaa('AAAA');

  final String name;

  const DdnsRecordType(this.name);
}
