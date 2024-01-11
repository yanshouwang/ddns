part of '../core.dart';

extension DdnsHttpClient on HttpClient {
  Future<String> getUrlAsString(
    Uri url, {
    Map<String, Object>? headers,
  }) async {
    final request = await getUrl(url);
    final text = await request.send(
      headers: headers,
    );
    return text;
  }

  Future<String> putUrlAsString(
    Uri url, {
    Map<String, Object>? headers,
    required Object obj,
  }) async {
    final request = await putUrl(url);
    final text = await request.send(
      headers: headers,
      obj: obj,
    );
    return text;
  }
}

extension on HttpClientRequest {
  Future<String> send({
    Map<String, Object>? headers,
    Object? obj,
  }) async {
    if (headers != null) {
      for (var entry in headers.entries) {
        final name = entry.key;
        final value = entry.value;
        this.headers.add(name, value);
      }
    }
    if (obj != null) {
      write(obj);
    }
    final response = await close();
    final statusCode = response.statusCode;
    final text = response.transform(utf8.decoder).join();
    if (statusCode != HttpStatus.ok) {
      throw HttpException('''statusCode:$statusCode
message:$text''');
    }
    return text;
  }
}
