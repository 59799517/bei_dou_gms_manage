import 'package:bei_dou_gms_manage/api/page/AccountApi.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class AccountAddLogic extends GetxController {
  String V_list_body_view = "list_body_view";


  Future addAccountData( Map<String, dynamic> data) async{
    if (data["password"] != data["checkPassword"]) {
      BotToast.showText(text: "两次密码不一致");
      return;
    }
    if (data["name"].isEmpty|| data["name"].length < 6) {
      BotToast.showText(text: "账号名称最小6位以上");
      return;
    }
    if ( data["password"].isEmpty|| data["password"].length < 6) {
      BotToast.showText(text: "密码最小6位以上");
      return;
    }
    if (!(data["language"].toString()=="2"|| data["language"].toString()=="3")) {
      BotToast.showText(text: "请选择语言");
      return;
    }
    if (data["birthday"].isEmpty) {
      BotToast.showText(text: "请选择生日");
      return;
    }

    var value = await accountApi.addAccountData(data);
    if (value["code"] == 20000) {
      BotToast.showText(text: "创建成功");
    } else {
      BotToast.showText(text: "创建失败");
    }
  }
}
