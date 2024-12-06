import 'package:bei_dou_gms_manage/page/home/game_info/global_shop/entity/GameGlobalEntity.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/global_shop/global_edit/logic.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/global_shop/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

class GlobalEditComponent extends StatefulWidget {
  @override
  State<GlobalEditComponent> createState() => _GlobalEditComponentState();
}

class _GlobalEditComponentState extends State<GlobalEditComponent> {
  final GlobalEditLogic logic = Get.put(GlobalEditLogic());
  final GlobalShopLogic globalshoplogic = Get.put(GlobalShopLogic());
  String appBarTitle = "全局爆率编辑";
  Map<String, dynamic> data = Get.arguments;

  @override
  void initState() {
    super.initState();
    appBarTitle = data["name"];
  }

  @override
  void dispose() {
    super.dispose();
    globalshoplogic.getData(clear: true);
  }

  _showDialog(String title, String keyName,{defaultValue="",BuildContext? context,String subTitle="",WidgetType type=WidgetType.input,InputType inputType=InputType.number}) {
    WidgetUtils.showDialog(title, keyName, (value){
      if (type == WidgetType.input) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = GameGlobalEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdateData(json);
        logic.update([logic.V_list_body_view]);
      }else if (type == WidgetType.date) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = GameGlobalEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdateData(json);
        logic.update([logic.V_list_body_view]);
      }else if (type == WidgetType.toggle) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = GameGlobalEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdateData(json);
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
        var pushdata = GameGlobalEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdateData(json);
        logic.update([logic.V_list_body_view]);
      }else if (type == WidgetType.slider) {
        var json = data["data"]!.toJson();
        json[keyName] = (double.parse(value)*1000).toStringAsFixed(0);
        var pushdata = GameGlobalEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdateData(json);
        logic.update([logic.V_list_body_view]);
      }
    }, context: context,defaultValue:defaultValue, subTitle:subTitle,type: type,inputType: inputType);
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: GetBuilder<GlobalEditLogic>( id: logic.V_list_body_view, builder: (logic) {
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
                                  titleText: "地区ID",
                                  subTitleText: data["data"]!.continent.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("地区ID", "continent",defaultValue: data["data"]!.continent.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "物品Id",
                                  subTitleText: data["data"]!.itemId.toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("物品Id", "itemId",defaultValue: data["data"]!.itemId.toString());
                                  }
                              ),

                              SQListTile(
                                  titleText: "最少",
                                  subTitleText: data["data"]!.minimumQuantity
                                      .toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("最少", "minimumQuantity",defaultValue: data["data"]!.minimumQuantity.toString());
                                  }
                              ),
                              SQListTile(
                                  titleText: "最多",
                                  subTitleText: data["data"]!.maximumQuantity
                                      .toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("最多", "maximumQuantity",defaultValue: data["data"]!.maximumQuantity.toString());
                                  }
                              ),
                              SQListTile(
                                titleText: "爆率%",
                                subTitleText: "${double.parse(data["data"]!.chance.toString())/1000}%",
                                icon: Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  _showDialog("爆率%", "chance",defaultValue: (double.parse(data["data"]!.chance.toString())/1000).toString(),type: WidgetType.slider,context: context);
                                },
                              ),
                              SQListTile(
                                titleText: "任务Id",
                                subTitleText: data["data"]!.questId.toString(),
                                icon: Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  _showDialog("任务Id", "questId",defaultValue: data["data"]!.questId.toString());
                                },
                              ),
                              SQListTile(
                                titleText: "任务名称",
                                subTitleText: data["data"]!.questName.toString(),
                              ),
                              SQListTile(
                                titleText: "描述",
                                subTitleText: data["data"]!.comments.toString(),
                                icon: Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  _showDialog("描述", "comments",defaultValue: data["data"]!.comments,type: WidgetType.input,inputType: InputType.text);
                                },
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
