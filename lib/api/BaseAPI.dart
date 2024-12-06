import 'package:flutter/material.dart';

class BaseAPI {

  static const String baseUrl = "http://100.122.250.55:8686";
  //登录
  static const String login =  "/auth/v1/login";
  //登出
  static const String logout =  "/auth/v1/logout";
  //刷新token
  static const String refreshToken =  "/auth/v1/refreshToken";
  //服务器在线情况
  static const String getServerOnline =  "/server/v1/online";
  //启动服务
  static const String startServer =  "/server/v1/startServer";
  //停止服务
  static const String stopServer =  "/server/v1/stopServer";
  //重启服务
  static const String restartServer =  "/server/v1/restartServer";
  //关闭服务
  static const String closeShutdown =  "/server/v1/shutdown";

  //搜索
  static const String informationSearch =  "/common/v1/informationSearch";
  //游戏类型（商城）
  static const String getAllCategoryList =  "/cashShop/v1/getAllCategoryList";
  //查询数据
  static const String getCommodityByCategory =  "/cashShop/v1/getCommodityByCategory";
  //游戏类型（商城）修改数据用
  static const String updataeOnSale =  "/cashShop/v1/onSale";

  static const String updataeOffSale =  "/cashShop/v1/offSale";
  //游戏类型（NPC）
  static const String getAllNpcCategoryList =  "/shop/v1/getShopList";
  //游戏类型（NPC）商店物品详情
  static const String getAllNpcgetShopItemList =  "/shop/v1/getShopItemList";
  //修改游戏类型（NPC）商店物品详情
  static const String updateNpcgetShopItemList =  "/shop/v1/updateShopItem";
  //删除游戏类型（NPC）商店物品详情
  static const String deleteNpcgetShopItemList =  "/shop/v1/deleteShopItem/#{id}";
  //增加游戏类型NPC物品
  static const String addNpcgetShopItemList =  "/shop/v1/addShopItem";
  //游戏类型（怪物）
  static const String getAllDropList =  "/drop/v1/getDropList";
  //游戏类型（怪物）修改
  static const String updateDrop =  "/drop/v1/updateDropData";
  //游戏类型（怪物）增加
  static const String addDrop =  "/drop/v1/addDropData";
  //游戏类型（怪物）删除
  static const String deleteDrop =  "/drop/v1/deleteDropData/#{id}";
  //游戏全局爆率
  static const String getallGlobalDropList =  "/drop/v1/getGlobalDropList";
  //游戏全局爆率修改
  static const String updateGlobalDropList =  "/drop/v1/updateGlobalDropData";
  //游戏全局爆率新增
  static const String addGlobalDropList =  "/drop/v1/addGlobalDropData";
  //游戏全局爆率删除
  static const String deleteGlobalDropList =  "/drop/v1/deleteGlobalDropData/#{id}";
  //游戏扭蛋机
  static const String getAllGachaponList =  "/gachapon/v1/getPools";
  //游戏扭蛋机修改（或者创建）
  static const String updateGachaponList =  "/gachapon/v1/updatePool";
  //游戏扭蛋机新增
  static const String addGachaponList =  "/gachapon/v1/addPool";
  //游戏扭蛋机删除
  static const String deleteGachaponList =  "/gachapon/v1/deletePool";
  //扭蛋机奖品列表
  static const String getGachaponPrizeList =  "/gachapon/v1/getRewards";
  //扭蛋机奖品列表修改
  static const String updateGachaponPrizeList =  "/gachapon/v1/updateReward";
  //扭蛋奖品删除
  static const String deleteGachaponPrizeList =  "/gachapon/v1/deleteReward";
  //玩家列表
  static const String getCharacterList =  "/inventory/v1/getCharacterList";
  //玩家列表背包类型
  static const String getInventoryTypeList =  "/inventory/v1/getInventoryTypeList";
  //背包数据查询
  static const String getInventoryList =  "/inventory/v1/getInventoryList";
  //背包修改装备类型数据
  static const String updateInventoryList =  "/inventory/v1/updateInventory";
  //背包修改非装备类型数据
  static const String updateInventoryItemList =  "/inventory/v1/updateInventory";
  //背包删除数据
  static const String deleteInventoryList =  "/inventory/v1/deleteInventory";
  //游戏设置类型
  static const String getConfigTypeList =  "/config/v1/getConfigTypeList";
  //游戏设置列表
  static const String getConfigList =  "/config/v1/getConfigList";
  //游戏设置修改
  static const String updateConfig =  "/config/v1/updateConfig";
  //游戏设置新增
  static const String addConfig =  "/config/v1/addConfig";
  //游戏设置删除
  static const String deleteConfig =  "/config/v1/deleteConfigList";


  //账户列表
  static const String getAccountList =  "/account/v1";
  //修改账户信息
  static const String updateAccount =  "/account/v1/#{id}";
  //解卡
  static const String resetAccount =  "/account/v1/#{id}/reset/logged";
  //封卡
  static const String banAccount =  "/account/v1/#{id}/ban";
  //解封
  static const String unbanAccount =  "/account/v1/#{id}/unban";
  //删除账户
  static const String deleteAccount =  "/account/v1/#{id}";
  //添加账户
  static const String addAccount =  "/account/v1";
  //在线列表
  static const String onlinePlayUser =  "/character/v1/online/list";
  //发放奖励
  static const String giveresource =  "/give/v1/resource";







}
