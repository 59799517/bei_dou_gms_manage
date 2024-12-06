import 'package:bei_dou_gms_manage/api/page/CashShopApi.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/entity/GachaponEntity.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class GachaponShopLogic extends GetxController {


  //每个模块名称
  String V_show_doby_view = "show_doby_view";




  //页码
  int pageNo = 1;
  //总条数接口返回判断最后一页用
  int total = 0;
  //每页条数 接口返回判断最后一页用
  int pageSize = 20;
  // 搜索框的值
  String searchValue="";

  //显示的数据
  List<GachaponEntity> list=[];

  Future<dynamic> reqSearchList({bool clear=false}) async{
    if (clear){
      pageNo = 1;
      total= 0;
      list.clear();
    }
    Map<String, dynamic> data = {"pageNo": pageNo, "pageSize": pageSize};
    if (searchValue.isNotEmpty){
      data["gachaponId"] = searchValue;
    }
   var  value = await cashShopApi.getGachaponList(data);
      if(value["code"] == 20000){
        list.addAll(GachaponEntity.fromJsonList(value["data"]['records']));
        total = value["data"]['totalRow'];
        pageSize = value["data"]['pageSize'];
        update([V_show_doby_view]);
      }
    return value;
  }
  //删除
  Future<dynamic> reqDelete(GachaponEntity data) async{
    var  value = await cashShopApi.deleteGachapon(data.toJson());
    if(value["code"] == 20000){
      BotToast.showText(text:"删除成功");  //popup a text toast;
    }else{
      BotToast.showText(text:"删除失败");
    }
  }


}
