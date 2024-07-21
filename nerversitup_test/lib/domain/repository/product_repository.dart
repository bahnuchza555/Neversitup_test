import 'package:nerversitup_test/domain/model/product_model.dart';
import 'package:nerversitup_test/service/product_api.dart';

class ProductRepository {
  Future<List<ProductModel>?> getProducts(String departmentID) async {
    var serviceRes = await ProductApi().getProducts(departmentID: departmentID);
    if (serviceRes.statusCode != 200) {
      throw "Lost Connect";
    }
    List<dynamic> data = serviceRes.data;
    List<ProductModel> res = data.map((e) => ProductModel.fromJson(e)).toList();
    return res;
  }
}