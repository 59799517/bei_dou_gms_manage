import 'package:flutter/material.dart';

class CategoryInfoReqPar  {
  late  int id;
  late String name;
  late int subId;
  late String subName;
  late int onSale;
  late int itemId;

  CategoryInfoReqPar.buidler(
      this.id, this.name, this.subId, this.subName, this.onSale, this.itemId);

  CategoryInfoReqPar(
      this.id, this.name, this.subId, this.subName, this.onSale, this.itemId);
  CategoryInfoReqPar.fromJson(Map<String, dynamic> json) {
    id = json['id'] ??= 0;
    name = json['name'] ??= "";
    subId = json['subId'] ??= 0;
    subName = json['subName'] ??= "";
    onSale = json['onSale'] ??= 0;
    itemId = json['itemId'] ??= 0;
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'subId': subId,
        'subName': subName,
        'onSale': onSale,
        'itemId': itemId,
      };
}
