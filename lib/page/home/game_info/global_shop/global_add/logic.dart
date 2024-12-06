import 'package:bei_dou_gms_manage/api/page/CashShopApi.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class GlobalAddLogic extends GetxController {
  String V_list_body_view = "list_body_view";

  Future reqAddData(Map<String, String> data) async {
    if (data["itemId"]!.isEmpty) {
      BotToast.showText(text: "物品ID不能为空");
    }
    if (data["chance"]!.isEmpty) {
      BotToast.showText(text: "爆率不能为空");
    }
    if (data["continent"]!.isEmpty) {
      BotToast.showText(text: "地区ID不能为空");
    }
    if (data["minimumQuantity"]!.isEmpty) {
      BotToast.showText(text: "最少不能为空");
    }
    if (data["maximumQuantity"]!.isEmpty) {
      BotToast.showText(text: "最多不能为空");
    }
    if (data["questId"]!.isEmpty) {
      BotToast.showText(text: "任务ID不能为空");
    }
    if (data["comments"]!.isEmpty) {
      BotToast.showText(text: "描述不能为空");
    }
    var value = await cashShopApi.addGameGlobal(data);
    if (value["code"] == 20000) {
      BotToast.showText(text: "新增成功");
    } else {
      BotToast.showText(text: "新增失败");
    }
  }
}
