import 'dart:io';

import 'package:ddns/ddns.dart';
import 'package:logging/logging.dart';

import 'std_io_logging.dart';

void main(List<String> args) async {
  final logger = Logger.root;
  final onLogged = stdIOLogListener();
  logger.onRecord.listen(onLogged);
  // Use any available host or container IP (usually `0.0.0.0`).
  final address = InternetAddress.anyIPv4;
  // For running in containers, we respect the DDNS_HUB_PORT environment variable.
  final port = int.parse(Platform.environment['DDNS_HUB_PORT'] ?? '3543');
  final ddnsHub = DDNSHub();
  await ddnsHub.setUp();
  final server = await ddnsHub.serve(address, port);
  logger.info('Serving at http://${server.address.host}:${server.port}');
}
