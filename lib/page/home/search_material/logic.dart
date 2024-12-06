import 'package:bei_dou_gms_manage/api/page/InformationSearchApi.dart';
import 'package:bei_dou_gms_manage/page/home/search_material/entity/SearchReqPar.dart';
import 'package:bei_dou_gms_manage/page/home/search_material/entity/SearchResult.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SearchMaterialLogic extends GetxController {

  List<SearchReqPar> selectedItems=[];
  //页面模块名称
  String V_select_Name="search_select_View";
  String V_search_searchResult_Name="search_searchResult_View";
  //搜索数据框
  TextEditingController search_controller = TextEditingController();
  //搜索的内容
  List<InformationResult> searchResult=[];




  final List<SearchReqPar> selectList = [
    SearchReqPar("现金", "cash"),
    SearchReqPar("消耗", "consume"),
    SearchReqPar("装备", "eqp"),
    SearchReqPar("其他", "etc"),
    SearchReqPar("设置", "ins"),
    SearchReqPar("地图", "map"),
    SearchReqPar("怪物", "mob"),
    SearchReqPar("NPC", "npc"),
    SearchReqPar("宠物", "pet"),
    SearchReqPar("技能", "skill"),
  ];


  //类型转中文描述
  String getTypeDesc(String type){
    return selectList.firstWhere((element) => element.search_text == type).search_name;
  }




  //修改选择值
  void changeSelectValue(){
    update([V_select_Name]);
  }
  void onSearch(){
    if(search_controller.text.isEmpty){
      BotToast.showText(text:"搜索内容不能为空。");
      return;
    }
    if(selectedItems.isEmpty){
      BotToast.showText(text:"请选择搜索类型。");
      return;
    }
    informationSearchApi.search(search_controller.text,selectedItems).then((value) {
      if(value["code"] == 20000){
        var data = value["data"];
        searchResult = InformationResult.parseList(data);
        update([V_search_searchResult_Name]);
      }else{
        BotToast.showText(text:value["message"]);
      }
      print("搜索结果:$value");
    });

  }


}
