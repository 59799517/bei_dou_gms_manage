import 'package:bei_dou_gms_manage/page/home/game_info/npc_shop/logic.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/npc_shop/npc_shop_info_edit/logic.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/npc_shop/npc_shop_inof/entity/NPCShopInfoEntity.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/npc_shop/npc_shop_inof/logic.dart';

class NpcShopInfoEditComponent extends StatefulWidget {
  @override
  State<NpcShopInfoEditComponent> createState() =>
      _NpcShopInfoEditComponentState();
}

class _NpcShopInfoEditComponentState extends State<NpcShopInfoEditComponent> {
  final NpcShopInfoEditLogic logic = Get.put(NpcShopInfoEditLogic());

  final Npc_shopLogic npc_shoplogic = Get.put(Npc_shopLogic());
  final NpcShopInofLogic npcshopinoflogic = Get.put(NpcShopInofLogic());

  String appBarTitle = "NPC 商店编辑";
  Map<String, dynamic> data = Get.arguments;

  @override
  void initState() {
    super.initState();
    appBarTitle = data["name"];
  }

  @override
  dispose() {
    super.dispose();
    npc_shoplogic.reqSearchNpcList(clear: true);
    npcshopinoflogic.reqSearchNpcInfoList(clear: true);
  }

  _showDialog(String title, String keyName,
      {defaultValue = "",
      BuildContext? context,
      String subTitle = "",
      WidgetType type = WidgetType.input,
      InputType inputType = InputType.number}) {
    WidgetUtils.showDialog(title, keyName, (value) {
      if (type == WidgetType.input) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = NPCShopInfoEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdatedata(json);
        logic.update([logic.V_list_body_view]);
      } else if (type == WidgetType.date) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = NPCShopInfoEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdatedata(json);
        logic.update([logic.V_list_body_view]);
      } else if (type == WidgetType.toggle) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = NPCShopInfoEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdatedata(json);
        logic.update([logic.V_list_body_view]);
      } else if (type == WidgetType.sex) {
        var json = data["data"]!.toJson();
        if (value == "男") {
          value = "0";
        } else if (value == "女") {
          value = "1";
        } else if (value == "通用") {
          value = "2";
        }
        json[keyName] = value;
        var pushdata = NPCShopInfoEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdatedata(json);
        logic.update([logic.V_list_body_view]);
      } else if (type == WidgetType.slider) {
        var json = data["data"]!.toJson();
        json[keyName] = (double.parse(value) * 1000).toStringAsFixed(0);
        var pushdata = NPCShopInfoEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdatedata(json);
        logic.update([logic.V_list_body_view]);
      }
    },
        context: context,
        defaultValue: defaultValue,
        subTitle: subTitle,
        type: type,
        inputType: inputType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: GetBuilder<NpcShopInfoEditLogic>(
          id: logic.V_list_body_view,
          builder: (logic) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    child: Card(
                        elevation: 8.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 70,
                                height: 70,
                                child: Image(
                                  image: NetworkImage(MSImageUtils.getIconUrl(
                                    category: "item",
                                    itemId: data["data"]!.itemId,
                                  )),
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                        Symbols.error_circle_rounded);
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(data["data"]!.itemName),
                              Text("商店ID:${data["data"]!.shopId.toString()}"),
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                      child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(children: [
                          SQListTile(
                            titleText: "ID",
                            subTitleText: data["data"]!.id.toString(),
                          ),
                          SQListTile(
                              titleText: "物品Id",
                              subTitleText: data["data"]!.itemId.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("物品Id", "itemId",
                                    defaultValue:
                                        data["data"]!.itemId.toString());
                              }),
                          SQListTile(
                              titleText: "价格",
                              subTitleText: data["data"]!.price.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("价格", "price",
                                    defaultValue:
                                        data["data"]!.price.toString());
                              }),
                          SQListTile(
                              titleText: "音符",
                              subTitleText: data["data"]!.pitch.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("音符", "pitch",
                                    defaultValue:
                                        data["data"]!.pitch.toString());
                              }),
                          SQListTile(
                              titleText: "位置",
                              subTitleText: data["data"]!.position.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("位置", "position",
                                    defaultValue:
                                        data["data"]!.position.toString());
                              }),
                          SQListTile(
                            titleText: "描述",
                            subTitleText: data["data"]!.itemDesc.toString(),
                          ),
                        ]),
                      )
                    ],
                  )),
                ),
              ],
            );
          }),
    );
  }
}
