import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';

import '../model.dart';
import 'exp.dart';

typedef DDNSDetectedCallback = Future<void> Function(
    Map<DNSRecordType, String> values);

class DDNSDetector {
  final HttpClient _client;
  bool _cancelled;
  Map<DNSRecordType, String> _values;

  DDNSDetector()
      : _client = HttpClient(),
        _cancelled = false,
        _values = {};

  Logger get _logger => Logger('$runtimeType');

  void start({
    required Duration duration,
    required int times,
    required Map<DNSRecordType, Uri> urls,
    required DDNSDetectedCallback onDetected,
  }) async {
    if (urls.isEmpty) {
      throw ArgumentError('Can not detect IP addresses without urls.');
    }
    if (!_cancelled) {
      throw StateError('Already started.');
    }
    _logger.info('Started.');
    var remainingTimes = times;
    while (!_cancelled) {
      try {
        final values = <DNSRecordType, String>{};
        var url = urls[DNSRecordType.a];
        if (url != null) {
          values[DNSRecordType.a] = await _client.getIPv4(url);
        }
        url = urls[DNSRecordType.aaaa];
        if (url != null) {
          values[DNSRecordType.aaaa] = await _client.getIPv6(url);
        }
        final unchanged =
            values.keys.every((type) => values[type] == _values[type]);
        if (unchanged && remainingTimes > 0) {
          remainingTimes--;
          _logger.info('Unchanged, remaining times: $remainingTimes.');
          return;
        }
        remainingTimes = times;
        await onDetected(values);
        _values = values;
      } catch (e, stack) {
        _logger.warning('Detect failed.', e, stack);
      } finally {
        remainingTimes++;
        await Future.delayed(duration);
      }
    }
  }

  void stop() {
    if (_cancelled) {
      throw StateError('Already stopped.');
    }
    _values = {};
    _cancelled = true;
    _logger.info('Stopped.');
  }
}

extension on HttpClient {
  Future<String> getIPv4(Uri url) async {
    final request = await getUrl(url);
    final response = await request.close();
    final content = await response.transform(utf8.decoder).join();
    final match = ipv4Exp.firstMatch(content);
    if (match == null) {
      throw HttpException('Match IPv4 failed with content: $content');
    }
    return match[0]!;
  }

  Future<String> getIPv6(Uri url) async {
    final request = await getUrl(url);
    final response = await request.close();
    final content = await response.transform(utf8.decoder).join();
    final match = ipv6Exp.firstMatch(content);
    if (match == null) {
      throw HttpException('Match IPv6 failed with content: $content');
    }
    return match[0]!;
  }
}
