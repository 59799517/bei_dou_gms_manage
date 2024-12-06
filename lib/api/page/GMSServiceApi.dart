import 'package:bei_dou_gms_manage/api/BaseAPI.dart';
import 'package:bei_dou_gms_manage/api/request.dart';
import 'package:flutter/material.dart';

class GMSServiceApi  {

  /// 初始化
  static GMSServiceApi? _instance;

  factory GMSServiceApi() => _instance ?? GMSServiceApi._internal();

  static GMSServiceApi? get instance => _instance ?? GMSServiceApi._internal();

  /// 初始化
  GMSServiceApi._internal() {
  }
  //查看在线状态
  Future<dynamic> getOnlineStatus() async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.getServerOnline, method: DioMethod.get);
    return result;
  }
  //启动服务
  Future<dynamic> startService() async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.startServer, method: DioMethod.get);
    return result;
  }
  //停止服务
  Future<dynamic> stopService() async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.stopServer, method: DioMethod.get);
    return result;
  }
  //重启服务
  Future<dynamic> restartService() async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.restartServer, method: DioMethod.get);
    return result;
  }
  //关闭服务
  Future<dynamic> closeService() async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.closeShutdown, method: DioMethod.get);
    return result;
  }
}
final gmsserviceApi = GMSServiceApi();
