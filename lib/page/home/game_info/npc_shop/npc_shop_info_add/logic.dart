import 'package:bei_dou_gms_manage/api/page/CashShopApi.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class NpcShopInfoAddLogic extends GetxController {
  String V_list_body_view = "list_body_view";

  void reqAddData(Map<String, dynamic> data) async {
    var value = await cashShopApi.addNpcItem(data);
    if (value["code"] == 20000) {
      BotToast.showText(text: "添加成功");
    } else {
      BotToast.showText(text: "添加失败");
    }
  }
}
