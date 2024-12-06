import 'package:bei_dou_gms_manage/api/BaseAPI.dart';
import 'package:bei_dou_gms_manage/api/request.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/cash_shop/entity/CategoryInfoReqPar.dart';
import 'package:flutter/material.dart';

class CashShopApi  {

  /// 初始化
  static CashShopApi? _instance;

  factory CashShopApi() => _instance ?? CashShopApi._internal();

  static CashShopApi? get instance => _instance ?? CashShopApi._internal();

  /// 初始化
  CashShopApi._internal() {
  }

  ///获取类型
  Future<dynamic> getCashShopType() async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.getAllCategoryList, method: DioMethod.get);
    return result;
  }
  //根据类型查询数据
  Future<dynamic> getCashShopInfo(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.getCommodityByCategory, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //修改数据（上架）
  Future<dynamic> updateCashShopInfoOnSale(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.updataeOnSale, method: DioMethod.post,data:{"data":data});
    return result;
  }

  //修改数据（下架）
  Future<dynamic> updateCashShopInfoOffSale(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.updataeOnSale, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //搜索npc数据
  Future<dynamic> searchNpcList(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.getAllNpcCategoryList, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //搜索NPC详情数据
  Future<dynamic> searchNpcInfoList(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.getAllNpcgetShopItemList, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //修改NPC物品数据
  Future<dynamic> updateNpcItem(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.updateNpcgetShopItemList, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //增加NPC物品数据
  Future<dynamic> addNpcItem(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.addNpcgetShopItemList, method: DioMethod.put,data:{"data":data});
    return result;
  }
  //删除NPC物品数据
  Future<dynamic> deleteNpcItem(String data) async{
   String url =  BaseAPI.deleteNpcgetShopItemList.replaceAll("#{id}", data);
    var result = await Request().request(BaseAPI.baseUrl+url, method: DioMethod.delete);
    return result;
  }
  //搜索怪物数据
  Future<dynamic> searchMonsterList(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.getAllDropList, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //修改怪物数据
  Future<dynamic> updateMonster(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.updateDrop, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //增加怪物数据
  Future<dynamic> addMonster(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.addDrop, method: DioMethod.put,data:{"data":data});
    return result;
  }
  //删除怪物数据
  Future<dynamic> deleteMonster(String data) async{
    String url =  BaseAPI.deleteDrop.replaceAll("#{id}", data);
    var result = await Request().request(BaseAPI.baseUrl+url, method: DioMethod.delete);
    return result;
  }
  //查询游戏全局信息
  Future<dynamic> getGameGlobalList(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.getallGlobalDropList, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //修改游戏全局信息
  Future<dynamic> updateGameGlobal(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.updateGlobalDropList, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //增加游戏全局信息
  Future<dynamic> addGameGlobal(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.addGlobalDropList, method: DioMethod.put,data:{"data":data});
    return result;
  }
  //删除游戏全局信息
  Future<dynamic> deleteGameGlobal(String data) async{
    String url =  BaseAPI.deleteGlobalDropList.replaceAll("#{id}", data);
    var result = await Request().request(BaseAPI.baseUrl+url, method: DioMethod.delete);
    return result;
  }
  //扭蛋列表查询（百宝箱）
  Future<dynamic> getGachaponList(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.getAllGachaponList, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //扭蛋修改
  Future<dynamic> updateGachapon(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.updateGachaponList, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //扭蛋删除
  Future<dynamic> deleteGachapon(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.deleteGachaponList, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //扭蛋机奖品列表查询
  Future<dynamic> getGachaponPrizeList(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.getGachaponPrizeList, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //扭蛋机奖品修改和新增
  Future<dynamic> updateGachaponPrize(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.updateGachaponPrizeList, method: DioMethod.post,data:{"data":data});
    return result;
  }
  //扭蛋机奖品删除
  Future<dynamic> deleteGachaponPrize(Map<String, dynamic> data) async{
    var result = await Request().request(BaseAPI.baseUrl+BaseAPI.deleteGachaponPrizeList, method: DioMethod.post,data:{"data":data});
    return result;
  }



}
final cashShopApi = CashShopApi();
