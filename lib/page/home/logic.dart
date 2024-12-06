import 'package:bei_dou_gms_manage/page/home/bar_home/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/view.dart';
import 'package:bei_dou_gms_manage/page/home/play_user/account/view.dart';
import 'package:bei_dou_gms_manage/page/home/play_user/view.dart';
import 'package:bei_dou_gms_manage/page/home/search_material/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {





/// 底部导航栏名称
  List<String> bottom_bar_View = [
    "游戏",
    "搜索",
    "玩家",
    "服务"
  ];

  List<Widget> body_View = [
    GameInfoComponent(),
    SearchMaterialComponent(),
    PlayUserComponent(),
    BarHomeComponent(),
  ];
  //bottom_bar_View的下标
  var currentIndex = 0;
  //侧边栏的key
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  //页面模块名称
  String V_bar_Name="bottom_bar_View";
  String V_body_Name="body_View";
  String V_drawer_Name="drawer_view";
  String V_appbar_Name="V_appbar_view";

  /// 打开侧边栏
  openDrawer(){
    drawerKey.currentState!.openDrawer();
  }



  /// 切换底部导航栏
  void changeIndex(int index){
  currentIndex = index;
  update([V_bar_Name,V_appbar_Name,V_body_Name]);
  }



  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
