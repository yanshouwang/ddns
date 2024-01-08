enum DNSRecordType {
  a('A'),
  aaaa('AAAA');

  final String name;

  const DNSRecordType(this.name);
}
