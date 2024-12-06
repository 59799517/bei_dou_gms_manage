import 'package:bei_dou_gms_manage/page/home/play_user/play_user_give/logic.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_symbols_icons/symbols.dart';

class PlayUserGiveComponent extends StatefulWidget {
  @override
  State<PlayUserGiveComponent> createState() => _PlayUserGiveComponentState();
}

class _PlayUserGiveComponentState extends State<PlayUserGiveComponent> {

  final PlayUserGiveLogic logic = Get.put(PlayUserGiveLogic());
  String appBarTitle = "全局发放资源";
  Map<String, dynamic> data = Get.arguments;
  String payUserID = "0";
  @override
  void initState() {
    super.initState();
      payUserID = data["id"];
      logic.update([logic.V_list_body_view]);
    if (payUserID == null||payUserID.isEmpty||payUserID=="0") {
      appBarTitle = "全局发放资源";
      logic.type = logic.global_type;
    }else{
      appBarTitle = "${data["name"]}用户发放资源";
      logic.pushdata["worldId"] = data["data"].world;
      logic.pushdata["player"] = data["name"];
    }
    logic.pushdata["playerId"] = payUserID;
  }


  _showDialog(String title, String keyName,
      {defaultValue = "",
        BuildContext? context,
        String subTitle = "",
        WidgetType type = WidgetType.input,
        InputType inputType = InputType.number}) {
    if(defaultValue==null||defaultValue==""){
      defaultValue = logic.getPushData(keyName);
    }
    WidgetUtils.showDialog(title, keyName, (value) {
      if (type == WidgetType.input) {
        logic.pushdata[keyName] = value;
      } else if (type == WidgetType.date) {
        logic.pushdata[keyName] = value;
      } else if (type == WidgetType.toggle) {
        logic.pushdata[keyName] = value;
      } else if (type == WidgetType.sex) {
        if (value == "男") {
          value = "0";
        } else if (value == "女") {
          value = "1";
        } else if (value == "通用") {
          value = "2";
        }
        logic.pushdata[keyName] = value;
      } else if (type == WidgetType.slider) {
        logic.pushdata[keyName] = (double.parse(value) * 10000);
      }
      logic.update([logic.V_list_body_view]);

    },
        context: context,
        defaultValue:  defaultValue.toString(),
        subTitle: subTitle,
        type: type,
        inputType: inputType);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: GetBuilder<PlayUserGiveLogic>( id: logic.V_list_body_view, builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            data["id"].toString()!="0"? Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: Card(
                    elevation: 8.0,
                    margin: EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "地图:${data["data"].map.toString()}",
                              style: TextStyle(
                                  color: Colors.black)),
                          Text(
                              "职业:${data["data"].jobName.toString()}(${data["data"].job.toString()})",
                              style: TextStyle(
                                  color: Colors.black)),
                          Text(
                              "等级:${data["data"].level.toString()}",
                              style: TextStyle(
                                  color: Colors.black)),
                          Text(
                              "GM等级:${data["data"].gm.toString()}",
                              style: TextStyle(
                                  color: Colors.black))
                          //
                        ],
                      ),
                    )
                ),
              ),
            ): Container(),
            Expanded(
              flex: 4,
              child: Container(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                            children: [
                              GFListTile(
                                titleText: "资源类型",
                                subTitleText: logic.type_select,
                                icon: Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  Get.defaultDialog(
                                    title: "请选择资源类型",
                                    titleStyle: const TextStyle(color: Colors.black),
                                    content: Container(
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 10,
                                              ),
                                              GetBuilder<PlayUserGiveLogic>(
                                                  id: logic.V_dropdown_main_view,
                                                  builder: (logic) {
                                                    return DropdownButton<String>(
                                                      value: logic.type_select.isEmpty
                                                          ? null
                                                          : logic.type_select,
                                                      hint: Text("请选择分类"),
                                                      items: logic.type.keys.map((e) {
                                                        return DropdownMenuItem(
                                                          value: e,
                                                          child: Text(e),
                                                        );
                                                      }).toList(),
                                                      onChanged: (String? value) {
                                                        setState(() {
                                                          logic.type_select = value!;
                                                          logic.pushdata["type"] = logic.type[value];
                                                          logic.update(
                                                              [logic.V_dropdown_main_view]);
                                                        });
                                                      },
                                                    );
                                                  }),

                                              SizedBox(
                                                height: 20,
                                              )
                                            ])),
                                    confirm: Container(
                                      child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              side: const BorderSide(
                                                color: Colors.blueAccent,
                                              ),
                                              minimumSize: const Size(100, 40)),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text(
                                            "确定",
                                            style: TextStyle(color: Colors.blueAccent),
                                          )),
                                    ),
                                    //取消按钮
                                    cancel: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          side: const BorderSide(
                                            color: Colors.redAccent,
                                          ),
                                          minimumSize: const Size(100, 40)),
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("取消",
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                          )),
                                    ),
                                    barrierDismissible: true,
                                    backgroundColor: Colors.white,
                                    radius: 0,
                                  );
                                 },
                              ),
                              logic.type[logic.type_select]==5||logic.type[logic.type_select]==6?
                              GFListTile(
                                titleText: "道具ID",
                                subTitleText: logic.pushdata["id"] ==null? "0": logic.pushdata["id"].toString(),
                                icon: Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  _showDialog("道具ID", "id",type: WidgetType.input,inputType: InputType.number);
                                }
                              ):Container(),
                              logic.quantity_type_value.contains(logic.type[logic.type_select])?
                              GFListTile(
                                titleText: "数量",
                                subTitleText: logic.pushdata["quantity"] ==null? "0": logic.pushdata["quantity"].toString(),
                                icon: Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  _showDialog("数量", "quantity",type: WidgetType.input,inputType: InputType.number);
                                },
                              ):Container(),
                              logic.type[logic.type_select]==6?Column(
                                children: [
                                  GFListTile(
                                    titleText: "力量",
                                    subTitleText: logic.pushdata["str"] ==null? "0": logic.pushdata["str"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("力量", "str",type: WidgetType.input,inputType: InputType.number);
                                    },
                                  ),
                                  GFListTile(
                                    titleText: "敏捷",
                                    subTitleText: logic.pushdata["dex"] ==null? "0": logic.pushdata["dex"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("敏捷", "dex",type: WidgetType.input,inputType: InputType.number);
                                    },
                                  ),
                                  GFListTile(
                                    titleText: "智力",
                                    subTitleText: logic.pushdata["int"] ==null? "0": logic.pushdata["int"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("智力", "int",type: WidgetType.input,inputType: InputType.number);
                                    },
                                  ),
                                  GFListTile(
                                    titleText: "运气",
                                    subTitleText: logic.pushdata["luk"] ==null? "0": logic.pushdata["luk"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("运气", "luk",type: WidgetType.input,inputType: InputType.number);
                                    },
                                  ),
                                  GFListTile(
                                    titleText: "HP",
                                    subTitleText: logic.pushdata["hp"] ==null? "0": logic.pushdata["hp"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("HP", "hp",type: WidgetType.input,inputType: InputType.number);
                                    },
                                  ),
                                  GFListTile(
                                    titleText: "MP",
                                    subTitleText: logic.pushdata["mp"] ==null? "0": logic.pushdata["mp"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("MP", "mp",type: WidgetType.input,inputType: InputType.number);
                                    },
                                  ),
                                  GFListTile(
                                    titleText: "物攻",
                                    subTitleText: logic.pushdata["pAtk"] ==null? "0": logic.pushdata["pAtk"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("物攻", "pAtk",type: WidgetType.input,inputType: InputType.number);
                                    },
                                  ),
                                  GFListTile(
                                    titleText: "魔攻",
                                    subTitleText: logic.pushdata["mAtk"] ==null? "0": logic.pushdata["mAtk"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("魔攻", "mAtk",type: WidgetType.input,inputType: InputType.number);
                                    },
                                  ),
                                  GFListTile(
                                    titleText: "物防",
                                    subTitleText: logic.pushdata["pDef"] ==null? "0": logic.pushdata["pDef"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("物防", "pDef",type: WidgetType.input,inputType: InputType.number);
                                    },
                                  ),
                                  GFListTile(
                                    titleText: "魔防",
                                    subTitleText: logic.pushdata["mDef"] ==null? "0": logic.pushdata["mDef"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("魔防", "mDef",type: WidgetType.input,inputType: InputType.number);
                                    },
                                  ),
                                  GFListTile(
                                    titleText: "命中",
                                    subTitleText: logic.pushdata["acc"] ==null? "0": logic.pushdata["acc"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("命中", "acc",type: WidgetType.input,inputType: InputType.number);
                                    },
                                  ),
                                  GFListTile(
                                    titleText: "回避",
                                    subTitleText: logic.pushdata["avoid"] ==null? "0": logic.pushdata["avoid"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("回避", "avoid",type: WidgetType.input,inputType: InputType.number);
                                    },
                                  ),
                                  GFListTile(
                                    titleText: "手技",
                                    subTitleText: logic.pushdata["hands"] ==null? "0": logic.pushdata["hands"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("手技", "hands",type: WidgetType.input,inputType: InputType.number);
                                    },
                                  ),
                                  GFListTile(
                                    titleText: "移速",
                                    subTitleText: logic.pushdata["speed"] ==null? "0": logic.pushdata["speed"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("移速", "speed",type: WidgetType.input,inputType: InputType.number);
                                    },
                                  ),
                                  GFListTile(
                                    titleText: "跳跃",
                                    subTitleText: logic.pushdata["jump"] ==null? "0": logic.pushdata["jump"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("跳跃", "jump",type: WidgetType.input,inputType: InputType.number);
                                    },
                                  ),
                                  GFListTile(
                                    titleText: "升级次数",
                                    subTitleText: logic.pushdata["upgradeSlot"] ==null? "0": logic.pushdata["upgradeSlot"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("升级次数", "upgradeSlot",type: WidgetType.input,inputType: InputType.number);
                                    },
                                  ),
                                  GFListTile(
                                    titleText: "有效期",
                                    subTitleText: logic.pushdata["expire"].toString()=="-1"?"永久":logic.pushdata["expire"].toString(),
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      _showDialog("有效期", "expire",type: WidgetType.input,inputType: InputType.date);
                                    },
                                  ),

                                ],
                              ):Container(),
                              GFButton(onPressed: (){
                                logic.giveresource();
                                Get.back();
                              },child: Text("发送"))
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
