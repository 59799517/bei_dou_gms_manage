import 'dart:async';

import 'package:bei_dou_gms_manage/api/page/LoginApi.dart';
import 'package:bei_dou_gms_manage/storage/DBStorage.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginLogic extends GetxController {
  final TextEditingController baseUrl = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  var timer;
  int moveIndex = 0;

  ////蜗牛动画
  //素材列表
  List<String> images = [
    "move.0._outlink.png",
    "move.1._outlink.png",
    "move.2._outlink.png",
    "move.3._outlink.png"
  ];

  void reqLogin() {


    if (baseUrl.text.isEmpty) {
      BotToast.showText(text: "请输入域名");
      return;
    }
    if (username.text.isEmpty) {
      BotToast.showText(text: "请输入用户名");
      return;
    }
    if (password.text.isEmpty) {
      BotToast.showText(text: "请输入密码");
      return;
    }
    var login = LoginApi.instance?.Login(username.text, password.text);
    login.then((value) {
      if (value["code"] == 20000) {
        BDStorage().setToken(value["data"]["token"]);
        BDStorage().setBaseUrl(this.baseUrl.text);
        BDStorage().setUsername(this.username.text);
        BDStorage().setPassword(this.password.text);
        var token = value["data"]["token"];
        print("token:$token");
        onClose();
        Get.offAllNamed('/home');
      } else {
        BotToast.showText(text: value["message"]);
      }
    });
  }

  //自动登录
  void autoLogin() {
    String baseUrl = BDStorage().getBaseUrl();
    String username = BDStorage().getUsername();
    String password = BDStorage().getPassword();
    if (baseUrl.isNotEmpty && username.isNotEmpty && password.isNotEmpty) {
      this.baseUrl.text = baseUrl;
      this.username.text = username;
      this.password.text = password;
      var login = LoginApi.instance?.Login(username, password);
      login.then((value) {
        if (value["code"] == 20000) {
          BDStorage().setToken(value["data"]["token"]);
          BDStorage().setBaseUrl(baseUrl);
          BDStorage().setUsername(username);
          BDStorage().setPassword(password);
          var token = value["data"]["token"];
          print("token:$token");
          onClose();
          Get.offAllNamed('/home');
        } else {
          BotToast.showText(
              text: "地址、账号、密码有可能已失效请修改后在进行登录。"); //popup a text toast;
        }
      });
    }
  }

  @override
  void onready() {
    print("login:onReady");
    String token = BDStorage().getToken();
    if (token.isNotEmpty) {
      Get.offAllNamed('/home');
    }
    super.onReady();
  }

  @override
  void onInit() {
    timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      // 重复执行的代码
      moveIndex++;
      if (moveIndex == images.length) {
        moveIndex = 0;
      }
      update(["login_image_view"]);
    });
    super.onInit();
  }

  @override
  void onReady() {
    print("login:onReady");
    super.onReady();
  }

  @override
  void onClose() {
    print("login:onClose");
    timer.cancel();
    super.onClose();
  }

  @override
  void dispose() {
    print("login:dispose");
    timer.cancel();
    super.dispose();
  }

  @override
  void onDetached() {
    print("login:onDetached");
  }
}
