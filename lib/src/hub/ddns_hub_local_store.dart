part of '../hub.dart';

class DdnsHubLocalStore extends LocalStore implements DdnsHubStore {
  DdnsHubLocalStore(super.storePath);

  String get _hubConfigPath => join(storePath, 'hub.json');

  @override
  Future<DdnsHubConfig> readHubConfig() async {
    final configText = await read(_hubConfigPath);
    if (configText == null) {
      throw ArgumentError.notNull('hub');
    }
    final configJSON = json.decode(configText) as Map<String, dynamic>;
    final config = DdnsHubConfig.fromJson(configJSON);
    return config;
  }

  @override
  Future<void> writeHubConfig(DdnsHubConfig config) async {
    final configJson = config.toJson();
    final configText = json.encode(configJson);
    await write(_hubConfigPath, configText);
  }
}
