import 'package:bei_dou_gms_manage/api/page/CashShopApi.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/npc_shop/npc_shop_inof/entity/NPCShopInfoEntity.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class NpcShopInofLogic extends GetxController {
  //每个模块名称
  String V_show_doby_view = "show_doby_view";

  //传递过来的商店名称
  String shopId = "";

  //页码
  int pageNo = 1;

  //总条数接口返回判断最后一页用
  int total = 0;

  //每页条数 接口返回判断最后一页用
  int pageSize = 20;

  // 页面显示数值
  List<NPCShopInfoEntity> npcList = [];
  void reqSearchNpcInfoList({bool clear = false}) async {
    if (clear) {
      pageNo = 1;
      total = 0;
      npcList.clear();
    }
    Map<String, dynamic> data = {
      "pageNo": pageNo,
      "pageSize": pageSize,
      "onlyTotal": false,
      "notPage": false,
      "shopId": int.parse(shopId)
    };
    var value = await cashShopApi.searchNpcInfoList(data);
    if (value["code"] == 20000) {
      npcList.addAll(NPCShopInfoEntity.fromJsonList(value["data"]['records']));
      total = value["data"]['totalRow'];
      pageSize = value["data"]['pageSize'];
      update([V_show_doby_view]);
    }
    update([V_show_doby_view]);
  }

  //删除
  void deleteNpcInfo(String id) async {
    var value = await cashShopApi.deleteNpcItem(id);
    if (value["code"] == 20000) {
      BotToast.showText(text: "删除成功");
    } else {
      BotToast.showText(text: "删除失败");
    }
  }
}
