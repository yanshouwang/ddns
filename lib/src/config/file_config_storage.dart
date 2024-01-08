import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import 'config_store.dart';
import 'ddns_detector_config.dart';
import 'go_daddy_client_config.dart';

class FileConfigStorage extends ConfigStore {
  final String _goDaddyPath;
  final String _detectorPath;

  FileConfigStorage(String path)
      : _goDaddyPath = join(path, 'go_daddy.json'),
        _detectorPath = join(path, 'detector.json');

  File get _goDaddyFile => File(_goDaddyPath);
  File get _detectorFile => File(_detectorPath);

  @override
  Future<DDNSDetectorConfig> readDetectorConfig() async {
    // Create DDNS detector config file if not exists.
    final exists = await _detectorFile.exists();
    if (!exists) {
      await writeDetectorConfig(DDNSDetectorConfig.undefined);
    }
    final configText = await _detectorFile.readAsString();
    final configJSON = json.decode(configText);
    final config = DDNSDetectorConfig.fromJSON(configJSON);
    return config;
  }

  @override
  Future<GoDaddyClientConfig?> readGoDaddyConfig() async {
    final exists = await _goDaddyFile.exists();
    if (!exists) {
      return null;
    }
    final configText = await _goDaddyFile.readAsString();
    final configJSON = json.decode(configText);
    final config = GoDaddyClientConfig.fromJSON(configJSON);
    return config;
  }

  @override
  Future<void> writeDetectorConfig(DDNSDetectorConfig config) async {
    final configJSON = config.toJSON();
    final configText = json.encode(configJSON);
    await _detectorFile.overwriteAsString(configText);
  }

  @override
  Future<void> writeGoDaddyConfig(GoDaddyClientConfig? config) async {
    if (config == null) {
      await _goDaddyFile.deleteWhenExists();
    } else {
      final configJSON = config.toJSON();
      final configText = json.encode(configJSON);
      await _goDaddyFile.overwriteAsString(configText);
    }
  }
}

extension on File {
  Future<void> deleteWhenExists() async {
    final exists = await this.exists();
    if (!exists) {
      return;
    }
    await delete();
  }

  Future<void> overwriteAsString(String text) async {
    await deleteWhenExists();
    await create(recursive: true);
    await writeAsString(text);
  }
}
