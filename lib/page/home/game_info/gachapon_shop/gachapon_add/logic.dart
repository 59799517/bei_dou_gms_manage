import 'package:bei_dou_gms_manage/api/page/CashShopApi.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class GachaponAddLogic extends GetxController {
  String V_list_body_view = "list_body_view";

//添加和修改同样的 方法
  void reqAddData(Map<String, dynamic> data) async {
    if (data["gachaponId"].toString().isEmpty) {
      BotToast.showText(text: "请先输入百宝箱ID"); //popup a text toast;
    }
    if (data["name"].toString().isEmpty) {
      BotToast.showText(text: "请填写奖池名称"); //popup a text toast;
    }
    data.remove("id");
    var value = await cashShopApi.updateGachapon(data);
    if (value["code"] == 20000) {
      BotToast.showText(text: "新增成功");
    } else {
      BotToast.showText(text: "新增失败");
    }
  }
}
