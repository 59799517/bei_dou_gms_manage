import 'package:bei_dou_gms_manage/page/home/play_user/account/account_add/logic.dart';
import 'package:bei_dou_gms_manage/page/home/play_user/account/logic.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';


class AccountAddComponent extends StatefulWidget {
  @override
  State<AccountAddComponent> createState() => _AccountAddComponentState();
}

class _AccountAddComponentState extends State<AccountAddComponent> {
  final AccountAddLogic logic = Get.put(AccountAddLogic());
  final AccountLogic accountlogic = Get.put(AccountLogic());

  Map<String, dynamic> data = {"name":"","password":"","checkPassword":"","birthday":"","language":3};

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    accountlogic.getData(clear: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("添加用户")),
      body: GetBuilder<AccountAddLogic>(
          id: logic.V_list_body_view,
          builder: (logic) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Column(children: [
                              SQListTile(
                                  titleText: "账号",
                                  subTitleText: data["name"].toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: "最小6位以上",

                                      content: Container(
                                          child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "最小6位以上名称",
                                                    style:
                                                    const TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextField(
                                                  maxLines: null,
                                                  minLines: 1,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(100)
                                                  ],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      data["name"] = value;
                                                    });
                                                  },
                                                  decoration: const InputDecoration(
                                                    hintText: "请输入",
                                                    hintStyle:
                                                    TextStyle(color: Colors.grey),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(20)),
                                                      borderSide: BorderSide(
                                                        color: Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    // 设置输入框可编辑时的边框样式
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(20)),
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    // 用来配置输入框获取焦点时的颜色
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(20)),
                                                      borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                  ),
                                                  style: TextStyle(fontSize: 16),
                                                  keyboardType: TextInputType.text,
                                                ),
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
                                              if (data["name"].isEmpty ||
                                                  data["name"].length < 6) {
                                                BotToast.showText(text: "请输入最少6位密码");
                                                return;
                                              }
                                              logic.update([logic.V_list_body_view]);
                                              Get.back();
                                            },
                                            child: const Text(
                                              "确定",
                                              style: TextStyle(
                                                  color: Colors.blueAccent),
                                            )),
                                      ),
                                      //取消按钮
                                      cancel: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(5),
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
                                  }),
                              SQListTile(
                                  titleText: "密码",
                                  subTitleText: data["password"].toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: "密码",

                                      content: Container(
                                          child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextField(
                                                  obscureText: true,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        100)
                                                  ],
                                                  onChanged: (value) {
                                                    data["password"] = value;
                                                  },
                                                  decoration: const InputDecoration(
                                                    hintText: "请输入密码",
                                                    labelText: "密码",
                                                    hintStyle:
                                                    TextStyle(color: Colors.grey),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(20)),
                                                      borderSide: BorderSide(
                                                        color: Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    // 设置输入框可编辑时的边框样式
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(20)),
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    // 用来配置输入框获取焦点时的颜色
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(20)),
                                                      borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                  ),
                                                  style: TextStyle(fontSize: 16),
                                                  keyboardType: TextInputType.text,
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                TextField(
                                                  obscureText: true,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        100)
                                                  ],
                                                  onChanged: (value) {
                                                    data["checkPassword"] = value;
                                                  },
                                                  decoration: const InputDecoration(
                                                    hintText: "请再次输入密码",
                                                    labelText: "确认密码",
                                                    hintStyle:
                                                    TextStyle(color: Colors.grey),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(20)),
                                                      borderSide: BorderSide(
                                                        color: Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    // 设置输入框可编辑时的边框样式
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(20)),
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    // 用来配置输入框获取焦点时的颜色
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(20)),
                                                      borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                  ),
                                                  style: TextStyle(fontSize: 16),
                                                  keyboardType: TextInputType.text,
                                                ),
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
                                              if (data["password"].isEmpty|| data["password"].length < 6) {
                                                BotToast.showText(text: "密码最少6位以上");
                                                return;
                                              }
                                              if (data["checkPassword"] != data["password"]) {
                                                BotToast.showText(text: "两次密码不一致");
                                                return;
                                              }
                                              logic
                                                  .update([logic.V_list_body_view]);
                                              Get.back();
                                            },
                                            child: const Text(
                                              "确定",
                                              style: TextStyle(
                                                  color: Colors.blueAccent),
                                            )),
                                      ),
                                      //取消按钮
                                      cancel: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(5),
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
                                  }),
                              SQListTile(
                                  titleText: "生日",
                                  subTitleText: data["birthday"].toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () async {
                                    DateTime initDateTime = DateTime.now();
                                    if (data["birthday"].isNotEmpty) {
                                      var formatter = DateFormat('yyyy-MM-dd');
                                      initDateTime =
                                          formatter.parse(data["birthday"]);
                                    }
                                    DateTime? dateTime =
                                    await showOmniDateTimePicker(
                                      context: context,
                                      is24HourMode: true,
                                      initialDate: initDateTime,
                                    );
                                    if (dateTime == null) {
                                      return;
                                    }
                                    var selectTime = formatDate(
                                        dateTime, [yyyy, '-', mm, '-', dd]);
                                    data["birthday"] = selectTime;
                                    logic.update([logic.V_list_body_view]);
                                  }),
                              SQListTile(
                                titleText: "语言",
                                subTitleText:
                                data["language"] == 3 ? "中文" : "English",
                                icon: Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  //true是中文false是英语
                                  bool selevtValue = data["language"] == 3;
                                  if (data["language"]!.toString() == "3") {
                                    //true和1是 真 其他是0 和 false 是假 其他则 都为假
                                    selevtValue = data["language"] == 3;
                                  }
                                  Get.defaultDialog(
                                    title: "修改语言",
                                    content: Container(
                                        child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 35,
                                                child: ToggleSwitch(
                                                  minWidth: 90.0,
                                                  initialLabelIndex:
                                                  selevtValue ? 0 : 1,
                                                  cornerRadius: 20.0,
                                                  activeFgColor: Colors.white,
                                                  inactiveBgColor: Colors.grey,
                                                  inactiveFgColor: Colors.white,
                                                  totalSwitches: 2,
                                                  labels: ["中文", 'English'],
                                                  icons: [Symbols.check, Symbols.close],
                                                  activeBgColors: [
                                                    [Colors.blue],
                                                    [Colors.pink]
                                                  ],
                                                  onToggle: (index) {
                                                    selevtValue =
                                                    index == 0 ? true : false;
                                                    print('switched to: $index');
                                                  },
                                                ),
                                              ),
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
                                            if (selevtValue) {
                                              data["language"] = 3;
                                            } else {
                                              data["language"] = 2;
                                            }
                                            logic.update([logic.V_list_body_view]);
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
                              GFButton(onPressed: (){
                                logic.addAccountData(data);
                                Get.back();
                              },child: Text("保存"))
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
