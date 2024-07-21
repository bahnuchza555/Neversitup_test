import 'package:dio/dio.dart';
import 'package:nerversitup_test/setting/config.dart';

class ApiService {
  static late Dio client;
  BaseOptions _options = BaseOptions(
    baseUrl: endPointAPI,
    connectTimeout: Duration(seconds: 10),
    headers: {},
  );
  ApiService.initialize() {
    client = Dio(_options);
  }
}
