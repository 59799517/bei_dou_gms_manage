import 'package:bei_dou_gms_manage/page/home/play_user/account/account_edit/logic.dart';
import 'package:bei_dou_gms_manage/page/home/play_user/account/entity/AccountsEntity.dart';
import 'package:bei_dou_gms_manage/page/home/play_user/account/logic.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AccountEditComponent extends StatefulWidget {
  @override
  State<AccountEditComponent> createState() => _AccountEditComponentState();
}

class _AccountEditComponentState extends State<AccountEditComponent> {
  final AccountEditLogic logic = Get.put(AccountEditLogic());
  final AccountLogic accountlogic = Get.put(AccountLogic());

  Map<String, dynamic> data = Get.arguments;
  String appBarTitle = "编辑账号";

  String newPwd = "";
  String newPwdCheck = "";

  @override
  void initState() {
    super.initState();
    data["data"]!.newPwd = "";
    data["data"]!.newPwdCheck = "";
    appBarTitle = "${data["data"]!.name.toString()}账户信息修改";
  }

  @override
  void dispose() {
    super.dispose();
    accountlogic.getData(clear: true);
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
        var pushdata = AccountsEntity.fromJson(json);
        data["data"] = pushdata;
        logic.updateData(json);
        logic.update([logic.V_list_body_view]);
      } else if (type == WidgetType.date) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = AccountsEntity.fromJson(json);
        data["data"] = pushdata;
        logic.updateData(json);
        logic.update([logic.V_list_body_view]);
      } else if (type == WidgetType.toggle) {
        var json = data["data"]!.toJson();
        json[keyName] = value ? "1" : "0";
        var pushdata = AccountsEntity.fromJson(json);
        data["data"] = pushdata;
        logic.updateData(json);
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
        var pushdata = AccountsEntity.fromJson(json);
        data["data"] = pushdata;
        logic.updateData(json);
        logic.update([logic.V_list_body_view]);
      } else if (type == WidgetType.slider) {
        var json = data["data"]!.toJson();
        json[keyName] = (double.parse(value) * 1000).toStringAsFixed(0);
        var pushdata = AccountsEntity.fromJson(json);
        data["data"] = pushdata;
        logic.updateData(json);
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
      body: GetBuilder<AccountEditLogic>(
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
                              Text("账户名称：${data["data"]!.name.toString()}"),
                              Text("封禁状态：${data["data"]!.banned?"封禁中":"未封禁"}"),
                              Text(
                                  "登录状态:${data["data"]!.loggedin.toString() == "0" ? "未登录" : "已登录"}"),
                              Text(
                                  "最后登录时间:${data["data"].lastlogin.toString()}"),
                              Text(
                                  "账号注册时间:${data["data"]!.createdat.toString()}"),
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
                              titleText: "密码",
                              subTitleText: data["data"]!.newPwd.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                Get.defaultDialog(
                                  title: "修改密码",
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
                                            newPwd = value;
                                          },
                                          decoration: const InputDecoration(
                                            hintText: "请输入密码",
                                            labelText: "密码",

                                            filled: true,
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
                                            newPwdCheck = value;
                                          },
                                          decoration: const InputDecoration(
                                            hintText: "请再次输入密码",
                                            labelText: "确认密码",

                                            filled: true,
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
                                          if (newPwd != newPwdCheck) {
                                            BotToast.showText(text: "两次密码不一致");
                                            return;
                                          }
                                          data["data"]!.newPwd = newPwd;
                                          data["data"]!.newPwdCheck =
                                              newPwdCheck;
                                          var json = data["data"]!.toJson();
                                          var pushdata =
                                              AccountsEntity.fromJson(json);
                                          data["data"] = pushdata;
                                          logic.updateData(json);
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
                              titleText: "Pin",
                              subTitleText: data["data"]!.pin.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                Get.defaultDialog(
                                  title: "修改Pin只支持4位纯数字",
                                  content: Container(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                        Container(
                                          child: Text(
                                            "请输入新的Pin(谨慎修改)",
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
                                            LengthLimitingTextInputFormatter(4),
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'^-|[0-9]'))
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              data["data"]!.pin = value;
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
                                          if (data["data"]!.pin!.isEmpty ||
                                              data["data"]!.pin!.length != 4) {
                                            BotToast.showText(text: "请输入4位数字");
                                            return;
                                          }
                                          var json = data["data"]!.toJson();
                                          var pushdata =
                                              AccountsEntity.fromJson(json);
                                          data["data"] = pushdata;
                                          logic.updateData(json);
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
                              titleText: "Pic",
                              subTitleText: data["data"]!.pic.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                Get.defaultDialog(
                                  title: "修改Pic只支持6位纯数字",
                                  content: Container(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                        Container(
                                          child: Text(
                                            "请输入新的Pin(谨慎修改)",
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
                                            LengthLimitingTextInputFormatter(6),
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'^-|[0-9]'))
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              data["data"]!.pic = value;
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
                                          if (data["data"]!.pic!.isEmpty ||
                                              data["data"]!.pic!.length != 6) {
                                            BotToast.showText(text: "请输入6位数字");
                                            return;
                                          }
                                          var json = data["data"]!.toJson();
                                          var pushdata =
                                              AccountsEntity.fromJson(json);
                                          data["data"] = pushdata;
                                          logic.updateData(json);
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
                              subTitleText: data["data"]!.birthday.toString(),
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () async {
                                DateTime initDateTime = DateTime.now();
                                if (data["data"]!.birthday.isNotEmpty) {
                                  var formatter = DateFormat('yyyy-MM-dd');
                                  initDateTime =
                                      formatter.parse(data["data"]!.birthday);
                                }
                                DateTime? dateTime =
                                    await showOmniDateTimePicker(
                                  context: context!,
                                  is24HourMode: true,
                                  initialDate: initDateTime,
                                );
                                if (dateTime == null) {
                                  return;
                                }
                                var selectTime = formatDate(
                                    dateTime, [yyyy, '-', mm, '-', dd]);
                                data["data"]!.birthday = selectTime;
                                var json = data["data"]!.toJson();
                                var pushdata = AccountsEntity.fromJson(json);
                                data["data"] = pushdata;
                                logic.updateData(json);
                                logic.update([logic.V_list_body_view]);
                              }),
                          SQListTile(
                            titleText: "点券",
                            subTitleText: data["data"]!.nxCredit.toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("点券", "nxCredit",
                                  defaultValue:
                                      data["data"]!.nxCredit.toString(),
                                  context: context,
                                  type: WidgetType.input,
                                  inputType: InputType.number);
                            },
                          ),
                          SQListTile(
                            titleText: "信用点券",
                            subTitleText: data["data"]!.nxPrepaid.toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("信用点券", "nxPrepaid",
                                  defaultValue:
                                      data["data"]!.nxPrepaid.toString(),
                                  context: context,
                                  type: WidgetType.input,
                                  inputType: InputType.number);
                            },
                          ),
                          SQListTile(
                            titleText: "抵用券",
                            subTitleText: data["data"]!.maplePoint.toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("抵用券", "maplePoint",
                                  defaultValue:
                                      data["data"]!.maplePoint.toString(),
                                  context: context,
                                  type: WidgetType.input,
                                  inputType: InputType.number);
                            },
                          ),
                          SQListTile(
                            titleText: "角色槽",
                            subTitleText:
                                data["data"]!.characterslots.toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("角色槽", "characterslots",
                                  defaultValue:
                                      data["data"]!.characterslots.toString(),
                                  context: context,
                                  type: WidgetType.input,
                                  inputType: InputType.number);
                            },
                          ),
                          SQListTile(
                              titleText: "性别",
                              subTitleText:
                                  data["data"]!.gender.toString() == "0"
                                      ? "男"
                                      : data["data"]!.gender.toString() != "10"?"女":"未知",
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                int index = 0;
                                List<String> list = ["男", "女"];
                                if (data["data"]!
                                    .gender
                                    .toString()
                                    .isNotEmpty) {
                                  for (int i = 0; i < list.length; i++) {
                                    var element = list[i];
                                    if (element == data["data"]!.gender) {
                                      index = i;
                                      break;
                                    }
                                  }
                                }
                                Get.defaultDialog(
                                  title: "修改性别",
                                  content: Container(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                        Text(
                                          "请输入新的性别(谨慎修改)",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 35,
                                          child: ToggleSwitch(
                                            minWidth: 90.0,
                                            minHeight: 90.0,
                                            fontSize: 16.0,
                                            initialLabelIndex: index,
                                            activeBgColor: [Colors.green],
                                            activeFgColor: Colors.white,
                                            inactiveFgColor: Colors.grey[900],
                                            totalSwitches: list.length,
                                            icons: const [
                                              Symbols.female_rounded,
                                              Symbols.male_rounded,
                                            ],
                                            labels: [...list],
                                            onToggle: (index) {
                                              index = index!;
                                              setState(() {
                                                data["data"]!.gender = index;
                                              });
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
                                          var json = data["data"]!.toJson();
                                          var pushdata =
                                              AccountsEntity.fromJson(json);
                                          data["data"] = pushdata;
                                          logic.updateData(json);
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
                              titleText: "网站管理员",
                              subTitleText:
                                  data["data"]!.webadmin.toString() == "1"
                                      ? "是"
                                      : "否",
                              icon: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                _showDialog("网站管理员", "webadmin",
                                    defaultValue:
                                        data["data"]!.webadmin.toString(),
                                    context: context,
                                    type: WidgetType.toggle);
                              }),
                          SQListTile(
                            titleText: "站内名称",
                            subTitleText: data["data"]!.nick.toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("站内名称", "nick",
                                  defaultValue: data["data"]!.nick.toString(),
                                  context: context,
                                  type: WidgetType.input,
                                  inputType: InputType.text);
                            },
                          ),
                          SQListTile(
                            titleText: "禁言",
                            subTitleText: data["data"]!.mute.toString() == "1"
                                ? "是"
                                : "否",
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("禁言", "mute",
                                  defaultValue: data["data"]!.mute.toString(),
                                  context: context,
                                  type: WidgetType.toggle);
                            },
                          ),
                          SQListTile(
                            titleText: "Email",
                            subTitleText: data["data"]!.email.toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("Email", "email",
                                  defaultValue: data["data"]!.email.toString(),
                                  context: context,
                                  type: WidgetType.input,
                                  inputType: InputType.text);
                            },
                          ),
                          SQListTile(
                            titleText: "奖励点数",
                            subTitleText: data["data"]!.rewardpoints.toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("奖励点数", "rewardpoints",
                                  defaultValue:
                                      data["data"]!.rewardpoints.toString(),
                                  context: context,
                                  type: WidgetType.input,
                                  inputType: InputType.number);
                            },
                          ),
                          SQListTile(
                            titleText: "投票点数",
                            subTitleText: data["data"]!.votepoints.toString(),
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              _showDialog("投票点数", "votepoints",
                                  defaultValue:
                                      data["data"]!.votepoints.toString(),
                                  context: context,
                                  type: WidgetType.input,
                                  inputType: InputType.number);
                            },
                          ),
                          SQListTile(
                            titleText: "语言",
                            subTitleText:
                                data["data"]!.language == 3 ? "中文" : "English",
                            icon: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              //true是中文false是英语
                              bool selevtValue = data["data"]!.language == 3;
                              if (data["data"]!.language.toString() == "3") {
                                //true和1是 真 其他是0 和 false 是假 其他则 都为假
                                selevtValue = data["data"]!.language == 3;
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
                                          data["data"]!.language = 3;
                                        } else {
                                          data["data"]!.language = 2;
                                        }
                                        var json = data["data"]!.toJson();
                                        var pushdata =
                                            AccountsEntity.fromJson(json);
                                        data["data"] = pushdata;
                                        logic.updateData(json);
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
