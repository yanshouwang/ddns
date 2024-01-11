import 'dart:io';

import 'package:ddns/ddns.dart';
import 'package:logging/logging.dart';

import 'std_io_logging.dart';

void main(List<String> args) async {
  final onLogged = stdIOLogListener(
    assumeTty: true,
    verbose: true,
  );
  Logger.root.onRecord.listen(onLogged);
  // Use any available host or container IP (usually `0.0.0.0`).
  final address = InternetAddress.anyIPv4;
  // For running in containers, we respect the DDNS_HUB_PORT environment variable.
  final port = int.parse(Platform.environment['DDNS_HUB_PORT'] ?? '3543');
  final ddnsHub = DdnsHub(
    store: DdnsHubLocalStore(''),
  );
  await ddnsHub.startUp(address, port);
}
