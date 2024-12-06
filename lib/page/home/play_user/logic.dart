import 'package:bei_dou_gms_manage/api/page/AccountApi.dart';
import 'package:bei_dou_gms_manage/page/home/play_user/entity/PlayUserOnlineEntity.dart';
import 'package:get/get.dart';

class PlayUserLogic extends GetxController {

  //每个模块名称
  String V_show_doby_view = "show_doby_view";


  //页码
  int pageNo = 1;

  //总条数接口返回判断最后一页用
  int total = 0;

  //每页条数 接口返回判断最后一页用
  int pageSize = 10;

  //搜索框
  String s_id="";
  String s_name="";
  String s_map="";


  List<PlayUserOnlineEntity> list=[];


  void getData({bool clear = false}) async {
    if (clear) {
      pageNo = 1;
      list.clear();
    }
    Map<String, dynamic> data = {
      "pageNo": pageNo,
      "pageSize": pageSize,
    };
    if (s_id.isNotEmpty) data["id"] = s_id;
    if (s_name.isNotEmpty) data["name"] = s_name;
    if (s_map.isNotEmpty) data["map"] = s_map;
   var  value = await accountApi.onlinePlayUserData(data);
    if (value["code"] == 20000) {
      list.addAll(PlayUserOnlineEntity.fromJsonList(value["data"]['records']));
      total = value["data"]['totalRow'];
      pageSize = value["data"]['pageSize'];
      update([V_show_doby_view]);
    }
  }


}
