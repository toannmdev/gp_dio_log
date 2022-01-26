import 'package:dio/dio.dart';
import 'package:gp_dio_log/gp_dio_log.dart';

Dio dio = Dio();

initHttp() {
  dio.interceptors.add(GPDioLogInterceptor());
}

httpGet(String url) {
  dio.get(url);
}
