class ResOptions {
  int? id;
  dynamic data;
  int? statusCode;
  DateTime? responseTime; //ms
  int? duration; //ms
  Map<String, List<String>>? headers;
  ResOptions({
    this.id,
    this.data,
    this.statusCode,
    this.responseTime,
    this.duration,
    this.headers,
  });
}
