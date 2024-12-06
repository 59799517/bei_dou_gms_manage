import 'package:bei_dou_gms_manage/page/home/game_info/config/config_edit/logic.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/config/entity/GameConfigEntity.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/config/logic.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class ConfigEditComponent extends StatefulWidget {
  @override
  State<ConfigEditComponent> createState() => _ConfigEditComponentState();
}

class _ConfigEditComponentState extends State<ConfigEditComponent> {
  final ConfigEditLogic logic = Get.put(ConfigEditLogic());
  final ConfigLogic configlogic = Get.put(ConfigLogic());
  Map<String, dynamic> data = Get.arguments;
  String appBarTitle = "参数设置编辑";

  @override
  void initState() {
    super.initState();
    appBarTitle = "【${data["data"]!.configCode}】参数编辑";
  }


  @override
  void dispose() {
    super.dispose();
    configlogic.getConfigList(clear: true);
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
        var pushdata = GameConfigEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdateData(json);
        logic.update([logic.V_list_body_view]);
      } else if (type == WidgetType.date) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = GameConfigEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdateData(json);
        logic.update([logic.V_list_body_view]);
      } else if (type == WidgetType.toggle) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = GameConfigEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdateData(json);
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
        var pushdata = GameConfigEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdateData(json);
        logic.update([logic.V_list_body_view]);
      } else if (type == WidgetType.slider) {
        var json = data["data"]!.toJson();
        json[keyName] = (double.parse(value) * 10000);
        var pushdata = GameConfigEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdateData(json);
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
      appBar: AppBar(title: Text(appBarTitle)),
      body: GetBuilder<ConfigEditLogic>(
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
                              Text("描述:${data["data"]!.configDesc}"),
                              Text("CODE:【${data["data"]!.configCode}】"),
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
                            titleText: "参数大类",
                            subTitleText: data["data"]!.configType.toString(),
                          ),
                          SQListTile(
                            titleText: "参数小类",
                            subTitleText: data["data"]!.configSubType,
                          ),
                          SQListTile(
                            titleText: "参数值类型",
                            subTitleText:
                            configlogic.ConfigClazzToString(data["data"]!.configClazz)
                                    .toString(),
                          ),
                          SQListTile(
                              titleText: "参数值",
                              subTitleText:
                                  data["data"]!.configValue.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                WidgetType configClazzToWidgetType = configlogic.ConfigClazzToWidgetType( data["data"]!.configClazz);
                                InputType configClazzToInputType = InputType.text;
                                if(configClazzToWidgetType==WidgetType.input){
                                   configClazzToInputType = configlogic.ConfigClazzToInputType(configClazzToWidgetType, data["data"]!.configClazz);
                                }
                                _showDialog("参数值", "configValue",
                                    defaultValue:
                                        data["data"]!.configValue.toString(),
                                    type: configClazzToWidgetType,inputType: configClazzToInputType);
                              }),
                          SQListTile(
                            titleText: "描述",
                            subTitleText: data["data"]!.configDesc.toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () async {
                              _showDialog("参数值", "configDesc",
                                  defaultValue:
                                  data["data"]!.configDesc.toString(),
                                  type: WidgetType.input,inputType: InputType.text);
                            },
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
