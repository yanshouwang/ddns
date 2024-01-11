part of '../hub.dart';

class DdnsHub {
  final DdnsHubStore _store;
  late Duration duration;
  late int times;
  late Set<DdnsRecordType> _recordTypes;
  late DdnsDetectorType _detectorType;
  late Map<DdnsDetectorType, DdnsDetector> _detectors;
  late Map<DdnsClientType, DdnsClient> _clients;

  CancellationTokenSource? _watchCTS;
  Map<DdnsRecordType, String> _values;

  DdnsHub({
    required DdnsHubStore store,
  })  : _store = store,
        _values = {};

  DdnsHubConfig toConfig() {
    return DdnsHubConfig(
      duration: duration.inSeconds,
      times: times,
      detectorType: _detectorType.name,
      recordTypes: _recordTypes.map((type) => type.name).toList(),
      detectors: DdnsDetectorsConfig(
        http: _httpDetector?.toConfig(),
      ),
      clients: DdnsClientsConfig(
        goDaddy: _goDaddyClient?.toConfig(),
      ),
    );
  }

  Logger get _logger => Logger('$runtimeType');
  Router get _handler => _$DdnsHubRouter(this);

  HttpDetector? get _httpDetector {
    final detector = _detectors[DdnsDetectorType.http];
    return detector == null ? null : detector as HttpDetector;
  }

  GoDaddyClient? get _goDaddyClient {
    final client = _clients[DdnsClientType.goDaddy];
    return client == null ? null : client as GoDaddyClient;
  }

  Future<void> startUp(Object address, int port) async {
    await runZonedGuarded(
      () async {
        await _setUp();
        _watch();
        await _serve(address, port);
      },
      (e, stack) {
        _logger.severe('Uncaught error.', e, stack);
      },
    );
  }

  Future<void> _setUp() async {
    // Set up hub.
    final hubConfig = await _store.readHubConfig();
    duration = Duration(seconds: hubConfig.duration);
    times = hubConfig.times;
    _recordTypes = hubConfig.recordTypes
        .map((name) =>
            DdnsRecordType.values.firstWhere((type) => type.name == name))
        .toSet();
    _detectorType = DdnsDetectorType.values
        .firstWhere((type) => type.name == hubConfig.detectorType);
    // Set up detectors.
    final detectors = <DdnsDetectorType, DdnsDetector>{};
    final detectorsConfig = hubConfig.detectors;
    final httpDetectorConfig = detectorsConfig.http;
    if (httpDetectorConfig != null) {
      detectors[DdnsDetectorType.http] =
          HttpDetector.fromConfig(httpDetectorConfig);
    }
    _detectors = detectors;
    // Set up clients.
    final clients = <DdnsClientType, DdnsClient>{};
    final clientsConfig = hubConfig.clients;
    final goDaddyConfig = clientsConfig.goDaddy;
    if (goDaddyConfig != null) {
      clients[DdnsClientType.goDaddy] = GoDaddyClient.fromConfig(goDaddyConfig);
    }
    _clients = clients;
  }

  void _watch() async {
    if (duration.isNegative) {
      throw ArgumentError.value(duration, 'duration can not be negative.');
    }
    if (times.isNegative) {
      throw ArgumentError.value(times, 'times can not be nagative.');
    }
    final detector = _detectors[_detectorType];
    if (detector == null) {
      throw ArgumentError.notNull('detector');
    }
    if (_recordTypes.isEmpty) {
      throw ArgumentError.notNull('recordTypes');
    }
    if (_clients.isEmpty) {
      throw ArgumentError.notNull('clients');
    }
    if (_watchCTS != null) {
      throw StateError('Watching already started.');
    }
    // TODO: Watch synchronously.
    _logger.info('Watching started.');
    final cts = CancellationTokenSource();
    _watchCTS = cts;
    var remainingTimes = times;
    while (!cts.cancelled) {
      try {
        final values = <DdnsRecordType, String>{};
        for (var type in _recordTypes) {
          final value = await detector.detect(type);
          if (cts.cancelled) {
            break;
          }
          if (value == null) {
            continue;
          }
          values[type] = value;
        }
        if (cts.cancelled) {
          break;
        }
        final unchanged =
            values.keys.every((type) => values[type] == _values[type]);
        if (unchanged && remainingTimes > 0) {
          remainingTimes--;
          _logger.info('Unchanged, remaining times: $remainingTimes.');
        } else {
          remainingTimes = times;
          for (var client in _clients.values) {
            await client.update(values);
            if (cts.cancelled) {
              break;
            }
          }
          _values = values;
        }
      } catch (e, stack) {
        _logger.warning('Watch failed.', e, stack);
      }
      await Future.delayed(duration);
    }
    _logger.info('Watching stopped.');
  }

  Future<void> _serve(Object address, int port) async {
    final loggerMiddleware = logRequests(
      logger: (message, failed) {
        if (failed) {
          _logger.warning(message);
        } else {
          _logger.info(message);
        }
      },
    );
    final handler =
        Pipeline().addMiddleware(loggerMiddleware).addHandler(_handler);
    final server = await shelf_io.serve(handler, address, port);
    _logger.info('Serving at http://${server.address.host}:${server.port}');
  }

  @Route.get('/version')
  Future<Response> _getVersion(Request request) async {
    return Response.ok('version');
  }
}

@JsonSerializable(includeIfNull: false)
class DdnsHubConfig {
  final int duration;
  final int times;
  final List<String> recordTypes;
  final String detectorType;
  final DdnsDetectorsConfig detectors;
  final DdnsClientsConfig clients;

  DdnsHubConfig({
    required this.duration,
    required this.times,
    required this.detectorType,
    required this.recordTypes,
    required this.detectors,
    required this.clients,
  });

  factory DdnsHubConfig.fromJson(Map<String, dynamic> json) =>
      _$DdnsHubConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DdnsHubConfigToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DdnsDetectorsConfig {
  final HttpDetectorConfig? http;

  DdnsDetectorsConfig({
    this.http,
  });

  factory DdnsDetectorsConfig.fromJson(Map<String, dynamic> json) =>
      _$DdnsDetectorsConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DdnsDetectorsConfigToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DdnsClientsConfig {
  final GoDaddyClientConfig? goDaddy;

  DdnsClientsConfig({
    this.goDaddy,
  });

  factory DdnsClientsConfig.fromJson(Map<String, dynamic> json) =>
      _$DdnsClientsConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DdnsClientsConfigToJson(this);
}
