import 'package:bei_dou_gms_manage/api/BaseAPI.dart';
import 'package:bei_dou_gms_manage/api/request.dart';
import 'package:bei_dou_gms_manage/page/home/search_material/entity/SearchReqPar.dart';
import 'package:flutter/material.dart';

class InformationSearchApi  {

  static InformationSearchApi? _instance;

  factory InformationSearchApi() => _instance ?? InformationSearchApi._internal();

  static InformationSearchApi? get instance => _instance ?? InformationSearchApi._internal();

  /// 初始化
  InformationSearchApi._internal() {
  }

  //搜索
  Future<dynamic> search(String search_text,List<SearchReqPar> selected_list) async{
    //导出Stringvalue数组
    List<String> selected_list_value = [];
    selected_list.forEach((element) {
      selected_list_value.add(element.search_text);
    });
   var data =  {"data":{"types": selected_list_value, "filter": search_text.toString()}};
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.informationSearch, method: DioMethod.post,
        data: data);
    return result;

  }


}
//导出全部
final informationSearchApi = InformationSearchApi();
