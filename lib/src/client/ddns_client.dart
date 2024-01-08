import '../model.dart';

abstract class DDNSClient {
  final Set<Domain> domains;

  DDNSClient({required this.domains});

  Future<void> update(Map<DNSRecordType, String> values);
}
