import 'package:flutter/material.dart';

class InformationResult{
  late String type;
  late int id;
  late String name;
  late String desc;

  InformationResult(this.type,this.id,this.name,this.desc);
  InformationResult.fromJson(Map<String, dynamic> json) {
    type = json['type']??="";
    id = json['id']??=0;
    name = json['name']??="";
    desc = json['desc']??="";
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    return data;
  }
  //解析list
  static List<InformationResult> parseList(List<dynamic> jsonList){
    List<InformationResult> list = [];
    jsonList.forEach((element) {
      list.add(InformationResult.fromJson(element));
    });
    return list;
  }
}
