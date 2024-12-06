import 'package:bei_dou_gms_manage/api/BaseAPI.dart';
import 'package:bei_dou_gms_manage/api/request.dart';
import 'package:flutter/material.dart';

class LoginApi  {
  /// 单例模式
  static LoginApi? _instance;



  // 工厂函数：初始化，默认会返回唯一的实例
  factory LoginApi() => _instance ?? LoginApi._internal();

  // 用户Api实例：当访问UserApi的时候，就相当于使用了get方法来获取实例对象，如果_instance存在就返回_instance，不存在就初始化
  static LoginApi? get instance => _instance ?? LoginApi._internal();

  /// 初始化
  LoginApi._internal() {
    // 初始化基本选项
  }

  /// 登录
  Login(String username, String password) async {
    /// 开启日志打印
    Request.instance?.openLog();

    /// 发起网络接口请求
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.login, method: DioMethod.post,data: {"data":{"username": username, "password": password}});
    // 返回数据
    return result;
  }
  //登出
  Future<dynamic> logout() async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.logout, method: DioMethod.delete);
    return result;
  }
  //刷新token
  Future<dynamic> refreshToken() async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.refreshToken, method: DioMethod.get);
    return result;
  }


}
// 导出全局使用这一个实例
final userApi = LoginApi();
