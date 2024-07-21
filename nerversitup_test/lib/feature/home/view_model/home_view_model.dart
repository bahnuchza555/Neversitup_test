import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nerversitup_test/common/toast_v3_widget.dart';
import 'package:nerversitup_test/core/resouces/data_state.dart';
import 'package:nerversitup_test/domain/model/department_model.dart';
import 'package:nerversitup_test/domain/model/product_model.dart';
import 'package:nerversitup_test/domain/repository/department_repository.dart';
import 'package:nerversitup_test/domain/repository/product_repository.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this.context);

  BuildContext context;
  List<DepartmentModel> departmentList = [];
  List<ProductModel> products = [];
  String? selectedDepartmentName = "";

  init() async {
    await _loadDepartment();
  }

  _loadDepartment() async {
    try {
      var result = await DepartmentRepository().getDepartmentCarousel();

      if (result is DataSuccess && result.data?.isNotEmpty == true) {
        departmentList = result.data!;
        await loadProducts(departmentList[0].id ?? "1",
            departmentName: departmentList[0].name);
      } else {
        throw "Department is empty";
      }
      notifyListeners();
    } on DataFail catch (e) {
      log("DataFail error : ${e.error?.message}");
      ToastWidget(context).show(message: "${e.error?.message}");
    } catch (e) {
      log("message error : $e");
      ToastWidget(context).show(message: "$e");
    }
  }

  loadProducts(String departmentID, {String? departmentName}) async {
    selectedDepartmentName = departmentName;
    notifyListeners();
    try {
      var result = await ProductRepository().getProducts(departmentID);

      if (result is DataSuccess && result.data?.isNotEmpty == true) {
        products = result.data!;
      } else {
        throw "Products is empty";
      }
      notifyListeners();
    } on DataFail catch (e) {
      log("DataFail error : $e");
      ToastWidget(context).show(message: "${e.error?.message}");
    } catch (e) {
      log("message error : $e");
      ToastWidget(context).show(message: "$e");
    } 
  }
}