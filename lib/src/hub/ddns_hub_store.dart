part of '../hub.dart';

abstract class DdnsHubStore {
  Future<DdnsHubConfig> readHubConfig();

  Future<void> writeHubConfig(DdnsHubConfig config);
}
