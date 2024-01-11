part of '../detector.dart';

enum DdnsDetectorType {
  http('http');

  final String name;

  const DdnsDetectorType(this.name);
}
