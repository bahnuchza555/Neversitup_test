import 'package:dio/dio.dart';
import 'package:nerversitup_test/service/api_service.dart';

class DepartmentApi {
  Future<Response> getDepartmentCarousel() async {
    var path = "/v1/departments";
    print("url : ${ApiService.client.options.baseUrl}$path");
    print("header : ${ApiService.client.options.headers}");
    Future<Response> servicesRes = ApiService.client.get(path);
    return servicesRes;
  }
}