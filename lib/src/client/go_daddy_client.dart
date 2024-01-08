import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';

import '../model.dart';
import 'ddns_client.dart';

class GoDaddyClient extends DDNSClient {
  final String _key;
  final String _secret;
  final HttpClient _client;

  GoDaddyClient({
    required String key,
    required String secret,
    required super.domains,
  })  : _key = key,
        _secret = secret,
        _client = HttpClient()..findProxy = HttpClient.findProxyFromEnvironment;

  Logger get _logger => Logger('$runtimeType');

  @override
  Future<void> update(Map<DNSRecordType, String> values) async {
    try {
      for (var domain in domains) {
        final url = Uri.https(
          'api.godaddy.com',
          '/v1/domains/${domain.name}/records',
        );
        final request = await _client.patchUrl(url);
        request.headers.add(
          HttpHeaders.contentTypeHeader,
          ContentType.json.toString(),
        );
        request.headers.add(
          HttpHeaders.authorizationHeader,
          'sso-key $_key:$_secret',
        );
        final recordsJSON = domain.records.map((record) {
          final type = record.type;
          final value = values[type];
          return record.copyWith(value: value).toJSON();
        }).toList();
        final recordsText = json.encode(recordsJSON);
        request.write(recordsText);
        final response = await request.close();
        final statusCode = response.statusCode;
        if (statusCode != HttpStatus.ok) {
          final message = await response.transform(utf8.decoder).join();
          throw HttpException(
            '''Update DDNS failed.
records: $recordsText
statusCode: $statusCode
message: $message''',
            uri: url,
          );
        }
        _logger.info('Update DDNS succeed.');
      }
    } catch (e, stack) {
      _logger.warning('Update DDNS failed.', e, stack);
    }
  }
}

extension on DNSRecord {
  Map<String, dynamic> toJSON() {
    return GoDaddyRecord(
      data: value,
      name: name,
      ttl: ttl,
      type: type.name,
    ).toJSON();
  }
}
