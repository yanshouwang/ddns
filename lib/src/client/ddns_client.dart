part of '../client.dart';

abstract class DdnsClient {
  final Set<Domain> domains;

  DdnsClient({
    required this.domains,
  });

  Logger get _logger => Logger('$runtimeType');

  Future<void> update(Map<DdnsRecordType, String> values) async {
    for (var domain in domains) {
      for (var record in domain.ddns.records) {
        try {
          final value = values[record.type];
          if (value == null) {
            throw ArgumentError.notNull('value');
          }
          await _updateRecord(domain, record, value);
          _logger.info(
              'Updated ${record.name}.${domain.name}/${record.type.name} - ttl:${record.ttl} value: $value.');
        } catch (e, stack) {
          _logger.warning(
            'Update ${record.name}.${domain.name}/${record.type.name} failed.',
            e,
            stack,
          );
        }
      }
    }
  }

  Future<void> _updateRecord(Domain domain, DdnsRecord record, String value);
}
