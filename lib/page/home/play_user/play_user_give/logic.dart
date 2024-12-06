import 'package:bei_dou_gms_manage/api/page/AccountApi.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class PlayUserGiveLogic extends GetxController {
  String V_list_body_view = "list_body_view";
  String V_dropdown_main_view = "dropdown_main_view";

  String type_select = "点券";

  int give_number = 0;
  // 1012057
  Map<String, dynamic> pushdata = {"type":0};
  Map<String, dynamic> default_data = {"str":0,"dex":0,"int":0,"luk":0,"hp":0,"mp":0,"pAtk":0,"mAtk":0,"pDef":0,"mDef":0,"acc":0,"avoid":0,"hands":0,"speed":0,"jump":0,"upgradeSlot":0,"expire":-1};


  List<int> global_Type_value = [0,1,2,3,4,5,6];
  List<int> quantity_type_value = [0,1,2,3,4,5,7,8,9,11,12];


  //下拉类型
  Map<String, int> type = {
    "点券":0,
    "信用点券":1,
    "抵用券":2,
    "金币":3,
    "经验":4,
    "道具":5,
    "自定义装备":6,
    "经验倍率":7,
    "金币倍率":8,
    "爆率":9,
    "GM等级":11,
    "人气":12
  };


  Map<String, int> global_type = {
    "点券":0,
    "信用点券":1,
    "抵用券":2,
    "金币":3,
    "经验":4,
    "道具":5,
    "自定义装备":6
  };



  String getPushData(String key){
    var resd =  pushdata[key] ==null? "":default_data[key];
    if(resd==null||resd==""){
      return "0";
    }
    return resd.toString();
  }
//发送资源 sendResourceData


  void giveresource() async {
    if (pushdata["playerId"]==null||pushdata["playerId"]=="") {
      BotToast.showText(text: "请选择一个玩家或者全部");
      return;
    }
    if (quantity_type_value.contains(type[type_select])&&int.parse(pushdata["quantity"])<=0) {
      BotToast.showText(text: "数量应该大于0");
      return;
    }
    if (type[type_select]==5||type[type_select]==6) {
      if (pushdata["id"]==null||pushdata["id"]=="") {
        BotToast.showText(text: "必须输入一个物品ID");
        return;
      }
    }
    if (type[type_select]==6) {
      var keys = default_data.keys;
      for (var key in keys) {
        if (pushdata[key]==null||pushdata[key]=="") {
          (pushdata[key]= default_data[key].toString());
        }
      }

    }
    var  value = await accountApi.sendResourceData(pushdata);
    if (value["code"] == 20000) {
      BotToast.showText(text: "发放成功");
    }else{
      BotToast.showText(text: "发放失败：${value["message"]}");
    }
  }

}
