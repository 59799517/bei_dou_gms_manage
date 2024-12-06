import 'package:flutter/material.dart';

class SearchReqPar {

  late String search_name;
  late String search_text;


  SearchReqPar(this.search_name, this.search_text);

  SearchReqPar.fromJson(Map<String, dynamic> json) {
    search_name = json['search_name'];
    search_text = json['search_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search_name'] = this.search_name;
    data['search_text'] = this.search_text;
    return data;
  }
}

