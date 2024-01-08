import 'dns_record_type.dart';

class DNSRecord {
  final String name;
  final DNSRecordType type;
  final String value;
  final int ttl;

  DNSRecord({
    required this.name,
    required this.type,
    required this.value,
    this.ttl = 600,
  });

  DNSRecord copyWith({
    String? value,
    int? ttl,
  }) {
    value ??= this.value;
    ttl ??= this.ttl;
    return DNSRecord(
      name: name,
      type: type,
      value: value,
      ttl: ttl,
    );
  }

  @override
  operator ==(Object other) {
    return other is DNSRecord && other.name == name && other.type == type;
  }

  @override
  int get hashCode => Object.hash(name, type);
}
