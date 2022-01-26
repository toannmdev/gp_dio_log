class ReqOptions {
  int? id;
  String? url;
  String? method;
  String? contentType;
  DateTime? requestTime;
  Map<String, dynamic>? params;
  dynamic data;
  Map<String, dynamic>? headers;
  String cUrl;

  ReqOptions({
    this.id,
    this.url,
    this.method,
    this.contentType,
    this.requestTime,
    this.headers,
    this.params,
    this.data,
    required this.cUrl,
  });
}
