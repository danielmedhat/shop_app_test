import 'package:flutter/cupertino.dart';

class CategoriesModel {
  bool status;
  CategoriesDataModel data;
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  int currentPage;
  List<CategoriesData> data = [];
  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(CategoriesData.fromJson(element));
    });
  }
}

class CategoriesData {
  String name;
  String image;
  CategoriesData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }
}
