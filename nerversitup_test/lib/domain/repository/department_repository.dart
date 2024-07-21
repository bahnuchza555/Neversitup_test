import 'package:nerversitup_test/domain/model/department_model.dart';
import 'package:nerversitup_test/service/department_api.dart';

class DepartmentRepository {
  Future<List<DepartmentModel>?> getDepartmentCarousel() async {
    var serviceRes = await DepartmentApi().getDepartmentCarousel();
    if (serviceRes.statusCode != 200) {
      throw "Lost Connect";
    }
    List<dynamic> data = serviceRes.data;
    List<DepartmentModel> res = data.map((e) => DepartmentModel.fromJson(e)).toList();
    return res;
  }
}