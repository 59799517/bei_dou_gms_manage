import 'package:bei_dou_gms_manage/api/page/CashShopApi.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/global_shop/entity/GameGlobalEntity.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class GlobalShopLogic extends GetxController {
  //每个模块名称
  String V_show_doby_view = "show_doby_view";

  //页码
  int pageNo = 1;

  //总条数接口返回判断最后一页用
  int total = 0;

  //每页条数 接口返回判断最后一页用
  int pageSize = 20;

  //搜索框值
  String continent = "";
  String itemId = "";
  String questId = "";

  List<GameGlobalEntity> list = [];

  //请求接口
  Future getData({bool clear = false}) async {
    if (clear) {
      pageNo = 1;
      total = 0;
      list.clear();
    }
    var data = {
      "pageNo": pageNo,
      "pageSize": pageSize,
      "onlyTotal": "false",
      "notPage": "false"
    };
    if (continent.isNotEmpty) {
      data["continent"] = continent;
    }
    if (itemId.isNotEmpty) {
      data["itemId"] = itemId;
    }
    if (questId.isNotEmpty) {
      data["questId"] = questId;
    }
    var value = await cashShopApi.getGameGlobalList(data);
    if (value["code"] == 20000) {
      list.addAll(GameGlobalEntity.fromJsonList(value["data"]['records']));
      total = value["data"]['totalRow'];
      pageSize = value["data"]['pageSize'];
      update([V_show_doby_view]);
    }
  }

//删除
  Future reqDelete(String id) async {
    var value = await cashShopApi.deleteGameGlobal(id);
    if (value["code"] == 20000) {
      BotToast.showText(text: "删除成功");
    } else {
      BotToast.showText(text: "删除失败");
    }
  }
}
