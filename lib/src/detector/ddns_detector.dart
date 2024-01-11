part of '../detector.dart';

abstract class DdnsDetector {
  Logger get _logger => Logger('$runtimeType');

  Future<String?> detect(DdnsRecordType type) async {
    try {
      final value = await _detect(type);
      _logger.info('Detected ${type.name}: $value');
      return value;
    } catch (e, stack) {
      _logger.warning('Detect ${type.name} failed.', e, stack);
      return null;
    }
  }

  Future<String> _detect(DdnsRecordType type);
}
