import 'package:bei_dou_gms_manage/page/home/game_info/backpack_shop/back_pack_not_equip_edit/logic.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/backpack_shop/entity/BackpackEntity.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

class BackPackNotEquipEditComponent extends StatefulWidget {
  @override
  State<BackPackNotEquipEditComponent> createState() =>
      _BackPackNotEquipEditComponentState();
}

class _BackPackNotEquipEditComponentState
    extends State<BackPackNotEquipEditComponent> {


  final BackPackNotEquipEditLogic logic = Get.put(BackPackNotEquipEditLogic());
  String appBarTitle = "背包编辑";
  Map<String, dynamic> data = Get.arguments;


  _showDialog(String title, String keyName,{defaultValue="",BuildContext? context,String subTitle="",WidgetType type=WidgetType.input,InputType inputType=InputType.number}) {
    WidgetUtils.showDialog(title, keyName, (value){
      if (type == WidgetType.input) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = BackpackEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdatedata(json);
        logic.update([logic.V_list_body_view]);
      }else if (type == WidgetType.date) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = BackpackEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdatedata(json);
        logic.update([logic.V_list_body_view]);
      }else if (type == WidgetType.toggle) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = BackpackEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdatedata(json);
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
        var pushdata = BackpackEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdatedata(json);
        logic.update([logic.V_list_body_view]);
      }else if (type == WidgetType.slider) {
        var json = data["data"]!.toJson();
        json[keyName] = (double.parse(value)*1000).toStringAsFixed(0);
        var pushdata = BackpackEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdatedata(json);
        logic.update([logic.V_list_body_view]);
      }
    }, context: context,defaultValue:defaultValue, subTitle:subTitle,type: type,inputType: inputType);
  }



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: GetBuilder< BackPackNotEquipEditLogic>( id: logic.V_list_body_view, builder: (logic) {
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
                            data["data"]!.itemId==0?
                            Image(
                              image: NetworkImage("https://maplestory.io/api/GMS/83/item/5200002/icon"),
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                    Symbols.error_circle_rounded);
                              }, fit: BoxFit.cover,)
                                : Image(
                              image: NetworkImage(MSImageUtils.getIconUrl(
                                category: "item",
                                itemId:
                                data["data"]!.itemId,
                              )),
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                    Symbols.error_circle_rounded);
                              }, fit: BoxFit.cover,),
                          ),
                          // Text(data["data"]!.dropperName),
                          Text("物品名称:${data["data"]!.itemId==0?"金币":data["data"]!.itemName}"),

                          //
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
                                titleText: "ID",
                                subTitleText: data["data"]!.id.toString(),
                              ),
                              SQListTile(
                                titleText: "角色ID",
                                subTitleText: data["data"]!.characterId.toString(),
                              ),
                              SQListTile(
                                titleText: "在线",
                                subTitleText: data["data"]!.online?"是":"否",
                              ),
                              SQListTile(
                                titleText: "物品ID",
                                subTitleText: data["data"]!.itemId.toString(),
                              ),
                              SQListTile(
                                titleText: "位置",
                                subTitleText: data["data"]!.itemType.toString(),
                              ),
                              SQListTile(
                                titleText: "类型",
                                subTitleText: data["data"]!.position.toString(),
                              ),
                              SQListTile(
                                  titleText: "数量",
                                  subTitleText: data["data"]!.quantity.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("可升级次数", "quantity",defaultValue: data["data"]!.quantity.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "签名（owner）",
                                  subTitleText: data["data"]!.owner.toString(),

                              ),
                              SQListTile(
                                  titleText: "宠物ID",
                                  subTitleText: data["data"]!.petId.toString(),

                              ),
                              SQListTile(
                                  titleText: "标记（flag）",
                                  subTitleText: data["data"]!.flag.toString(),
                              ),
                              SQListTile(
                                  titleText: "赠送人",
                                  subTitleText: data["data"]!.giftFrom.toString(),
                              ),
                              SQListTile(
                                  titleText: "到期时间",
                                  subTitleText: data["data"]!.expiration==-1?"永久":formatDate(DateTime.fromMillisecondsSinceEpoch(int.parse(data["data"]!.expiration.toString())), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("到期时间", "expiration",defaultValue: data["data"]!.expiration.toString(),subTitle: "-1为永久",type: WidgetType.input,inputType: InputType.date);
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
