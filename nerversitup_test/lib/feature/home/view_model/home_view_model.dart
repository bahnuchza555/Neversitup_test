import 'dart:developer';

import 'package:flutter/material.dart';
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
      var data = await DepartmentRepository().getDepartmentCarousel();

      if (data?.isEmpty == true) {
        throw "Department is empty";
      }
      departmentList = data ?? [];
      await loadProducts(departmentList[0].id ?? "1", departmentName: departmentList[0].name);
      notifyListeners();
    } catch (e) {
      log("message error : $e");
    }
  }

  loadProducts(String departmentID, {String? departmentName}) async {
    selectedDepartmentName = departmentName;
    notifyListeners();
    try {
      var data = await ProductRepository().getProducts(departmentID);

      if (data?.isEmpty == true) {
        throw "Department is empty";
      }
      products = data ?? [];
      notifyListeners();
    } catch (e) {
      log("message error : $e");
    }
  }
}