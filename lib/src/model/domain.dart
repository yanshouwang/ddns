import 'dns_record.dart';

class Domain {
  final String name;
  final Set<DNSRecord> records;

  Domain({
    required this.name,
    required this.records,
  });

  @override
  operator ==(Object other) {
    return other is Domain && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
