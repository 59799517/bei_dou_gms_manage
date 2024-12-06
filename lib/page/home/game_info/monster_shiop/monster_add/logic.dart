import 'package:bei_dou_gms_manage/api/page/CashShopApi.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class MonsterAddLogic extends GetxController {
  String V_list_body_view = "list_body_view";

  Future reqAddMonster(Map<String, String> data) async {
    if (data["dropperId"]!.isEmpty) {
      BotToast.showText(text: "请输入怪物ID");
    }
    if (data["itemId"]!.isEmpty) {
      BotToast.showText(text: "请输入物品ID");
    }
    if (data["minimumQuantity"]!.isEmpty) {
      BotToast.showText(text: "请输入最少数量");
    }
    if (data["maximumQuantity"]!.isEmpty) {
      BotToast.showText(text: "请输入最多数量");
    }
    if (data["chance"]!.isEmpty) {
      BotToast.showText(text: "请输入爆率");
    }
    if (data["questId"]!.isEmpty) {
      BotToast.showText(text: "请输入任务ID");
    }
    var value = await cashShopApi.addMonster(data);
    if (value["code"] == 20000) {
      BotToast.showText(text: "新增成功");
    } else {
      BotToast.showText(text: "新增失败");
    }
  }
}
