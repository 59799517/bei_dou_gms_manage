import 'package:bei_dou_gms_manage/api/page/AccountApi.dart';
import 'package:bei_dou_gms_manage/page/home/play_user/account/entity/AccountsEntity.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class AccountLogic extends GetxController {


  //每个模块名称
  String V_show_doby_view = "show_doby_view";

  //页码
  int pageNo = 1;

  //总条数接口返回判断最后一页用
  int total = 0;

  //每页条数 接口返回判断最后一页用
  int pageSize = 20;

  //搜索框
  String s_id="";
  String s_name="";
  String s_lastLoginStart="";
  String s_lastLoginEnd="";
  String s_createdAtStart="";
  String s_createdAtEnd="";

  List<AccountsEntity> list = [];


  Future getData({bool clear = false}) async {

    if (clear) {
      pageNo = 1;
      total = 0;
      list.clear();
    }
    Map<String, dynamic> data = {
      "page": pageNo,
      "size": pageSize,
    };
    if (s_id.isNotEmpty) {
      data["id"] = s_id;
    }
    if (s_name.isNotEmpty) {
      data["name"] = s_name;
    }
    if (s_lastLoginStart.isNotEmpty) {
      data["lastLoginStart"] = s_lastLoginStart;
    }
    if (s_lastLoginEnd.isNotEmpty) {
      data["lastLoginEnd"] = s_lastLoginEnd;
    }
    if (s_createdAtStart.isNotEmpty) {
      data["createdAtStart"] = s_createdAtStart;
    }
    if (s_createdAtEnd.isNotEmpty) {
      data["createdAtEnd"] = s_createdAtEnd;
    }

    var value = await accountApi.getAccountList(data);
    if (value["code"] == 20000) {
      list.addAll(AccountsEntity.fromJsonList(value["data"]['records']));
      total = value["data"]['totalRow'];
      pageSize = value["data"]['pageSize'];
      update([V_show_doby_view]);
    }
  }

  //解卡
  Future unLock(String id) async {
    var value = await accountApi.resetAccountData(id);
    if (value["code"] == 20000) {
      BotToast.showText(text: "解卡成功");
    }else{
      BotToast.showText(text: "解卡失败");

    }
  }
  //封禁
  Future ban(String id,String reason) async {
    Map<String, dynamic> data = {
      "id":id,
      "reason":reason
    };
    var value = await accountApi.stopAccountData(data);
    if (value["code"] == 20000) {
      BotToast.showText(text: "封禁成功");
    }else{
      BotToast.showText(text: "封禁失败");

    }
  }
  //解封
  Future unban(String id) async {
    var value = await accountApi.unbanAccountData(id);
    if (value["code"] == 20000) {
      BotToast.showText(text: "解封成功");
    }else{
      BotToast.showText(text: "解封失败");
    }
  }
  //删除
  Future delete(String id) async {
    var value = await accountApi.deleteAccountData(id);
    if (value["code"] == 20000) {
      BotToast.showText(text: "删除成功");
    }else{
      BotToast.showText(text: "删除失败");
    }
  }


}
