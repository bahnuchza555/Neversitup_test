import 'package:dio/dio.dart';
import 'package:nerversitup_test/core/resouces/data_state.dart';
import 'package:nerversitup_test/domain/model/department_model.dart';
import 'package:nerversitup_test/service/department_api.dart';

class DepartmentRepository {
  Future<DataState<List<DepartmentModel>?>> getDepartmentCarousel() async {
    try {
      var serviceRes = await DepartmentApi().getDepartmentCarousel();
    if (serviceRes.statusCode == 200) {
      List<dynamic>? res = serviceRes.data;
      List<DepartmentModel>? data = res?.map((e) => DepartmentModel.fromJson(e)).toList();
      return DataSuccess(data);
    } else {
      return DataFail(DioException(
        requestOptions: serviceRes.requestOptions,
        error: serviceRes.statusMessage,
        response: serviceRes,
        type: DioExceptionType.badResponse,
      ));
    }
    } on DioException catch (e) {
      return DataFail(e);
    }
  }
}