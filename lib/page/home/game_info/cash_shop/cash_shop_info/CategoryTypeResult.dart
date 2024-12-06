import 'package:flutter/material.dart';

class CategoryTypeResult{

  late  int id;
  late String name;
  late int subId;
  late String subName;
  late bool onSale;
  late int itemId;

  //格式化和序列化json
  factory CategoryTypeResult.fromJson(Map<String, dynamic> json) => CategoryTypeResult(
      id: json['id']??=0,
      name: json['name']??="",
      subId: json['subId']??=0,
      subName: json['subName']??="",
      onSale: json['onSale']??=false,
      itemId: json['itemId']??=0
  );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'subId': subId,
    'subName': subName,
    'onSale': onSale,
    'itemId': itemId
  };
  CategoryTypeResult({
    required this.id,
    required this.name,
    required this.subId,
    required this.subName,
    required this.onSale,
    required this.itemId
  });
  static List<CategoryTypeResult> fromJsonList(List list){
    return list.map((item) => CategoryTypeResult.fromJson(item)).toList();
  }


}
