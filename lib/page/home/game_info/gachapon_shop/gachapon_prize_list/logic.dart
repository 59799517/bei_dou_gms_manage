import 'package:bei_dou_gms_manage/api/page/CashShopApi.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/gachapon_prize_list/entity/GachaponPrizeEntity.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class GachaponPrizeListLogic extends GetxController {

  //每个模块名称
  String V_show_doby_view = "show_doby_view";

  Map<String, dynamic> searchData = {};
  List<GachaponPrizeEntity> list=[];

  Future<dynamic> reqSearchList({bool clear=false}) async{
    if (clear){
      list.clear();
    }
    var  value = await cashShopApi.getGachaponPrizeList(searchData);
    if(value["code"] == 20000){
      list.addAll(GachaponPrizeEntity.fromJsonList(value["data"]));
      update([V_show_doby_view]);
    }
    return value;
  }
  //删除
  Future<dynamic> reqDelete(GachaponPrizeEntity data) async{
    var  value = await cashShopApi.deleteGachaponPrize(data.toJson());
    if(value["code"] == 20000){
      BotToast.showText(text:"删除成功");  //popup a text toast;
    }else{
      BotToast.showText(text:"删除失败");
    }

  }

}
