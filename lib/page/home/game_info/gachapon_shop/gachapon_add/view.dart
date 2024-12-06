import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/entity/GachaponEntity.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/gachapon_add/logic.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_symbols_icons/symbols.dart';

class GachaponAddComponent extends StatefulWidget {
  @override
  State<GachaponAddComponent> createState() => _GachaponAddComponentState();
}

class _GachaponAddComponentState extends State<GachaponAddComponent> {
  final GachaponAddLogic logic = Get.put(GachaponAddLogic());
  final GachaponShopLogic gachaponshoplogic = Get.put(GachaponShopLogic());

  var data = {
    "id": "-999",
    "name": "",
    "gachaponId": "",
    "weight": 10000,
    "isPublic": false,
    "startTime": "",
    "endTime": "",
    "notification": false,
    "comment": "000000000"
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    gachaponshoplogic.reqSearchList(clear: true);
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
      appBar: AppBar(title: Text("新增百宝箱")),
      body: GetBuilder<GachaponAddLogic>(
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
                                  image: NetworkImage(
                                      MSImageUtils.getIconUrlofIteamString(
                                    category: "npc",
                                    itemId: data["gachaponId"].toString(),
                                  )),
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                        Symbols.error_circle_rounded);
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(data["gachaponName"].toString()),
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
                              titleText: "是否公共池",
                              subTitleText:
                                  bool.parse(data["isPublic"].toString())
                                      ? "是"
                                      : "否",
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("是否公共池", "isPublic",
                                    defaultValue: data["isPublic"].toString(),
                                    type: WidgetType.toggle);
                              }),
                          SQListTile(
                              titleText: "奖池名称",
                              subTitleText: data["name"].toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("奖池名称", "name",
                                    defaultValue: data["name"],
                                    type: WidgetType.input,
                                    inputType: InputType.text);
                              }),
                          bool.parse(data["isPublic"].toString())
                              ? Container()
                              : SQListTile(
                                  titleText: "百宝箱ID",
                                  subTitleText: data["gachaponId"].toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("百宝箱ID", "gachaponId",
                                        defaultValue:
                                            data["gachaponId"].toString(),
                                        type: WidgetType.input);
                                  }),
                          SQListTile(
                            titleText: "权重（概率）",
                            subTitleText:
                                bool.parse(data["isPublic"].toString())
                                    ? "${data["prob"].toString()}"
                                    : "${data["weight"].toString()}",
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              if (bool.parse(data["isPublic"].toString())) {
                                //只计算自己的权重
                                data["gachaponId"] = "-1";
                                _showDialog("百宝箱ID", "prob",
                                    defaultValue:
                                        (double.parse(data["prob"].toString()) /
                                                10000)
                                            .toString(),
                                    type: WidgetType.slider);
                              } else {
                                //查询相邻的权重
                                if (data["gachaponId"].toString().isEmpty) {
                                  BotToast.showText(
                                      text: "请先输入百宝箱ID"); //popup a text toast;
                                  return;
                                }
                                gachaponshoplogic.searchValue =
                                    data["gachaponId"].toString();
                                gachaponshoplogic
                                    .reqSearchList(clear: true)
                                    .then((value) {
                                  if (value["code"] == 20000) {
                                    List<GachaponEntity> list =
                                        GachaponEntity.fromJsonList(
                                            value["data"]['records']);
                                    Map<String, double> map = {};
                                    list.forEach((element) {
                                      print(
                                          "当前判断${element.id.toString() != data["id"]!.toString()} /  element.id: ${element.id.toString()} / data!.id: ${data["id"]!.toString()}");
                                      if (element.id.toString() !=
                                          data["id"]!.toString()) {
                                        map[element.name] = double.parse(
                                            element.weight.toString());
                                      }
                                    });
                                    WidgetUtils.showProbDialog(
                                        "权重（概率）", "weight", (value) {
                                      var weight = value['weight'];
                                      var prob = value['prob'];
                                      data['weight'] = weight;
                                      data['realProb'] = prob;
                                      logic.update([logic.V_list_body_view]);
                                    },
                                        map,
                                        double.parse(
                                            data["weight"].toString()));
                                  } else {
                                    Get.showSnackbar(value["message"]);
                                  }
                                });
                              }
                            },
                          ),
                          SQListTile(
                            titleText: "生效时间",
                            subTitleText: data["startTime"]!.toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () async {
                              _showDialog("生效时间", "startTime",
                                  type: WidgetType.date, context: context);
                            },
                          ),
                          SQListTile(
                            titleText: "结束时间",
                            subTitleText: data["endTime"]!.toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () async {
                              _showDialog("结束时间", "endTime",
                                  type: WidgetType.date, context: context);
                            },
                          ),
                          SQListTile(
                            titleText: "全服通知",
                            subTitleText:
                                bool.parse(data["notification"].toString())
                                    ? "是"
                                    : "否",
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("全服通知", "notification",
                                  type: WidgetType.toggle,
                                  defaultValue: data["notification"].toString());
                            },
                          ),
                          SQListTile(
                            titleText: "描述",
                            subTitleText: data["comment"]!.toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("描述", "comment",
                                  type: WidgetType.input,
                                  inputType: InputType.text);
                            },
                          ),
                          GFButton(
                              onPressed: () {
                                logic.reqAddData(data);
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
