import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gp_dio_log/bean/err_options.dart';
import 'package:gp_dio_log/bean/req_options.dart';
import 'package:gp_dio_log/bean/res_options.dart';

import '../gp_dio_log.dart';

class GPDioLogInterceptor implements Interceptor {
  LogPoolManager? logManage;
  GPDioLogInterceptor() {
    logManage = LogPoolManager.getInstance()!;
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    var errOptions = ErrOptions();
    errOptions.id = err.requestOptions.hashCode;
    errOptions.errorMsg = err.toString();
    //onResponse(err.response);
    logManage?.onError(errOptions);
    if (err.response != null) saveResponse(err.response!);
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var reqOpt = ReqOptions(cUrl: _cURLRepresentation(options));
    reqOpt.id = options.hashCode;
    reqOpt.url = options.uri.toString();
    reqOpt.method = options.method;
    reqOpt.contentType = options.contentType.toString();
    reqOpt.requestTime = DateTime.now();
    reqOpt.params = options.queryParameters;
    reqOpt.data = options.data;
    reqOpt.headers = options.headers;
    logManage?.onRequest(reqOpt);
    return handler.next(options);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    saveResponse(response);
    return handler.next(response);
  }

  void saveResponse(Response response) {
    var resOpt = ResOptions();
    resOpt.id = response.requestOptions.hashCode;
    resOpt.responseTime = DateTime.now();
    resOpt.statusCode = response.statusCode ?? 0;
    resOpt.data = response.data;
    resOpt.headers = response.headers.map;
    logManage?.onResponse(resOpt);
  }

  String _cURLRepresentation(RequestOptions options) {
    List<String> components = ["\$ curl -i"];
    components.add("-X ${options.method}");

    options.headers.forEach((k, v) {
      if (k != "Cookie") {
        components.add("-H \"$k: $v\"");
      }
    });

    if (options.method.toUpperCase() != "GET") {
      try {
        var data = json.encode(options.data);
        data = data.replaceAll('"', '\\"');
        components.add("-d \"$data\"");
      } catch (e) {}
    }

    components.add("\"${options.uri.toString()}\"");

    return components.join('\\\n\t');
  }
}
