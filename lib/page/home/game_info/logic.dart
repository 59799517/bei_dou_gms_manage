import 'package:bei_dou_gms_manage/page/home/game_info/GameGridView.dart';
import 'package:get/get.dart';

class GameInfoLogic extends GetxController {
  final List<GameGridView> gridViewList = [
    GameGridView("商城管理","game_info_mall.png","/game/cashshop",),
    GameGridView("NPC管理","game_info_npc.png","/game/npc"),
    GameGridView("怪物爆率","game_info_monster.png","/game/monster"),
    GameGridView("全局爆率","game_info_scroll.png","/game/global"),
    GameGridView("背包管理","game_info_bag.png","/game/backpack"),
    GameGridView("百宝箱","game_info_gachapon.png","/game/gachapon"),
    GameGridView("参数管理","game_info_config.png","/game/config")
  ];
}
