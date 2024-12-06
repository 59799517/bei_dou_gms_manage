import 'package:bei_dou_gms_manage/page/home/game_info/global_shop/global_add/logic.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/global_shop/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_symbols_icons/symbols.dart';

class GlobalAddComponent extends StatefulWidget {
  @override
  State<GlobalAddComponent> createState() => _GlobalAddComponentState();
}

class _GlobalAddComponentState extends State<GlobalAddComponent> {
  final GlobalAddLogic logic = Get.put(GlobalAddLogic());
  final GlobalShopLogic globalshoplogic = Get.put(GlobalShopLogic());

  String appBarTitle = "全局爆率新增";
  var data = {
    "continent": "-1",
    "itemId": "0",
    "minimumQuantity": "1",
    "maximumQuantity": "1",
    "questId": "0",
    "chance": "1000000",
    "comments": "暂无说明"
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        logic.update([logic.V_list_body_view]);
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
      body: GetBuilder<GlobalAddLogic>(
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
                              // Text(data["data"]!.dropperName),
                              Text(
                                  "物品名称:${data["itemId"] == "0" ? "金币" : data["itemName"]}"),
                              //
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
                            subTitleText: data["id"].toString(),
                          ),
                          SQListTile(
                              titleText: "地区ID",
                              subTitleText: data["continent"].toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("地区ID", "continent",
                                    defaultValue: data["continent"],
                                    context: context);
                              }),
                          SQListTile(
                              titleText: "物品Id",
                              subTitleText: data["itemId"].toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("物品Id", "itemId",
                                    defaultValue: data["itemId"],
                                    context: context);
                              }),
                          SQListTile(
                              titleText: "最少",
                              subTitleText: data["minimumQuantity"].toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("最少", "minimumQuantity",
                                    defaultValue: data["minimumQuantity"]);
                              }),
                          SQListTile(
                              titleText: "最多",
                              subTitleText: data["maximumQuantity"].toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("最多", "maximumQuantity",
                                    defaultValue: data["maximumQuantity"]);
                              }),
                          SQListTile(
                            titleText: "爆率%",
                            subTitleText:
                                "${double.parse(data["chance"].toString()) / 1000}%",
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("爆率%", "chance",
                                  type: WidgetType.slider,
                                  defaultValue:
                                      double.parse(data["chance"].toString()) /
                                          1000,
                                  context: context);
                            },
                          ),
                          SQListTile(
                            titleText: "任务Id",
                            subTitleText: data["questId"].toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("任务Id", "questId",
                                  defaultValue: data["questId"]);
                            },
                          ),
                          SQListTile(
                            titleText: "任务名称",
                            subTitleText: data["questName"].toString(),
                          ),
                          SQListTile(
                            titleText: "描述",
                            subTitleText: data["comments"].toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("描述", "comments",
                                  type: WidgetType.input,
                                  inputType: InputType.text,
                                  defaultValue: data["comments"],
                                  context: context);
                            },
                          ),
                          GFButton(
                              onPressed: () {
                                logic.reqAddData(data).then((val) => {
                                      globalshoplogic
                                          .getData(clear: true)
                                          .then((val) => {}),
                                    });
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
