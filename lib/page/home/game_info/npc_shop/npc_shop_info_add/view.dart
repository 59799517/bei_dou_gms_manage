import 'package:bei_dou_gms_manage/page/home/game_info/npc_shop/logic.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/npc_shop/npc_shop_info_add/logic.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/npc_shop/npc_shop_inof/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_symbols_icons/symbols.dart';

class NpcShopInfoAddComponent extends StatefulWidget {
  @override
  State<NpcShopInfoAddComponent> createState() =>
      _NpcShopInfoAddComponentState();
}

class _NpcShopInfoAddComponentState extends State<NpcShopInfoAddComponent> {
  final NpcShopInfoAddLogic logic = Get.put(NpcShopInfoAddLogic());
  final Npc_shopLogic npc_shoplogic = Get.put(Npc_shopLogic());
  final NpcShopInofLogic npcshopinoflogic = Get.put(NpcShopInofLogic());
  String appBarTitle = "NPC商店新增物品";
  Map<String, dynamic> data = {"id":"-1","shopId":"0","itemId":"0","price":"0","pitch":"0","position":"0"};

  @override
  void initState() {
    super.initState();
    appBarTitle = "NPC商店新增物品:${Get.arguments["shopId"]}";
    var shopId = Get.arguments["shopId"];
    data["shopId"] = shopId.toString();
  }

  @override
  dispose() {
    super.dispose();
    npc_shoplogic.reqSearchNpcList(clear: true);
    npcshopinoflogic.reqSearchNpcInfoList(clear: true);
  }

  _showDialog(String title, String keyName,{defaultValue="",BuildContext? context,String subTitle="",WidgetType type=WidgetType.input,InputType inputType=InputType.number}) {
    WidgetUtils.showDialog(title, keyName, (value){
      if (type == WidgetType.input) {
        data[keyName] = value;
      }else if (type == WidgetType.date) {
        data[keyName] = value;
      }else if (type == WidgetType.toggle) {
        data[keyName] = value;
      }else if (type == WidgetType.sex) {
        if( value=="男"){
          value="0";
        }else if( value=="女"){
          value="1";
        }else if( value=="通用"){
          value="2";
        }
        data[keyName] = value;
      }else if (type == WidgetType.slider) {
        data[keyName] = (double.parse(value)*1000).toStringAsFixed(0);
      }
      logic.update([logic.V_list_body_view]);
    }, context: context,defaultValue:defaultValue, subTitle:subTitle,type: type,inputType: inputType);
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: GetBuilder<NpcShopInfoAddLogic>( id: logic.V_list_body_view, builder: (logic) {
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
                              image: NetworkImage(MSImageUtils.getIconUrlofIteamString(
                                category: "item",
                                itemId:
                                data["itemId"]??"0".toString(),
                              )),
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                    Symbols.error_circle_rounded);
                              }, fit: BoxFit.cover,),
                          ),
                          Text(data["itemName"]??""),
                          // Text("商店ID:${data["data"]!.shopId.toString()}"),
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
                                subTitleText: data["id"].toString(),
                              ),
                              SQListTile(
                                  titleText: "物品Id",
                                  subTitleText: data["itemId"].toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("物品Id", "itemId",defaultValue: data["itemId"].toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "价格",
                                  subTitleText: data["price"].toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("价格", "price",defaultValue: data["price"].toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "音符",
                                  subTitleText: data["pitch"]
                                      .toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("音符", "pitch",defaultValue: data["pitch"].toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "位置",
                                  subTitleText: data["position"]
                                      .toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("位置", "position",defaultValue: data["position"]!.toString());
                                  }
                              ),
                              GFButton(onPressed: (){
                                logic.reqAddData(data);
                                Get.back();
                              },child: Text("保存"))
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
