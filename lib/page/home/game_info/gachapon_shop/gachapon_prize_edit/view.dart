import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/gachapon_prize_edit/logic.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/gachapon_prize_list/entity/GachaponPrizeEntity.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/gachapon_prize_list/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_symbols_icons/symbols.dart';

class GachaponPrizeEditComponent extends StatefulWidget {
  @override
  State<GachaponPrizeEditComponent> createState() =>
      _GachaponPrizeEditComponentState();
}

class _GachaponPrizeEditComponentState
    extends State<GachaponPrizeEditComponent> {
  final GachaponPrizeEditLogic logic = Get.put(GachaponPrizeEditLogic());
  final GachaponPrizeListLogic gachaponprizelistlogic = Get.put(GachaponPrizeListLogic());

  String appBarName = "添加商品";

  Map<String, dynamic> data = {};
  @override
  void initState() {
    super.initState();
    data = Get.arguments;
  }
  @override
  void dispose() {
    super.dispose();
    gachaponprizelistlogic.reqSearchList(clear: true);
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
        var pushdata = GachaponPrizeEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqEditData(json);
        logic.update([logic.V_list_body_view]);
      } else if (type == WidgetType.date) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = GachaponPrizeEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqEditData(json);
        logic.update([logic.V_list_body_view]);
      } else if (type == WidgetType.toggle) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = GachaponPrizeEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqEditData(json);
        logic.update([logic.V_list_body_view]);
      } else if (type == WidgetType.sex) {
        if (value == "男") {
          value = "0";
        } else if (value == "女") {
          value = "1";
        } else if (value == "通用") {
          value = "2";
        }
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = GachaponPrizeEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqEditData(json);
        logic.update([logic.V_list_body_view]);
      } else if (type == WidgetType.slider) {
        var json = data["data"]!.toJson();
        json[keyName] = (double.parse(value) * 1000).toStringAsFixed(0);
        var pushdata = GachaponPrizeEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqEditData(json);
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
      appBar: AppBar(title: Text(appBarName)),
      body: GetBuilder<GachaponPrizeEditLogic>(
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
                                      MSImageUtils.getIconUrl(
                                    category: "item",
                                    itemId: data["data"].itemId ?? "0".toString(),
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
                              subTitleText: data["data"].itemId.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("物品Id", "itemId",
                                    defaultValue: data["data"].itemId.toString());
                              }),
                          SQListTile(
                              titleText: "数量",
                              subTitleText: data["data"].quantity.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("数量", "quantity",
                                    defaultValue: data["data"].quantity.toString());
                              }),
                          SQListTile(
                              titleText: "备注",
                              subTitleText: data["data"].comment.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("备注", "comment",
                                    defaultValue: data["data"]!.comment.toString(),
                                    type: WidgetType.input,
                                    inputType: InputType.text);
                              }),
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
