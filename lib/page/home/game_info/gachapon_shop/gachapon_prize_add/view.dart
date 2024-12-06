import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/gachapon_prize_add/logic.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/gachapon_prize_list/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_symbols_icons/symbols.dart';

class GachaponPrizeAddComponent extends StatefulWidget {
  @override
  State<GachaponPrizeAddComponent> createState() =>
      _GachaponPrizeAddComponentState();
}

class _GachaponPrizeAddComponentState extends State<GachaponPrizeAddComponent> {
  final GachaponPrizeAddLogic logic = Get.put(GachaponPrizeAddLogic());
  Map<String, dynamic> data = {
    "poolId": "",
    "quantity": 1,
    "itemId": "",
    "comment": "暂无"
  };
  final GachaponPrizeListLogic gachaponprizelistlogic =
      Get.put(GachaponPrizeListLogic());

  @override
  void initState() {
    super.initState();
    var arguments = Get.arguments;
    data["poolId"] = arguments["id"];
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
      appBar: AppBar(title: Text("添加奖品")),
      body: GetBuilder<GachaponPrizeAddLogic>(
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
                                    category: "item",
                                    itemId: data["itemId"] ?? "0".toString(),
                                  )),
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                        Symbols.error_circle_rounded);
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(data["itemName"] ?? ""),
                              // Text("商店ID:${data["data"]!.shopId.toString()}"),
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
                              titleText: "物品Id",
                              subTitleText: data["itemId"].toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("物品Id", "itemId",
                                    defaultValue: data["itemId"].toString());
                              }),
                          SQListTile(
                              titleText: "数量",
                              subTitleText: data["quantity"].toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("数量", "quantity",
                                    defaultValue: data["quantity"].toString());
                              }),
                          SQListTile(
                              titleText: "备注",
                              subTitleText: data["comment"].toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("备注", "comment",
                                    defaultValue: data["comment"]!.toString(),
                                    inputType: InputType.text);
                              }),
                          GFButton(
                              onPressed: () {
                                logic.reqAddData(data).then((val) => {
                                      gachaponprizelistlogic.reqSearchList(
                                          clear: true),
                                      Get.back()
                                    });
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
