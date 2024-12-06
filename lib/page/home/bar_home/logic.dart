import 'package:bei_dou_gms_manage/api/page/GMSServiceApi.dart';
import 'package:get/get.dart';

class BarHomeLogic extends GetxController {
//每个模块名称
  String V_Online_view = "Online_view";
  //是否在线
  bool online = false;

  @override
  void onInit() {
    super.onInit();
    getOnlineStatus();
  }

  @override
  void onReady() {
    super.onReady();
    getOnlineStatus();
  }

  @override
  void onClose() {
    super.onClose();
  }


  //获取在线状态
  Future<dynamic> getOnlineStatus() async{
    try {
      var result = await gmsserviceApi.getOnlineStatus();
      if(result["code"]==20000){
            online =  result["data"];
            update([V_Online_view]);
          }
    } catch (e) {
      online = false;
      update([V_Online_view]);
    }
  }
  //启动服务
  Future<dynamic> startService() async{
    var result = await gmsserviceApi.startService();
    if(result["code"]==20000){
      getOnlineStatus();
      update([V_Online_view]);
    }
  }
  //停止服务
  Future<dynamic> stopService() async{
    var result = await gmsserviceApi.stopService();
    if(result["code"]==20000){
      getOnlineStatus();
      update([V_Online_view]);
    }
  }
  //重启服务
  Future<dynamic> restartService() async{
    var result = await gmsserviceApi.restartService();
    if(result["code"]==20000){
      getOnlineStatus();
      update([V_Online_view]);
    }
  }
  //关闭服务
  Future<dynamic> closeService() async{
    var result = await gmsserviceApi.closeService();
    if(result["code"]==20000){
      getOnlineStatus();
      update([V_Online_view]);
    }
  }
}
