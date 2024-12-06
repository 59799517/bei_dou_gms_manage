import 'package:bei_dou_gms_manage/page/home/game_info/cash_shop/cash_shop_info/CashShopInfoEntity.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'logic.dart';

class CashShopInfoComponent extends StatelessWidget {
  CashShopInfoComponent({Key? key}) : super(key: key);

  final CashShopInfoLogic logic = Get.put(CashShopInfoLogic());
  final Map<String, CashShopInfoEntity> data = Get.arguments;

  _showDialog(String title, String keyName,
      {defaultValue = "",
      BuildContext? context,
      String subTitle = "",
      WidgetType type = WidgetType.input,
      InputType inputType = InputType.number}) {
    bool onSale = true;
    WidgetUtils.showDialog(title, keyName, (value) {
      if (type == WidgetType.input) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = CashShopInfoEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdatedata({keyName: value, "sn": data["data"]!.sn.toString()},
            onSale: onSale);
        logic.update([logic.V_list_body_view]);
      } else if (type == WidgetType.date) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = CashShopInfoEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdatedata({keyName: value, "sn": data["data"]!.sn.toString()},
            onSale: onSale);
        logic.update([logic.V_list_body_view]);
      } else if (type == WidgetType.toggle) {
        var json = data["data"]!.toJson();
        onSale = value;
        if (onSale) {
          value = "1";
        } else {
          value = "0";
        }
        json[keyName] = value;
        var pushdata = CashShopInfoEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdatedata({keyName: value, "sn": data["data"]!.sn.toString()},
            onSale: onSale);
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
        var pushdata = CashShopInfoEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdatedata({keyName: value, "sn": data["data"]!.sn.toString()},
            onSale: onSale);
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
      appBar: AppBar(title: Text(data["data"]!.itemName)),
      body: GetBuilder<CashShopInfoLogic>(
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
                              Text("sn:${data["data"]!.sn.toString()}"),
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
                            subTitleText: data["data"]!.itemId.toString(),
                            secondButtonTextStyle:
                                TextStyle(color: Colors.blue),
                          ),
                          SQListTile(
                              titleText: "数量",
                              subTitleText: data["data"]!.count.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("数量", "count",
                                    defaultValue:
                                        data["data"]!.count.toString());
                              }),
                          SQListTile(
                              titleText: "优先级",
                              subTitleText: data["data"]!.priority.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("优先级", "priority",
                                    defaultValue:
                                        data["data"]!.priority.toString());
                              }),
                          SQListTile(
                              titleText: "售价",
                              subTitleText: data["data"]!.price.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("售价", "price",
                                    defaultValue:
                                        data["data"]!.price.toString());
                              }),
                          SQListTile(
                              titleText: "Bonus",
                              subTitleText: data["data"]!.bonus.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("Bonus", "bonus",
                                    defaultValue:
                                        data["data"]!.bonus.toString());
                              }),
                          SQListTile(
                              titleText: "有效期",
                              subTitleText:
                                  "${data["data"]!.period.toString()}(天)",
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("有效期", "period",
                                    defaultValue:
                                        data["data"]!.period.toString());
                              }),
                          SQListTile(
                              titleText: "抵用券",
                              subTitleText: data["data"]!.maplePoint.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("抵用券", "maplePoint",
                                    defaultValue:
                                        data["data"]!.maplePoint.toString());
                              }),
                          SQListTile(
                              titleText: "金币",
                              subTitleText: data["data"]!.meso.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("金币", "meso",
                                    defaultValue:
                                        data["data"]!.meso.toString());
                              }),
                          SQListTile(
                              titleText: "会员专属",
                              subTitleText:
                                  data["data"]!.forPremiumUser.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("会员专属", "forPremiumUser",
                                    defaultValue: data["data"]!
                                        .forPremiumUser
                                        .toString());
                              }),
                          SQListTile(
                              titleText: "性别",
                              subTitleText: data["data"]!.gender == 0
                                  ? "男"
                                  : data["data"]!.gender == 1
                                      ? "女"
                                      : "通用",
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("性别", "gender",
                                    type: WidgetType.sex,
                                    defaultValue: data["data"]!.gender == 0
                                        ? "男"
                                        : data["data"]!.gender == 1
                                            ? "女"
                                            : "通用");
                              }),
                          SQListTile(
                              titleText: "上架",
                              subTitleText:
                                  data["data"]!.onSale == 0 ? "待售" : "已上架",
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("上架", "onSale",
                                    type: WidgetType.toggle, context: context);
                              }),
                          SQListTile(
                            titleText: "标签",
                            subTitleText:
                                "${data["data"]!.clz == 0 ? "NEW" : data["data"]!.clz == 1 ? "SALE" : data["data"]!.clz == 2 ? "HOT" : "EVENT"}",
                          ),
                          SQListTile(
                            titleText: "Limit",
                            subTitleText: data["data"]!.limit.toString(),
                          ),
                          SQListTile(
                            titleText: "PbCash",
                            subTitleText: data["data"]!.pbCash.toString(),
                          ),
                          SQListTile(
                            titleText: "PbPoint",
                            subTitleText: data["data"]!.pbPoint.toString(),
                          ),
                          SQListTile(
                            titleText: "PbGift",
                            subTitleText: data["data"]!.pbGift.toString(),
                          ),
                          SQListTile(
                            titleText: "礼包合集",
                            subTitleText: data["data"]!.packageSn.toString(),
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
