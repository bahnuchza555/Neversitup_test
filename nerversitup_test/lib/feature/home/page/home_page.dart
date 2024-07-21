import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nerversitup_test/feature/home/view_model/home_view_model.dart';
import 'package:nerversitup_test/setting/theme.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  HomeViewModel? controller;

  @override
  void initState() {
    super.initState();
    controller = HomeViewModel(context);
    controller?.init();
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      child: Consumer<HomeViewModel>(builder: (context, con, _) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Text(
                      "Department carousel",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    height: 80.0,
                    child: _buildDepartment(con),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Text(
                      "Product listing : ${con.selectedDepartmentName}",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  _buildProducts(con)
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDepartment(HomeViewModel con) {
    return ListView.builder(
      primary: true,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: con.departmentList.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        var item = con.departmentList[index];
        return GestureDetector(
          onTap: () {
            con.loadProducts(
              "${item.id}",
              departmentName: item.name,
            );
          },
          onDoubleTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Stack(
                children: [
                  Image.network(
                    "${item.imageUrl}",
                    height: 80.0,
                    width: 80.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 80.0,
                        width: 80.0,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        ),
                        child: const Icon(
                          Icons.image,
                          color: tertiaryColor,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 3.0,
                    right: 5.0,
                    child: Text(
                      item.name ?? "",
                      style: TextStyle(fontSize: 14.0, color: backgroundWhite),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProducts(HomeViewModel con) {
    return GridView.builder(
      primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
      ),
      itemCount: con.products.length,
      itemBuilder: (context, index) {
        var item = con.products[index];
        return GestureDetector(
          onTap: () {
            showDailogDes(item.desc ?? "");
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: primaryShodow,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    "${item.imageUrl}",
                    height: 110.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "${item.name}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                    child: Text(
                      "${item.desc}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 5.0, bottom: 5.0),
                          child: Text(
                            "${item.price}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showDailogDes(String des) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: backgroundWhite,
            title: Center(
              child: Text(
                "Product Description",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  des,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Center(
                    child: Text(
                  'Close',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ],
          );
        });
  }
}
