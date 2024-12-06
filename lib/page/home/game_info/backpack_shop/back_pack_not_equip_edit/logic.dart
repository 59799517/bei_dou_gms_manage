import 'package:bei_dou_gms_manage/api/page/AccountApi.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class BackPackNotEquipEditLogic extends GetxController {
  String V_list_body_view = "list_body_view";

  Future reqUpdatedata(data) async {
    var value = await accountApi.updateInventoryData(data);
    if (value["code"] == 20000) {
      BotToast.showText(text: "修改成功");
    } else {
      BotToast.showText(text: "修改失败");
    }
  }
}
