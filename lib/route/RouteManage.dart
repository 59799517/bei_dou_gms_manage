import 'package:bei_dou_gms_manage/page/home/game_info/backpack_shop/back_pack_equip_edit/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/backpack_shop/back_pack_not_equip_edit/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/backpack_shop/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/cash_shop/cash_shop_info/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/cash_shop/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/config/config_add/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/config/config_edit/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/config/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/gachapon_add/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/gachapon_edit/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/gachapon_prize_add/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/gachapon_prize_edit/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/gachapon_prize_list/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/global_shop/global_add/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/global_shop/global_edit/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/global_shop/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/monster_shiop/monster_add/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/monster_shiop/monster_edit/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/monster_shiop/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/npc_shop/npc_shop_info_add/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/npc_shop/npc_shop_info_edit/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/npc_shop/npc_shop_inof/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/npc_shop/view.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/view.dart';
import 'package:bei_dou_gms_manage/page/home/play_user/account/account_add/view.dart';
import 'package:bei_dou_gms_manage/page/home/play_user/account/account_edit/view.dart';
import 'package:bei_dou_gms_manage/page/home/play_user/account/view.dart';
import 'package:bei_dou_gms_manage/page/home/play_user/play_user_give/view.dart';
import 'package:bei_dou_gms_manage/page/home/play_user/view.dart';
import 'package:bei_dou_gms_manage/page/home/view.dart';
import 'package:bei_dou_gms_manage/page/login/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteManage {

  static List<GetPage> routes = [
    GetPage(name: '/', page: () => LoginPage()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/home', page: () => HomePage()),
    GetPage(name: '/play/account', page: () => AccountComponent()),
    GetPage(name: '/play/user', page: () => PlayUserComponent()),
    GetPage(name: '/play/user/give', page: () => PlayUserGiveComponent()),
    GetPage(name: '/play/account/edit', page: () => AccountEditComponent()),
    GetPage(name: '/play/account/add', page: () => AccountAddComponent()),
    GetPage(name: '/game/cashshop', page: () => CashShopComponent()),
    GetPage(name: '/game/cashshop/info', page: () => CashShopInfoComponent()),
    GetPage(name: '/game/npc', page: () => NpcShopComponent()),
    GetPage(name: '/game/npc/info', page: () => NpcShopInofComponent()),
    GetPage(name: '/game/npc/info/edit', page: () => NpcShopInfoEditComponent()),
    GetPage(name: '/game/npc/info/add', page: () => NpcShopInfoAddComponent()),
    GetPage(name: '/game/monster', page: () => MonsterShiopComponent()),
    GetPage(name: '/game/monster/edit', page: () => MonsterEditComponent()),
    GetPage(name: '/game/monster/add', page: () => MonsterAddComponent()),
    GetPage(name: '/game/global', page: () => GlobalShopComponent()),
    GetPage(name: '/game/global/edit', page: () => GlobalEditComponent()),
    GetPage(name: '/game/global/add', page: () => GlobalAddComponent()),
    GetPage(name: '/game/gachapon', page: () => GachaponShopComponent()),
    GetPage(name: '/game/gachapon/edit', page: () => GachaponEditComponent()),
    GetPage(name: '/game/gachapon/add', page: () => GachaponAddComponent()),
    GetPage(name: '/game/gachapon/prize', page: () => GachaponPrizeListComponent()),
    GetPage(name: '/game/gachapon/prize/edit', page: () => GachaponPrizeEditComponent()),
    GetPage(name: '/game/gachapon/prize/add', page: () => GachaponPrizeAddComponent()),
    GetPage(name: '/game/backpack', page: () => BackpackShopComponent()),
    GetPage(name: '/game/backpack/edit/equip', page: () => BackPackEquipEditComponent()),
    GetPage(name: '/game/backpack/edit/notequip', page: () => BackPackNotEquipEditComponent()),
    GetPage(name: '/game/config', page: () => ConfigComponent()),
    GetPage(name: '/game/config/edit', page: () => ConfigEditComponent()),
    GetPage(name: '/game/config/add', page: () => ConfigAddComponent()),
    GetPage(name: '/game', page: () => GameInfoComponent()),

  ];
  static Widget defaultPage =  LoginPage();

}
