import 'package:bei_dou_gms_manage/api/page/CashShopApi.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/npc_shop/entity/NPCEntity.dart';
import 'package:get/get.dart';

class Npc_shopLogic extends GetxController {
  //每个模块名称
  String V_show_doby_view = "show_doby_view";

  //页码
  int pageNo = 1;

  //总条数接口返回判断最后一页用
  int total = 0;

  //每页条数 接口返回判断最后一页用
  int pageSize = 20;

  //搜索框值
  String shopId = "";
  String npcId = "";
  String npcName = "";
  String itemId = "";
  String itemName = "";

  // 页面显示数值
  List<NPCEntity> npcList = [];

  //请求NCPLIST数据
  void reqSearchNpcList({bool clear = false}) async {
    if (clear) {
      pageNo = 1;
      total = 0;
      npcList.clear();
    }

    Map<String, dynamic> data = {
      "pageNo": pageNo,
      "pageSize": pageSize,
      "onlyTotal": false,
      "notPage": false
    };
    if (shopId.isNotEmpty) {
      data["shopId"] = shopId;
    }
    if (npcId.isNotEmpty) {
      data["npcId"] = npcId;
    }
    if (npcName.isNotEmpty) {
      data["npcName"] = npcName;
    }
    if (itemId.isNotEmpty) {
      data["itemId"] = itemId;
    }
    if (itemName.isNotEmpty) {
      data["itemName"] = itemName;
    }
    var value = await cashShopApi.searchNpcList(data);
    if (value["code"] == 20000) {
      npcList.addAll(NPCEntity.fromJsonList(value["data"]['records']));
      total = value["data"]['totalRow'];
      pageSize = value["data"]['pageSize'];
      update([V_show_doby_view]);
    }
  }
}
