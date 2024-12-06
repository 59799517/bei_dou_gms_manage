import 'package:bei_dou_gms_manage/api/BaseAPI.dart';
import 'package:bei_dou_gms_manage/api/request.dart';

class AccountApi{
  /// 初始化
  static AccountApi? _instance;

  factory AccountApi() => _instance ?? AccountApi._internal();

  static AccountApi? get instance => _instance ?? AccountApi._internal();

  /// 初始化
  AccountApi._internal() {
  }
//玩家列表
  Future<dynamic> getCharacterList(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.getCharacterList, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //背包类型列表
  Future<dynamic> getAllInventoryType() async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.getInventoryTypeList, method: DioMethod.get);
    return result;
  }
  //背包数据
  Future<dynamic> getInventoryData(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.getInventoryList, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //修改背包装备类型数据
  Future<dynamic> updateInventoryData(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.updateInventoryList, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //删除装备
  Future<dynamic> deleteInventoryData(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.deleteInventoryList, method: DioMethod.post,data:{"data":data});
    return result;
  }

  //获取账户列表
  Future<dynamic> getAccountList(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.getAccountList, method: DioMethod.get,params:data);
    return result;
  }
  //修改账户信息
  Future<dynamic> updateAccountData(Map<String, dynamic> data) async{
    var url = BaseAPI.baseUrl+BaseAPI.updateAccount;
    url = url.replaceAll("#{id}", data["id"].toString());
    var result = await Request().request(url, method: DioMethod.put,data:{"data":data});
    return result;
  }
  //解卡
  Future<dynamic> resetAccountData(String id) async{
    var url = BaseAPI.baseUrl+BaseAPI.resetAccount;
    url = url.replaceAll("#{id}", id);
    var result = await Request().request(url, method: DioMethod.put);
    return result;
  }
  //封停
  Future<dynamic> stopAccountData(Map<String, dynamic> data) async{
    var url = BaseAPI.baseUrl+BaseAPI.banAccount;
    url = url.replaceAll("#{id}", data["id"].toString());
    var result = await Request().request(url, method: DioMethod.put,data:{"data":data});
    return result;
  }
  //解封
  Future<dynamic> unbanAccountData(String id) async{
    var url = BaseAPI.baseUrl+BaseAPI.unbanAccount;
    url = url.replaceAll("#{id}", id);
    var result = await Request().request(url, method: DioMethod.put);
    return result;
  }
  //删除用户
  Future<dynamic> deleteAccountData(String id) async{
    var url = BaseAPI.baseUrl+BaseAPI.deleteAccount;
    url = url.replaceAll("#{id}", id);
    var result = await Request().request(url, method: DioMethod.delete);
    return result;
  }
  //添加用户
  Future<dynamic> addAccountData(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.addAccount, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //当前在线玩家列表
  Future<dynamic> onlinePlayUserData(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.onlinePlayUser, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //发送资源
  Future<dynamic> sendResourceData(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.giveresource, method: DioMethod.post,data:{"data":data});
    return result;
  }



  //获取设置类型
  Future<dynamic> getConfigTypeList() async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.getConfigTypeList, method: DioMethod.get);
    return result;
  }
  //获取设置数据列表
  Future<dynamic> getConfigList(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.getConfigList, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //修改设置数据
  Future<dynamic> updateConfigData(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.updateConfig, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //新增设置数据
  Future<dynamic> addConfigData(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.addConfig, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //删除设置数据
  Future<dynamic> deleteConfigData(List<dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.deleteConfig, method: DioMethod.post,data:{"data":data});
    return result;
  }


}

final accountApi = AccountApi();
