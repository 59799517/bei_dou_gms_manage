import 'package:bei_dou_gms_manage/page/home/game_info/config/config_add/logic.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/config/logic.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class ConfigAddComponent extends StatefulWidget {
  @override
  State<ConfigAddComponent> createState() => _ConfigAddComponentState();
}

class _ConfigAddComponentState extends State<ConfigAddComponent> {
  final ConfigAddLogic logic = Get.put(ConfigAddLogic());
  final ConfigLogic configlogic = Get.put(ConfigLogic());
  String appBarTitle = "参数设置新增";
  Map<String, dynamic> data = {
    "configType": "server",
    "configSubType": "Game Mechanics",
    "configClazz": "java.lang.String",
    "configCode": "",
    "configValue": "",
    "configDesc": "在下方输入描述"
  };

  @override
  void initState() {
    super.initState();
    logic.getSettingTypeList();
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
      body: GetBuilder<ConfigAddLogic>(
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
                              Text("描述:${data["configDesc"]!}"),
                              Text("CODE:【${data["configCode"]!}】"),
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
                            subTitleText: logic.dropdownValue,
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              Get.defaultDialog(
                                title: "参数大类",

                                content: Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                      Text(
                                        "请输入新的参数大类(谨慎修改)",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          height: 35,
                                          child: GetBuilder<ConfigAddLogic>(
                                              id: logic.V_dropdown_main_view,
                                              builder: (logic) {
                                                return DropdownButton<String>(
                                                  value: logic
                                                          .dropdownValue.isEmpty
                                                      ? null
                                                      : logic.dropdownValue,
                                                  hint: Text("请选择分类"),
                                                  items: logic.typeMap.keys
                                                      .map((e) {
                                                    return DropdownMenuItem(
                                                      value: e,
                                                      child: Text(e),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      logic.dropdownValue =
                                                          value!;
                                                      logic.update([
                                                        logic
                                                            .V_dropdown_main_view
                                                      ]);
                                                    });
                                                  },
                                                );
                                              })),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ])),
                                confirm: Container(
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                        style:
                                            TextStyle(color: Colors.blueAccent),
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
                                radius: 0,
                              );
                            },
                          ),
                          SQListTile(
                            titleText: "参数小类",
                            subTitleText: logic.dropdownValueSub,
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              Get.defaultDialog(
                                title: "参数小类",
                                content: Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                      Text(
                                        "请输入新的参数小类(谨慎修改)",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          height: 35,
                                          child: GetBuilder<ConfigAddLogic>(
                                              id: logic.V_dropdown_sub_view,
                                              builder: (logic) {
                                                return DropdownButton<String>(
                                                  value: logic.dropdownValueSub
                                                          .isEmpty
                                                      ? null
                                                      : logic.dropdownValueSub,
                                                  hint: Text("请选择类型"),
                                                  items: logic.subTypeMap.keys
                                                      .map((e) {
                                                    return DropdownMenuItem(
                                                      value: e,
                                                      child: Text(e),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      logic.dropdownValueSub =
                                                          value!;
                                                      logic.update([
                                                        logic
                                                            .V_dropdown_sub_view
                                                      ]);
                                                    });
                                                  },
                                                );
                                              })),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ])),
                                confirm: Container(
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                        style:
                                            TextStyle(color: Colors.blueAccent),
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
                                radius: 0,
                              );
                            },
                          ),
                          SQListTile(
                            titleText: "参数值类型",
                            subTitleText: logic.configClazzStr.toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              Get.defaultDialog(
                                title: "参数值类型",
                                content: Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                      Text(
                                        "请输入新的参数值类型(谨慎修改)",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          height: 35,
                                          child: GetBuilder<ConfigAddLogic>(
                                              id: logic
                                                  .V_dropdown_configClazzStr_view,
                                              builder: (logic) {
                                                return DropdownButton<String>(
                                                  value: logic.configClazzStr
                                                          .isEmpty
                                                      ? null
                                                      : logic.configClazzStr,
                                                  hint: Text("请选择参数值类型"),
                                                  items: configlogic
                                                      .javaTypeNameList
                                                      .map((e) {
                                                    return DropdownMenuItem(
                                                      value: e,
                                                      child: Text(e),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      logic.configClazzStr =
                                                          value!;
                                                      logic.update([
                                                        logic
                                                            .V_dropdown_configClazzStr_view
                                                      ]);
                                                    });
                                                  },
                                                );
                                              })),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ])),
                                confirm: Container(
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                        style:
                                            TextStyle(color: Colors.blueAccent),
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
                                radius: 0,
                              );
                            },
                          ),
                          SQListTile(
                            titleText: "参数名称",
                            subTitleText: data["configCode"]!.toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () async {
                              _showDialog("参数名称", "configCode",
                                  defaultValue: data["configCode"]!.toString(),
                                  type: WidgetType.input,
                                  inputType: InputType.text);
                            },
                          ),
                          SQListTile(
                              titleText: "参数值",
                              subTitleText: data["configValue"]!.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                WidgetType configClazzToWidgetType =
                                    configlogic.ConfigClazzToWidgetType(
                                        configlogic.getConfigClazz(
                                            logic.configClazzStr));
                                InputType configClazzToInputType =
                                    InputType.text;
                                if (configClazzToWidgetType ==
                                    WidgetType.input) {
                                  configClazzToInputType =
                                      configlogic.ConfigClazzToInputType(
                                          configClazzToWidgetType,
                                          configlogic.getConfigClazz(
                                              logic.configClazzStr));
                                }
                                _showDialog("参数值", "configValue",
                                    defaultValue:
                                        data["configValue"]!.toString(),
                                    type: configClazzToWidgetType,
                                    inputType: configClazzToInputType);
                              }),
                          SQListTile(
                            titleText: "描述",
                            subTitleText: data["configDesc"]!.toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () async {
                              _showDialog("参数值", "configDesc",
                                  defaultValue: data["configDesc"]!.toString(),
                                  type: WidgetType.input,
                                  inputType: InputType.text);
                            },
                          ),
                          GFButton(
                              onPressed: () {
                                logic.addConfig(data);
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
