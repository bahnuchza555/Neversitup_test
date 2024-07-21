import 'package:dio/dio.dart';
import 'package:nerversitup_test/core/resouces/data_state.dart';
import 'package:nerversitup_test/domain/model/product_model.dart';
import 'package:nerversitup_test/service/product_api.dart';

class ProductRepository {
  Future<DataState<List<ProductModel>?>> getProducts(String departmentID) async {
    try {
      var serviceRes = await ProductApi().getProducts(departmentID: departmentID);
      if (serviceRes.statusCode == 200) {
      List<dynamic>? res = serviceRes.data;
      List<ProductModel>? data = res?.map((e) => ProductModel.fromJson(e)).toList();
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