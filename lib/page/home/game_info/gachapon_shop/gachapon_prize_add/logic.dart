import 'package:bei_dou_gms_manage/api/page/CashShopApi.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class GachaponPrizeAddLogic extends GetxController {
  String V_list_body_view = "list_body_view";

  Future reqAddData(Map<String, dynamic> data) async {
    if (data["itemId"].toString().isEmpty) {
      BotToast.showText(text: "请先输入物品ID");
    } else if (data["quantity"].toString().isEmpty) {
      BotToast.showText(text: "请输入数量");
    } else if (data["poolId"].toString().isEmpty) {
      BotToast.showText(text: "扭蛋机ID为空请重新进入该页面");
    }
    var value = await cashShopApi.updateGachaponPrize(data);
    if (value["code"] == 20000) {
      BotToast.showText(text: "添加成功");
    } else {
      BotToast.showText(text: value["msg"]);
    }
  }
}
