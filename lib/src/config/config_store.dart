import 'ddns_detector_config.dart';
import 'go_daddy_client_config.dart';

abstract class ConfigStore {
  Future<GoDaddyClientConfig?> readGoDaddyConfig();
  Future<void> writeGoDaddyConfig(GoDaddyClientConfig? config);
  Future<DDNSDetectorConfig> readDetectorConfig();
  Future<void> writeDetectorConfig(DDNSDetectorConfig config);
}
