import '../model.dart';

class DNSRecordValuesEventArgs {
  final Map<DNSRecordType, String> values;

  DNSRecordValuesEventArgs(this.values);
}
