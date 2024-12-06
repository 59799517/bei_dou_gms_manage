import 'package:bei_dou_gms_manage/api/page/AccountApi.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/backpack_shop/entity/BackpackEntity.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class BackpackShopLogic extends GetxController {
  //页码
  int pageNo = 1;

  //总条数接口返回判断最后一页用
  int total = 0;

  //每页条数 接口返回判断最后一页用
  int pageSize = 10;

  //页面模块名称
  String V_dropdown_main_view = "dropdown_main_view";
  String V_dropdown_status_view = "dropdown_status_view";
  String V_show_doby_view = "show_doby_view";

  // 类型列表
  Map<String, int> typeList = {};

  //默认下拉名称
  String select_name = "未定义";

  //默认下拉ID
  String inventoryType = "";

  //选择的用户ID
  String characterId = "";

  //背包数据
  List<BackpackEntity> data = [];

  Future<List<Map<String, String>>> getUserList(String user_search_text) async {
    //用户列表(ID,名称)
    List<Map<String, String>> userList = [];
    Map<String, dynamic> reqparByID = {"pageNo": "1", "pageSize": "10"};
    Map<String, dynamic> reqparBYname = {"pageNo": "1", "pageSize": "10"};
    if (user_search_text.isNotEmpty) {
      // characterId: 1, characterName: "2"
      var tryParse = int.tryParse(user_search_text);
      if (tryParse != null) {
        reqparByID["characterId"] = tryParse;
        var value = await accountApi.getCharacterList(reqparByID);
        if (value["code"] == 20000) {
          List list = value["data"]["records"];
          if (list != null && list.isNotEmpty) {
            for (var item in list) {
              userList.add({
                "name": item["characterName"].toString(),
                "id": item["characterId"].toString()
              });
            }
          }
        }
      }
    }
    reqparBYname["characterName"] = user_search_text;
    var value = await accountApi.getCharacterList(reqparBYname);
    if (value["code"] == 20000) {
      List list = value["data"]["records"];
      if (list != null && list.isNotEmpty) {
        for (var item in list) {
          userList.add({
            "name": item["characterName"].toString(),
            "id": item["characterId"].toString()
          });
        }
      }
    }
    return userList;
  }

  getDataList({bool clear = false}) async {
    if (clear) {
      pageNo = 1;
      data.clear();
    }
    if (characterId.isEmpty) {
      BotToast.showText(text: "用户未选择");
      return;
    }
    if (inventoryType.isEmpty) {
      BotToast.showText(text: "类型未选择");
      return;
    }

    Map<String, dynamic> reqpar = {
      "inventoryType": inventoryType,
      "characterId": characterId,
      "pageNo": pageNo,
      "pageSize": pageSize
    };
    var value = await accountApi.getInventoryData(reqpar);
    if (value["code"] == 20000) {
      var list = BackpackEntity.fromJsonList(value["data"]);
      data.addAll(list);
      update([V_show_doby_view]);
    }
  }

  void getTypeList() async {
    var value = await accountApi.getAllInventoryType();
    if (value["code"] == 20000) {
      for (var item in value["data"]) {
        typeList[item["name"]] = item["inventoryType"];
      }
      select_name = typeList.keys.elementAt(0);
      inventoryType = typeList[select_name].toString();
      update([V_dropdown_main_view]);
    } else {
      print("获取类型列表失败");
    }
  }

  Future reqDelete(data) async {
    var value = await accountApi.deleteInventoryData(data);
    if (value["code"] == 20000) {
      BotToast.showText(text: "删除成功");
    } else {
      BotToast.showText(text: "删除失败");
    }
  }
}
