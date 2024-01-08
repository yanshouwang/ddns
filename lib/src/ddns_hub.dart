import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as sio;
import 'package:shelf_router/shelf_router.dart';

import 'model.dart';
import 'client.dart';
import 'detector.dart';
import 'config.dart';

part 'ddns_hub.g.dart';

abstract class DDNSHub {
  factory DDNSHub() => _DDNSHub();

  Future<void> setUp();
  Future<HttpServer> serve(Object address, int port);
}

class _DDNSHub implements DDNSHub {
  final ConfigStore _configStore;
  final Set<DDNSClient> _clients;
  final DDNSDetector _detector;

  _DDNSHub()
      : _configStore = FileConfigStorage('/.DDNS'),
        _clients = {},
        _detector = DDNSDetector();

  Logger get _logger => Logger('$runtimeType');
  Router get _router => _$_DDNSHubRouter(this);

  @override
  Future<void> setUp() async {
    // Set up DDNS clients.
    await setUpClients();
    // Set up DDNS detector.
    await setUpDetector();
  }

  Future<void> setUpClients() async {
    final goDaddyConfig = await _configStore.readGoDaddyConfig();
    if (goDaddyConfig != null) {
      final goDaddyClient = GoDaddyClient(
        key: goDaddyConfig.key,
        secret: goDaddyConfig.secret,
        domains: goDaddyConfig.domains.map((domainConfig) {
          return Domain(
            name: domainConfig.name,
            records: domainConfig.records.expand((recordConfig) {
              return recordConfig.types.map((type) {
                return DNSRecord(
                  name: recordConfig.name,
                  type: type,
                  value: '',
                );
              });
            }).toSet(),
          );
        }).toSet(),
      );
      _clients.add(goDaddyClient);
    }
  }

  Future<void> setUpDetector() async {
    final config = await _configStore.readDetectorConfig();
    final duration = config.duration;
    final times = config.times;
    final urls = config.urls;
    if (duration.inSeconds < 60) {
      throw ArgumentError.value(
          duration, 'Detect duration can not less then 60 seconds.');
    }
    if (times < 1) {
      throw ArgumentError.value(times, 'Detect times can not less then 1.');
    }
    if (urls.isEmpty) {
      throw ArgumentError.notNull('urls');
    }
    // Start DDNS detector if clients is not empty.
    if (_clients.isEmpty) {
      _logger.warning('No DDNS client.');
      return;
    }
    _detector.start(
      duration: duration,
      times: times,
      urls: urls,
      onDetected: onDetected,
    );
  }

  Future<void> onDetected(Map<DNSRecordType, String> values) async {
    for (var client in _clients) {
      try {
        await client.update(values);
      } catch (e, stack) {
        _logger.severe('${client.runtimeType} update failed.', e, stack);
      }
    }
  }

  void tearDown() {
    if (_clients.isEmpty) {
      return;
    }
    _detector.stop();
    _clients.clear();
  }

  @override
  Future<HttpServer> serve(Object address, int port) async {
    final loggerMiddleware = logRequests(
      logger: (message, failed) {
        if (failed) {
          _logger.severe(message);
        } else {
          _logger.info(message);
        }
      },
    );
    final handler =
        Pipeline().addMiddleware(loggerMiddleware).addHandler(_router);
    final server = await sio.serve(handler, address, port);
    return server;
  }

  @Route.get('/version')
  Future<Response> getVersion(Request request) async {
    return Response.ok('version');
  }
}
