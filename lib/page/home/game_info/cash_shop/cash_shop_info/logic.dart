import 'package:bei_dou_gms_manage/api/page/CashShopApi.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class CashShopInfoLogic extends GetxController {
  String V_list_body_view = "list_body_view";

  ///false是下架 true 是上架
  void reqUpdatedata(Map<String, dynamic> data, {onSale = true}) async {
    if (onSale) {
      var value = await cashShopApi.updateCashShopInfoOnSale(data);
      if (value["code"] == 20000) {
        BotToast.showText(text: "修改成功");
      } else {
        BotToast.showText(text: "修改失败");
      }
    } else {
      var value = await cashShopApi.updateCashShopInfoOffSale(data);
      if (value["code"] == 20000) {
        BotToast.showText(text: "修改成功");
      } else {
        BotToast.showText(text: "修改失败");
      }
    }
  }
}
