import 'package:bei_dou_gms_manage/api/page/CashShopApi.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class GachaponEditLogic extends GetxController {
  String V_list_body_view = "list_body_view";

  void reqUpdateData(Map<String, dynamic> data) async {
    var value = await cashShopApi.updateGachapon(data);
    if (value["code"] == 20000) {
      BotToast.showText(text: "修改成功");
    } else {
      BotToast.showText(text: "修改失败");
    }
  }
}
