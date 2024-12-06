import 'package:bei_dou_gms_manage/page/home/game_info/backpack_shop/back_pack_equip_edit/logic.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/backpack_shop/entity/BackpackEntity.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/backpack_shop/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

class BackPackEquipEditComponent extends StatefulWidget {
  @override
  State<BackPackEquipEditComponent> createState() =>
      _BackPackEquipEditComponentState();
}

class _BackPackEquipEditComponentState
    extends State<BackPackEquipEditComponent> {
  final BackPackEquipEditLogic logic = Get.put(BackPackEquipEditLogic());
  final BackpackShopLogic backpackshoplogic = Get.put(BackpackShopLogic());


  String appBarTitle = "背包编辑";
  Map<String, dynamic> data = Get.arguments;

  @override
  void initState() {
    super.initState();
  }
  @override
  dispose() {
    super.dispose();
    backpackshoplogic.getDataList(clear: true);
  }

  _showDialog(String title, String keyName,{defaultValue="",BuildContext? context,String subTitle="",WidgetType type=WidgetType.input,InputType inputType=InputType.number}) {
    WidgetUtils.showDialog(title, keyName, (value){
      if (type == WidgetType.input) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = InventoryEquipRtnDTO.fromJson(json);
        data["data"] = pushdata;
        var json2 = data["src"].toJson();
        json2["inventoryEquipment"] = json;
        logic.reqUpdatedata(json2);
        logic.update([logic.V_list_body_view]);
      }else if (type == WidgetType.date) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = InventoryEquipRtnDTO.fromJson(json);
        data["data"] = pushdata;
        var json2 = data["src"].toJson();
        json2["inventoryEquipment"] = json;
        logic.reqUpdatedata(json2);
        logic.update([logic.V_list_body_view]);
      }else if (type == WidgetType.toggle) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = InventoryEquipRtnDTO.fromJson(json);
        data["data"] = pushdata;
        var json2 = data["src"].toJson();
        json2["inventoryEquipment"] = json;
        logic.reqUpdatedata(json2);
        logic.update([logic.V_list_body_view]);
      }else if (type == WidgetType.sex) {
        var json = data["data"]!.toJson();
        if( value=="男"){
          value="0";
        }else if( value=="女"){
          value="1";
        }else if( value=="通用"){
          value="2";
        }
        json[keyName] = value;
        var pushdata = InventoryEquipRtnDTO.fromJson(json);
        data["data"] = pushdata;
        var json2 = data["src"].toJson();
        json2["inventoryEquipment"] = json;
        logic.reqUpdatedata(json2);
        logic.update([logic.V_list_body_view]);
      }else if (type == WidgetType.slider) {
        var json = data["data"]!.toJson();
        json[keyName] = (double.parse(value)*1000).toStringAsFixed(0);
        var pushdata = InventoryEquipRtnDTO.fromJson(json);
        data["data"] = pushdata;
        var json2 = data["src"].toJson();
        json2["inventoryEquipment"] = json;
        logic.reqUpdatedata(json2);
        logic.update([logic.V_list_body_view]);
      }
    }, context: context,defaultValue:defaultValue, subTitle:subTitle,type: type,inputType: inputType);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: GetBuilder< BackPackEquipEditLogic>( id: logic.V_list_body_view, builder: (logic) {
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
                            child:
                            data["data"]!.inventoryItemId==0?
                            Image(
                              image: NetworkImage("https://maplestory.io/api/GMS/83/item/5200002/icon"),
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                    Symbols.error_circle_rounded);
                              }, fit: BoxFit.cover,)
                                : Image(
                              image: NetworkImage(MSImageUtils.getIconUrlofIteamString(
                                category: "item",
                                itemId:
                                data["iteamID"].toString(),
                              )),
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                    Symbols.error_circle_rounded_rounded);
                              }, fit: BoxFit.cover,),
                          ),
                        ],
                      ),
                    )
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                            children: [
                              SQListTile(
                                titleText: "装备表ID",
                                subTitleText: data["data"]!.id.toString(),
                              ),
                              SQListTile(
                                  titleText: "物品表ID",
                                  subTitleText: data["data"]!.inventoryItemId.toString(),
                              ),
                              SQListTile(
                                  titleText: "可升级次数",
                                  subTitleText: data["data"]!.upgradeSlots.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("可升级次数", "upgradeSlots",defaultValue: data["data"]!.upgradeSlots.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "升级次数",
                                  subTitleText: data["data"]!.level.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("升级次数", "level",defaultValue: data["data"]!.level.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "力量",
                                  subTitleText: data["data"]!.attStr.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("力量", "attStr",defaultValue: data["data"]!.attStr.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "敏捷",
                                  subTitleText: data["data"]!.attDex.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("敏捷", "attDex",defaultValue: data["data"]!.attDex.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "智力",
                                  subTitleText: data["data"]!.attInt.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("智力", "attInt",defaultValue: data["data"]!.attInt.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "运气",
                                  subTitleText: data["data"]!.attLuk.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("运气", "attLuk",defaultValue: data["data"]!.attLuk.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "血量（HP）",
                                  subTitleText: data["data"]!.hp.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("血量（HP）", "hp",defaultValue: data["data"]!.hp.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "蓝量（MP）",
                                  subTitleText: data["data"]!.mp.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("蓝量（MP）", "mp",defaultValue: data["data"]!.mp.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "物理攻击",
                                  subTitleText: data["data"]!.pAtk.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("物理攻击", "pAtk",defaultValue: data["data"]!.pAtk.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "魔法攻击",
                                  subTitleText: data["data"]!.mAtk.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("魔法攻击", "mAtk",defaultValue: data["data"]!.mAtk.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "物理防御",
                                  subTitleText: data["data"]!.pDef.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("物理防御", "pDef",defaultValue: data["data"]!.pDef.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "魔法防御",
                                  subTitleText: data["data"]!.mDef.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("魔法防御", "mDef",defaultValue: data["data"]!.mDef.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "命中",
                                  subTitleText: data["data"]!.acc.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("命中", "acc",defaultValue: data["data"]!.acc.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "回避",
                                  subTitleText: data["data"]!.avoid.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("回避", "avoid",defaultValue: data["data"]!.avoid.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "攻速",
                                  subTitleText: data["data"]!.hands.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("攻速", "hands",defaultValue: data["data"]!.hands.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "移速",
                                  subTitleText: data["data"]!.speed.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("移速", "speed",defaultValue: data["data"]!.speed.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "跳跃力",
                                  subTitleText: data["data"]!.jump.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("跳跃力", "jump",defaultValue: data["data"]!.jump.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "锁定",
                                  subTitleText: data["data"]!.locked.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("锁定", "locked",defaultValue: data["data"]!.locked.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "锤子次数",
                                  subTitleText: data["data"]!.vicious.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("锤子次数", "vicious",defaultValue: data["data"]!.vicious.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "装备升级等级(道具等级)",
                                  subTitleText: data["data"]!.itemLevel.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("装备升级等级(道具等级)", "itemLevel",defaultValue: data["data"]!.itemLevel.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "装备升级经验(道具经验)",
                                  subTitleText: data["data"]!.itemExp.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("装备升级经验(道具经验)", "itemExp",defaultValue: data["data"]!.itemExp.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "戒指id",
                                  subTitleText: data["data"]!.ringId.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("戒指id", "ringId",defaultValue: data["data"]!.ringId.toString());
                                  }
                              ),
                            ]
                        ),
                      )
                    ],
                  )
              ),
            ),
          ],
        );
      }),


    );
  }
}
