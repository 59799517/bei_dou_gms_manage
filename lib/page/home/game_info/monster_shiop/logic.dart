import 'package:bei_dou_gms_manage/api/page/CashShopApi.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/monster_shiop/entity/MonsterEntity.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class MonsterShiopLogic extends GetxController {
  //每个模块名称
  String V_show_doby_view = "show_doby_view";

  //页码
  int pageNo = 1;

  //总条数接口返回判断最后一页用
  int total = 0;

  //每页条数 接口返回判断最后一页用
  int pageSize = 20;

  //搜索框值
  String dropperId = "";
  String itemId = "";
  String questId = "";

  // 页面显示数值
  List<MonsterEntity> monsterList = [];

  void reqSearcMonsterList({bool clear = false}) async {
    if (clear) {
      pageNo = 1;
      total = 0;
      monsterList.clear();
    }
    var data = {
      "pageNo": pageNo,
      "pageSize": pageSize,
      "onlyTotal": false,
      "notPage": false
    };
    if (dropperId.isNotEmpty) {
      data["dropperId"] = dropperId;
    }
    if (itemId.isNotEmpty) {
      data["itemId"] = itemId;
    }
    if (questId.isNotEmpty) {
      data["questId"] = questId;
    }
    cashShopApi.searchMonsterList(data).then((value) => {
          if (value["code"] == 20000)
            {
              monsterList
                  .addAll(MonsterEntity.fromJsonList(value["data"]['records'])),
              total = value["data"]['totalRow'],
              pageSize = value["data"]['pageSize'],
              update([V_show_doby_view])
            }
        });
  }

  Future reqDeleteMonster(String id) async {
    var value = await cashShopApi.deleteMonster(id);
    if (value["code"] == 20000) {
      BotToast.showText(text: "删除成功");
    } else {
      BotToast.showText(text: "删除失败");
    }
  }
}
