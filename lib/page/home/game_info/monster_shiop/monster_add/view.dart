import 'package:bei_dou_gms_manage/page/home/game_info/monster_shiop/entity/MonsterEntity.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/monster_shiop/logic.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/monster_shiop/monster_add/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_symbols_icons/symbols.dart';

class MonsterAddComponent extends StatefulWidget {
  @override
  State<MonsterAddComponent> createState() => _MonsterAddComponentState();
}

class _MonsterAddComponentState extends State<MonsterAddComponent> {
  final MonsterAddLogic logic = Get.put(MonsterAddLogic());
  final MonsterShiopLogic monstershioplogic = Get.put(MonsterShiopLogic());

  String appBarTitle = "怪物爆率添加";

  late Map<String, String> data = {
    "id": "0",
    "dropperId": "",
    "itemId": "0",
    "minimumQuantity": "1",
    "maximumQuantity": "1",
    "questId": "0",
    "chance": "100000"
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    monstershioplogic.reqSearcMonsterList(clear: true);
  }

  _showDialog(String title, String keyName,
      {defaultValue = "",
      BuildContext? context,
      String subTitle = "",
      WidgetType type = WidgetType.input,
      InputType inputType = InputType.number}) {
    WidgetUtils.showDialog(title, keyName, (value) {
      if (type == WidgetType.input) {
        data[keyName] = value;
      } else if (type == WidgetType.date) {
        data[keyName] = value;
      } else if (type == WidgetType.toggle) {
        data[keyName] = value;
      } else if (type == WidgetType.sex) {
        if (value == "男") {
          value = "0";
        } else if (value == "女") {
          value = "1";
        } else if (value == "通用") {
          value = "2";
        }
        data[keyName] = value;
      } else if (type == WidgetType.slider) {
        data[keyName] = (double.parse(value) * 1000).toStringAsFixed(0);
      }
      logic.update([logic.V_list_body_view]);
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
      body: GetBuilder<MonsterAddLogic>(
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
                                child: data["itemId"] == "0"
                                    ? Image(
                                        image: NetworkImage(
                                            "https://maplestory.io/api/GMS/83/item/5200002/icon"),
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Symbols
                                              .error_circle_rounded);
                                        },
                                        fit: BoxFit.cover,
                                      )
                                    : Image(
                                        image: NetworkImage(MSImageUtils
                                            .getIconUrlofIteamString(
                                          category: "item",
                                          itemId: data["itemId"]!,
                                        )),
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Symbols
                                              .error_circle_rounded);
                                        },
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              // Text("物品名称:${data["itemName"].toString()}"),
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
                            titleText: "怪物ID",
                            subTitleText: data["dropperId"].toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("怪物ID", "dropperId",
                                  type: WidgetType.input,
                                  inputType: InputType.number,
                                  defaultValue: data["dropperId"]);
                            },
                            avatar: Image(
                              image: NetworkImage(
                                  MSImageUtils.getIconUrlofIteamString(
                                category: "mob",
                                itemId: data["dropperId"]!,
                              )),
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Symbols.error_circle_rounded);
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                          SQListTile(
                              titleText: "物品Id",
                              subTitleText: data["itemId"].toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("物品Id", "itemId",
                                    type: WidgetType.input,
                                    inputType: InputType.number,
                                    defaultValue: data["itemId"]);
                              }),
                          SQListTile(
                              titleText: "最少",
                              subTitleText: data["minimumQuantity"].toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("最少", "minimumQuantity",
                                    type: WidgetType.input,
                                    inputType: InputType.number,
                                    defaultValue: data["minimumQuantity"]);
                              }),
                          SQListTile(
                              titleText: "最多",
                              subTitleText: data["maximumQuantity"].toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("位置", "maximumQuantity",
                                    type: WidgetType.input,
                                    inputType: InputType.number,
                                    defaultValue: data["maximumQuantity"]);
                              }),
                          SQListTile(
                            titleText: "爆率%",
                            subTitleText:
                                "${double.parse(data["chance"].toString()) / 1000}%",
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("爆率%", "chance",
                                  defaultValue:
                                      double.parse(data["chance"].toString()) /
                                          1000,
                                  type: WidgetType.slider);
                            },
                          ),
                          SQListTile(
                            titleText: "任务Id",
                            subTitleText: data["questId"],
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("任务Id", "questId",
                                  type: WidgetType.input,
                                  inputType: InputType.number,
                                  defaultValue: data["questId"]);
                            },
                          ),
                          GFButton(
                              onPressed: () {
                                logic.reqAddMonster(data);
                                Get.back();
                              },
                              child: Text("保存"))
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
