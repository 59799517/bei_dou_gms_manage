import 'dart:async';

import 'package:bei_dou_gms_manage/page/login/logic.dart';
import 'package:bei_dou_gms_manage/storage/DBStorage.dart';
import 'package:bei_dou_gms_manage/theme/SqColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:modular_ui/modular_ui.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final LoginLogic logic = Get.put(LoginLogic());

  @override
  void initState() {
    super.initState();
    String baseUrl = BDStorage().getBaseUrl();
    String username = BDStorage().getUsername();
    String password = BDStorage().getPassword();
    logic.baseUrl.text = baseUrl;
    logic.username.text= username;
    logic.password.text= password;
    logic.autoLogin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/login_image2.png"),
              fit: BoxFit.fitHeight)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                child: Text('BeiDou',
                    style: TextStyle(color: SqColors.primary, fontSize: 40)),
                margin: EdgeInsets.only(top: 200, bottom: 30),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: MUIPrimaryInputField(
                  suffixIcon: const Icon(
                    Symbols.room_service_rounded,
                    color: SqColors.primary,
                  ),
                  textStyle: TextStyle(color: Colors.black, fontSize: 20),
                  hintText: 'http// or https://',
                  controller: logic.baseUrl,
                  filledColor: Colors.transparent,
                  cursorColor: SqColors.primary,
                  disabledBorderColor: Colors.white54,

                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: MUIPrimaryInputField(
                  suffixIcon: const Icon(
                    Symbols.user_attributes_rounded,
                    color: SqColors.primary,
                  ),
                  textStyle: TextStyle(color: Colors.black, fontSize: 20),
                  hintText: 'userName',
                  controller: logic.username,
                  filledColor: Colors.transparent,
                  cursorColor: SqColors.primary,
                  disabledBorderColor: Colors.white54,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: MUIPrimaryInputField(
                  suffixIcon: const Icon(
                    Symbols.password_rounded,
                    color: SqColors.primary,
                  ),
                  textStyle: TextStyle(color: Colors.black, fontSize: 20),
                  hintText: 'password',
                  controller: logic.password,
                  filledColor: Colors.transparent,
                  cursorColor: SqColors.primary,
                  disabledBorderColor: Colors.white54,
                  isObscure: true,
                ),
              ),
              Container(
                  width: 60,
                  height: 60,
                  margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                            color: SqColors.primary,
                            offset: Offset(0.0, 0.0),
                            //阴影xy轴偏移量
                            blurRadius: 100.0,
                            //阴影模糊程度
                            spreadRadius: 40.0 //阴影扩散程度
                            )
                      ]),
                  child: GetBuilder<LoginLogic>(
                      id: "login_image_view",
                      builder: (logic) {
                        return InkWell(
                            onTap: () {
                              logic.reqLogin();
                            },
                            child: Image.asset(
                              "assets/images/${logic.images[logic.moveIndex.toInt()]}",
                              fit: BoxFit.contain,
                            ));
                      }))
            ],
          ),

          // Text("下边的注释")
        ],
      ),
    ));
  }
}
